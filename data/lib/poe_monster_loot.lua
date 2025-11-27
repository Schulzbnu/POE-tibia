-- data/lib/poe_monster_loot.lua
-- Biblioteca de loot baseada em level e raridade dos monstros
-- A loot table agora é carregada a partir de um XML em data/XML/poe_monster_loot.xml.
-- Consulte o arquivo para a estrutura de configuração (amount/chance por level e raridade).
--
-- Cálculo rápido de chance e quantidade:
--   * Chance final = chanceBase * multRaridade(chanceByRarity) * multLevel(chanceByLevel) * RATE_LOOT (clamped 0-100).
--   * Quantidade   = floor(rand(amount.min-max) * multRaridade(amountByRarity) * multLevel(amountByLevel)), mínimo 1.
-- Valores de multiplicadores são percentuais (ex.: 120 = 1.2x). Ausência = 100% (1.0x).

PoEMonsterLoot = PoEMonsterLoot or {}
local Loot = PoEMonsterLoot

local Rarity = PoEMonsterRarity

-- Estrutura de exemplo. Ajuste conforme necessidade do servidor.
-- Cada entrada aceita:
--  * itemId             -> ID do item a ser dropado
--  * minLevel / maxLevel -> Level mínimo/máximo do monstro para habilitar o drop
--  * chance             -> Chance base em porcentagem (0-100)
--  * amount             -> { min = X, max = Y } define o range de quantidade
--  * chanceByRarity     -> multiplicadores de chance por raridade (em %)
--  * amountByRarity     -> multiplicadores de quantidade por raridade (em %)
--  * chanceByLevel      -> multiplicadores de chance por level (em %)
--  * amountByLevel      -> multiplicadores de quantidade por level (em %)
Loot.LOOT_TABLE = Loot.LOOT_TABLE or {}

local LOOT_XML_PATH = "data/XML/poe_monster_loot.xml"

local function parseAttributes(raw)
    local attrs = {}
    for key, value in raw:gmatch("([%w_]+)%s*=%s*\"([^\"]*)\"") do
        attrs[key] = value
    end
    return attrs
end

local function parseRarityMap(attrs)
    local map = {}
    if not Rarity or not Rarity.RANK then
        return map
    end

    for rarityKey, rarityValue in pairs(Rarity.RANK) do
        for attrKey, attrValue in pairs(attrs) do
            if attrKey:lower() == rarityKey:lower() or attrKey:lower() == rarityValue:lower() then
                map[rarityValue] = tonumber(attrValue) or tonumber(attrValue:match("^(%d+)%s*%%?$")) or nil
            end
        end
    end

    return map
end

local function parseLevelRanges(inner)
    local ranges = {}
    for rangeAttrs in inner:gmatch("<range%s*(.-)%s*/>%s*") do
        local attrs = parseAttributes(rangeAttrs)
        local minLevel = tonumber(attrs.minLevel or attrs.min_level or attrs.min or attrs.level or attrs[1])
        local maxLevel = tonumber(attrs.maxLevel or attrs.max_level or attrs.max or attrs.level or attrs[2])
        local value = tonumber(attrs.value or attrs.multiplier or attrs.percent or attrs.chance or attrs.amount or attrs[3])
        if value then
            table.insert(ranges, {
                minLevel = minLevel,
                maxLevel = maxLevel,
                value = value
            })
        end
    end
    return ranges
end

