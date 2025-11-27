-- data/lib/poe_monster_loot.lua
-- Biblioteca de loot baseada em level e raridade dos monstros
-- A loot table agora é carregada a partir de um XML em data/XML/poe_monster_loot.xml.
-- Consulte o arquivo para a estrutura de configuração (chance por level e raridade).
--
-- Cálculo rápido de chance:
--   * Chance final = chanceBase * multRaridade(chanceByRarity) * multLevel(chanceByLevel) * RATE_LOOT (sempre
--     limitada entre 0-100, garantindo que não ultrapasse 100%).
--   * Quantidade   = sempre 1. Para múltiplas unidades do mesmo item, o sistema rerrola a chance
--     com penalidade progressiva (2º item 2x mais raro, 3º item 3x mais raro, etc.).
-- Valores de multiplicadores são percentuais (ex.: 120 = 1.2x). Ausência = 100% (1.0x).

PoEMonsterLoot = PoEMonsterLoot or {}
local Loot = PoEMonsterLoot

local Rarity = PoEMonsterRarity

-- Estrutura de exemplo. Ajuste conforme necessidade do servidor.
-- Cada entrada aceita:
--  * itemId             -> ID do item a ser dropado
--  * minLevel / maxLevel -> Level mínimo/máximo do monstro para habilitar o drop
--  * chance             -> Chance base em porcentagem (0-100)
--  * chanceByRarity     -> multiplicadores de chance por raridade (em %)
--  * chanceByLevel      -> multiplicadores de chance por level (em %)
-- Quantidade fixa em 1; múltiplas cópias nascem de rerolls sucessivos com penalidade progressiva.
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

    local chanceByRarityTag = itemBody:match("<chanceByRarity%s*(.-)%s*/>%s*")
    if chanceByRarityTag then
        entry.chanceByRarity = parseRarityMap(parseAttributes(chanceByRarityTag))
    end

    local chanceByLevelBody = itemBody:match("<chanceByLevel>(.-)</chanceByLevel>")
    if chanceByLevelBody then
        entry.chanceByLevel = parseLevelRanges(chanceByLevelBody)
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
    end
    return value
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

    -- Média de múltiplos rolls cria uma distribuição triangular, favorecendo
    -- valores centrais sem abrir mão da raridade nos extremos altos.
    -- Mantém baixa a chance de alcançar o item level máximo, mas reduz
    -- drasticamente a incidência de nível 1.
    local roll = (math.random() + math.random() + math.random()) / 3
    return math.max(1, math.min(monsterLevel, math.floor((monsterLevel - 1) * roll + 1)))
end

local function buildRarityWeights(monsterLevel, monsterRank)
    local maxLevel = (Rarity and Rarity.MAX_LEVEL) or 100
    local clampedLevel = math.max(1, math.min(math.floor(monsterLevel or 1), maxLevel))
    local levelFactor = (clampedLevel - 1) / math.max(1, (maxLevel - 1))

    -- Chances baseadas no comando /rollpoe
    local weights = {
        normal = 60,
        magic = 25,
        rare = 12,
        unique = 3,
    }

    -- Conforme o level do monstro sobe, migramos parte do peso de normal
    -- para raridades maiores, mantendo unique ainda raro.
    local bonusMagic = 20 * levelFactor
    local bonusRare = 12 * levelFactor
    local bonusUnique = 5 * levelFactor

    weights.magic = weights.magic + bonusMagic
    weights.rare = weights.rare + bonusRare
    weights.unique = weights.unique + bonusUnique
    weights.normal = math.max(5, weights.normal - (bonusMagic + bonusRare + bonusUnique))

    -- Raridades de monstros aumentam a chance de itens mais raros.
    local rankMultiplier = {
        [Rarity and Rarity.RANK.MAGIC or "Magic"] = 1.15,
        [Rarity and Rarity.RANK.RARE or "Rare"] = 1.35,
        [Rarity and Rarity.RANK.UNIQUE or "Unique"] = 1.6,
        [Rarity and Rarity.RANK.NORMAL or "Normal"] = 1.0,
    }

    local rarityBoost = rankMultiplier[monsterRank] or 1.0
    weights.magic = weights.magic * rarityBoost
    weights.rare = weights.rare * (1 + (rarityBoost - 1) * 0.85)
    weights.unique = weights.unique * (1 + (rarityBoost - 1) * 1.1)
    weights.normal = weights.normal / rarityBoost

    return weights
end

local function rollItemRarity(monsterLevel, monsterRank)
    local weights = buildRarityWeights(monsterLevel, monsterRank)
    local totalWeight = 0
    for _, value in pairs(weights) do
        totalWeight = totalWeight + (value or 0)
    end

    if totalWeight <= 0 then
        return "normal"
    end

    local roll = math.random() * totalWeight
    local accumulator = 0

    accumulator = accumulator + weights.normal
    if roll <= accumulator then
        return "normal"
    end

    accumulator = accumulator + weights.magic
    if roll <= accumulator then
        return "magic"
    end

    accumulator = accumulator + weights.rare
    if roll <= accumulator then
        return "rare"
    end

    return "unique"
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

local function calculateDropCount(chancePercent)
    chancePercent = clampChance(chancePercent)

    local guaranteedDrops = math.floor(chancePercent / 100)
    local remainder = chancePercent - (guaranteedDrops * 100)

    local dropCount = guaranteedDrops
    if remainder > 0 then
        -- precisão de duas casas decimais
        local roll = math.random(0, 10000) / 100
        if roll <= remainder then
            dropCount = dropCount + 1
        end
    end

    return dropCount
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

-- Quantidade fixa: múltiplos itens do mesmo tipo são conseguidos via rerolls sucessivos.
local function calculateAmount()
    return 1
end

local function buildLootResult(entry, monster)
    local itemId = entry.itemId or entry.id
    local monsterLevel = getLootLevel(monster)
    local itemLevel = rollItemLevel(monsterLevel)
    local itemRarity = rollItemRarity(monsterLevel, getLootRarity(monster))

    return {
        itemId = itemId,
        id = itemId,
        count = calculateAmount(),
        itemLevel = itemLevel,
        itemRarity = itemRarity
    }
end

function Loot.rollItem(entry, monster, chanceScale)
    if type(entry) ~= "table" then
        return nil
    end

    if not (entry.itemId or entry.id) then
        return nil
    end

    local monsterLevel = getLootLevel(monster)
    if not isLevelAllowed(entry, monsterLevel) then
        return nil
    end

    local adjustedChance = calculateAdjustedChance(entry, getLootRarity(monster), monsterLevel)
    if chanceScale and chanceScale > 0 then
        adjustedChance = adjustedChance / chanceScale
    end

    local dropCount = calculateDropCount(adjustedChance)
    if dropCount <= 0 then
        return nil
    end

    local lootResults = {}
    for _ = 1, dropCount do
        table.insert(lootResults, buildLootResult(entry, monster))
    end

    return lootResults
end

function Loot.rollLoot(monster)
    if not monster or not monster:isMonster() then
        return {}
    end

    local generated = {}
    local dropCountsByItemId = {}
    -- Penalidade de chance aplicada apenas a múltiplos drops do mesmo item

    for _, entry in ipairs(Loot.LOOT_TABLE) do
        local itemId = entry.itemId or entry.id
        local previousDrops = (itemId and dropCountsByItemId[itemId]) or 0

        while true do
            local chanceScale = (itemId and previousDrops > 0) and (previousDrops + 1) or nil
            local lootItems = Loot.rollItem(entry, monster, chanceScale)

            if not lootItems then
                break
            end

            for _, lootItem in ipairs(lootItems) do
                table.insert(generated, lootItem)

                if itemId then
                    previousDrops = previousDrops + 1
                    dropCountsByItemId[itemId] = previousDrops
                end
            end

            if not itemId then
                break
            end
        end
    end

    return generated
end

function Loot.rollItemLevel(monsterLevel)
    return rollItemLevel(monsterLevel)
end

function Loot.rollItemRarity(monsterLevel, monsterRank)
    return rollItemRarity(monsterLevel, monsterRank)
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