local function parseItemNode(itemAttrs, itemBody)
    local attrs = parseAttributes(itemAttrs)
    local entry = {
        itemId = tonumber(attrs.itemId or attrs.id),
        minLevel = tonumber(attrs.minLevel or attrs.min_level),
        maxLevel = tonumber(attrs.maxLevel or attrs.max_level),
        chance = tonumber(attrs.chance or attrs.dropChance)
    }

    local amountTag = itemBody:match("<amount%s*(.-)%s*/>%s*")
    if amountTag then
        local amountAttrs = parseAttributes(amountTag)
        entry.amount = {
            min = tonumber(amountAttrs.min or amountAttrs[1]),
            max = tonumber(amountAttrs.max or amountAttrs[2])
        }
    end

    local chanceByRarityTag = itemBody:match("<chanceByRarity%s*(.-)%s*/>%s*")
    if chanceByRarityTag then
        entry.chanceByRarity = parseRarityMap(parseAttributes(chanceByRarityTag))
    end

    local amountByRarityTag = itemBody:match("<amountByRarity%s*(.-)%s*/>%s*")
    if amountByRarityTag then
        entry.amountByRarity = parseRarityMap(parseAttributes(amountByRarityTag))
    end

    local chanceByLevelBody = itemBody:match("<chanceByLevel>(.-)</chanceByLevel>")
    if chanceByLevelBody then
        entry.chanceByLevel = parseLevelRanges(chanceByLevelBody)
    end

    local amountByLevelBody = itemBody:match("<amountByLevel>(.-)</amountByLevel>")
    if amountByLevelBody then
        entry.amountByLevel = parseLevelRanges(amountByLevelBody)
    end

    if entry.itemId then
        return entry
    end
    return nil
end

local function loadLootFromXML(path)
    local file = io.open(path, "r")
    if not file then
        print(string.format("[Loot] Não foi possível abrir o XML de loot: %s", path))
        return {}
    end

    local content = file:read("*a")
    file:close()

    local entries = {}
    for itemAttrs, itemBody in content:gmatch("<item%s*(.-)%s*>(.-)</item>") do
        local entry = parseItemNode(itemAttrs, itemBody)
        if entry then
            table.insert(entries, entry)
        end
    end

    if #entries == 0 then
        print(string.format("[Loot] Nenhuma entrada válida encontrada no XML: %s", path))
    end

    return entries
end

local function clampChance(value)
    if value < 0 then
        return 0
    elseif value > 100 then
        return 100
    end
    return value
end

local function normalizeAmountRange(amount)
    if type(amount) ~= "table" then
        return { min = 1, max = 1 }
    end

    local minAmount = tonumber(amount.min or amount[1] or 1) or 1
    local maxAmount = tonumber(amount.max or amount[2] or minAmount) or minAmount

    if minAmount < 1 then
        minAmount = 1
    end

    if maxAmount < minAmount then
        maxAmount = minAmount
    end

    return { min = minAmount, max = maxAmount }
end

local function getLootLevel(monster)
    if not monster then
        return 1
    end

    if Rarity and Rarity.getMonsterLevel then
        return Rarity.getMonsterLevel(monster)
    end

    return 1
end

local function rollItemLevel(monsterLevel)
    monsterLevel = math.max(1, math.floor(monsterLevel or 1))

    -- Peso enviesado para níveis mais altos: expoente grande reduz drasticamente a probabilidade de sair próximo ao limite.
    -- (ajustado para ~1/10 da chance anterior de dropar item level 90+ em um monstro nível 100)
    local biasExponent = 6.5
    local roll = math.random()

    -- Garantir que o roll nunca seja exatamente 0 para evitar ficar preso no nível 1.
    if roll <= 0 then
        roll = 0.0001
    end

    local scaled = roll ^ biasExponent
    return math.max(1, math.min(monsterLevel, math.floor((monsterLevel - 1) * scaled + 1)))
end

local function getLootRarity(monster)
    if not monster or not Rarity or not Rarity.getMonsterRank then
        return nil
    end

    return Rarity.getMonsterRank(monster)
end

local function isLevelAllowed(entry, monsterLevel)
    local minLevel = tonumber(entry.minLevel or entry.min_level or 1) or 1
    local maxLevel = tonumber(entry.maxLevel or entry.max_level or Rarity and Rarity.MAX_LEVEL or 999999) or 999999

    return monsterLevel >= minLevel and monsterLevel <= maxLevel
end

local function getChanceMultiplier(entry, rarity)
    local multipliers = entry.chanceByRarity
    if type(multipliers) ~= "table" or not rarity then
        return 1.0
    end

    local value = multipliers[rarity]
    if not value then
        return 1.0
    end

    return (tonumber(value) or 100) / 100
end

local function getAmountMultiplier(entry, rarity)
    local multipliers = entry.amountByRarity
    if type(multipliers) ~= "table" or not rarity then
        return 1.0
    end

    local value = multipliers[rarity]
    if not value then
        return 1.0
    end

    return (tonumber(value) or 100) / 100
end

local function getLevelMultiplier(levelConfig, monsterLevel)
    if type(levelConfig) ~= "table" then
        return 1.0
    end

    local directValue = levelConfig[monsterLevel]
    if directValue then
        local numeric = tonumber(directValue)
        if numeric then
            return numeric / 100
        end
    end

    for _, range in ipairs(levelConfig) do
        local minLevel = tonumber(range.minLevel or range.min_level or range.level or range[1] or 1) or 1
        local maxLevel = tonumber(range.maxLevel or range.max_level or range.level or range[2] or minLevel) or minLevel
        if monsterLevel >= minLevel and monsterLevel <= maxLevel then
            local value = tonumber(range.value or range.multiplier or range.percent or range.chance or range.amount or range[3] or range[1]) or 100
            return value / 100
        end
    end

    return 1.0
end

local function shouldDrop(chancePercent)
    chancePercent = clampChance(chancePercent)

    if chancePercent >= 100 then
        return true
    end

    -- precisão de duas casas decimais
    local roll = math.random(0, 10000) / 100
    return roll <= chancePercent
end

local function calculateAdjustedChance(entry, rarity, monsterLevel)
    local baseChance = tonumber(entry.chance or entry.dropChance or 0) or 0
    if baseChance <= 0 then
        return 0
    end

    local rateLoot = 1
    if configManager and configKeys and configKeys.RATE_LOOT then
        rateLoot = math.max(configManager.getNumber(configKeys.RATE_LOOT) or 1, 0)
    end

    local rarityMultiplier = getChanceMultiplier(entry, rarity)
    local levelMultiplier = getLevelMultiplier(entry.chanceByLevel, monsterLevel)
    return clampChance(baseChance * rarityMultiplier * levelMultiplier * rateLoot)
end

local function calculateAmount(entry, rarity, monsterLevel)
    local amountRange = normalizeAmountRange(entry.amount or entry.count or entry.countRange)
    local amount = math.random(amountRange.min, amountRange.max)
    local rarityMultiplier = getAmountMultiplier(entry, rarity)
    local levelMultiplier = getLevelMultiplier(entry.amountByLevel, monsterLevel)
    amount = math.floor(amount * rarityMultiplier * levelMultiplier)

    if amount < 1 then
        amount = 1
    end

    return amount
end

function Loot.rollItem(entry, monster)
    if type(entry) ~= "table" then
        return nil
    end

    local itemId = entry.itemId or entry.id
    if not itemId then
        return nil
    end

    local monsterLevel = getLootLevel(monster)
    local monsterRarity = getLootRarity(monster)

    if not isLevelAllowed(entry, monsterLevel) then
        return nil
    end

    local adjustedChance = calculateAdjustedChance(entry, monsterRarity, monsterLevel)
    if adjustedChance <= 0 or not shouldDrop(adjustedChance) then
        return nil
    end

    local amount = calculateAmount(entry, monsterRarity, monsterLevel)
    local itemLevel = rollItemLevel(monsterLevel)
    return { itemId = itemId, id = itemId, count = amount, itemLevel = itemLevel }
end

function Loot.rollLoot(monster)
    if not monster or not monster:isMonster() then
        return {}
    end

    local generated = {}
    for _, entry in ipairs(Loot.LOOT_TABLE) do
        local lootItem = Loot.rollItem(entry, monster)
        if lootItem then
            table.insert(generated, lootItem)
        end
    end

    return generated
end

function Loot.reloadFromXML(path)
    local entries = loadLootFromXML(path or LOOT_XML_PATH)
    if #entries > 0 then
        Loot.setLootTable(entries)
    end
end

function Loot.setLootTable(entries)
    if type(entries) ~= "table" then
        return
    end

    Loot.LOOT_TABLE = entries
end

function Loot.addLootEntry(entry)
    if type(entry) ~= "table" then
        return
    end

    table.insert(Loot.LOOT_TABLE, entry)
end

-- Carrega automaticamente do XML ao inicializar a lib
Loot.reloadFromXML()
