-- data/lib/poe_itemmods.lua

PoeItemMods = PoeItemMods or {}
PoeItemMods.ITEM_LEVEL_KEY = "poeItemLevel"
PoeItemMods.MOD_INDEX = {}

local function clampItemLevel(level)
    local maxLevel = (PoEMonsterRarity and PoEMonsterRarity.MAX_LEVEL) or 100
    local normalized = tonumber(level) or 1

    if normalized < 1 then
        normalized = 1
    end

    if normalized > maxLevel then
        normalized = maxLevel
    end

    return math.floor(normalized)
end

function PoeItemMods.setItemLevel(item, level)
    if not item then
        return
    end

    item:setCustomAttribute(PoeItemMods.ITEM_LEVEL_KEY, clampItemLevel(level))
end

function PoeItemMods.getItemLevel(item)
    if not item then
        return 1
    end

    local stored = item:getCustomAttribute(PoeItemMods.ITEM_LEVEL_KEY)
    if not stored then
        return 1
    end

    return clampItemLevel(stored)
end

-- Slots que vamos considerar para somar os atributos
PoeItemMods.EQUIP_SLOTS = {
    CONST_SLOT_HEAD,
    CONST_SLOT_ARMOR,
    CONST_SLOT_LEGS,
    CONST_SLOT_FEET,
    CONST_SLOT_RIGHT,   -- weapon / shield
    CONST_SLOT_LEFT,    -- weapon / shield / quiver dependendo do server
    CONST_SLOT_RING,
    CONST_SLOT_NECKLACE,
}

-- Raridades e máximo de mods
PoeItemMods.RARITIES = {
    normal = {
        name = "Normal",
        maxMods = 0,
        color = "white",
    },
    magic = {
        name = "Magic",
        maxMods = 2,
        color = "lightblue",
    },
    rare = {
        name = "Rare",
        maxMods = 4,
        color = "yellow",
    },
    unique = {
        name = "Unique",
        maxMods = 6,
        color = "orange",
    },
}

-- Tipos de item que podem receber mods PoE
PoeItemMods.ITEM_TYPES = {
    weapon = { slots = { CONST_SLOT_RIGHT, CONST_SLOT_LEFT } },
    armor  = { slots = { CONST_SLOT_HEAD, CONST_SLOT_ARMOR, CONST_SLOT_LEGS, CONST_SLOT_FEET } },
    shield = { slots = { CONST_SLOT_RIGHT, CONST_SLOT_LEFT } },
    ring   = { slots = { CONST_SLOT_RING } },
    amulet = { slots = { CONST_SLOT_NECKLACE } },
}

-- Helper: mapeia itemId para tipo (você ajusta depois)
-- Aqui você pode só mapear por slot via script, mas deixo hook para itemId se quiser
function PoeItemMods.getItemType(item)
    if not item then
        return nil
    end

    local itemType = ItemType(item:getId())
    if not itemType then
        return nil
    end

    -- 1) Armas e escudos (shield é um tipo de weapon no TFS)
    local weaponType = itemType:getWeaponType()
    if weaponType and weaponType ~= WEAPON_NONE then
        if weaponType == WEAPON_SHIELD then
            return "shield"   -- usa PoeItemMods.MOD_POOLS.shield
        else
            return "weapon"   -- usa PoeItemMods.MOD_POOLS.weapon
        end
    end

    -- 2) Demais equipamentos por slot permitido
    -- getSlotPosition() retorna um "slot mask" com SLOTP_*.
        -- Head / Armor / Legs / Feet => tratamos tudo como "armor"
    if itemType:usesSlot(CONST_SLOT_HEAD)
        or itemType:usesSlot(CONST_SLOT_ARMOR)
        or itemType:usesSlot(CONST_SLOT_LEGS)
        or itemType:usesSlot(CONST_SLOT_FEET)
    then
        return "armor"
    end

    if itemType:usesSlot(CONST_SLOT_RING) then
        return "ring"         -- PoeItemMods.MOD_POOLS.ring
    end

    if itemType:usesSlot(CONST_SLOT_NECKLACE) then
        return "amulet"       -- PoeItemMods.MOD_POOLS.amulet
    end
    -- Se não bateu em nada, não recebe mods PoE
    return nil
end

local function getTierPoolForLevel(tiers, itemLevel)
    if type(tiers) ~= "table" or #tiers == 0 then
        return {}
    end

    local sorted = {}
    for index, tier in ipairs(tiers) do
        sorted[index] = tier
    end

    table.sort(sorted, function(a, b)
        return (a.tier or 999) < (b.tier or 999)
    end)

    local maxLevel = (PoEMonsterRarity and PoEMonsterRarity.MAX_LEVEL) or 100
    local normalized = clampItemLevel(itemLevel) / maxLevel
    local unlockedCount = math.max(1, math.ceil(normalized * #sorted))
    local startIndex = math.max(1, #sorted - unlockedCount + 1)

    local pool = {}
    for index = startIndex, #sorted do
        table.insert(pool, sorted[index])
    end

    return pool
end

function PoeItemMods.rollTierForLevel(tiers, itemLevel)
    local pool = getTierPoolForLevel(tiers, itemLevel)
    if #pool == 0 then
        return nil
    end

    return pool[math.random(#pool)]
end


-- Pool de mods por tipo de item
-- Cada mod: id, descrição, onde aplica, tiers com min/max
PoeItemMods.MOD_POOLS = {
    weapon = {
        -- ofensivos
        {
            id = "critChance",
            text = "%d%% critical chance",
            category = "offense",
            tiers = {
                { tier = 1, min = 8, max = 10 },
                { tier = 2, min = 5, max = 7  },
                { tier = 3, min = 3, max = 4  },
            },
        },
        {
            id = "lifeLeech",
            text = "%d%% of damage leeched as life",
            category = "offense",
            tiers = {
                { tier = 1, min = 4, max = 5 },
                { tier = 2, min = 2, max = 3 },
                { tier = 3, min = 1, max = 1 },
            },
        },
        {
            id = "manaRegen",
            text = "+%d mana regenerated",
            category = "utility",
            tiers = {
                { tier = 1, min = 20, max = 30 },
                { tier = 2, min = 10, max = 19 },
                { tier = 3, min = 5,  max = 9  },
            },
        },
        {
            id = "manaLeech",
            text = "%d%% of damage leeched as mana",
            category = "offense",
            tiers = {
                { tier = 1, min = 4, max = 5 },
                { tier = 2, min = 2, max = 3 },
                { tier = 3, min = 1, max = 1 },
            },
        },
        {
            id = "critMulti",
            text = "+%d%% critical damage",
            category = "offense",
            tiers = {
                { tier = 1, min = 30, max = 50 },
                { tier = 2, min = 15, max = 29 },
                { tier = 3, min = 10, max = 14 },
            },
        },
        {
            id = "fireDamage",
            text = "+%d fire damage",
            category = "offense",
            tiers = {
                { tier = 1, min = 25, max = 35 },
                { tier = 2, min = 15, max = 24 },
                { tier = 3, min = 5,  max = 14 },
            },
        },
        {
            id = "iceDamage",
            text = "+%d ice damage",
            category = "offense",
            tiers = {
                { tier = 1, min = 25, max = 35 },
                { tier = 2, min = 15, max = 24 },
                { tier = 3, min = 5,  max = 14 },
            },
        },
        {
            id = "energyDamage",
            text = "+%d energy damage",
            category = "offense",
            tiers = {
                { tier = 1, min = 25, max = 35 },
                { tier = 2, min = 15, max = 24 },
                { tier = 3, min = 5,  max = 14 },
            },
        },
        {
            id = "earthDamage",
            text = "+%d earth damage",
            category = "offense",
            tiers = {
                { tier = 1, min = 25, max = 35 },
                { tier = 2, min = 15, max = 24 },
                { tier = 3, min = 5,  max = 14 },
            },
        },
        -- pode adicionar dano elemental, etc
    },

    armor = {
        {
            id = "maxLife",
            text = "+%d maximum life",
            category = "defense",
            tiers = {
                { tier = 1, min = 80, max = 100 },
                { tier = 2, min = 50, max = 79  },
                { tier = 3, min = 30, max = 49  },
            },
        },
        {
            id = "lifeRegen",
            text = "+%d life regenerated",
            category = "utility",
            tiers = {
                { tier = 1, min = 20, max = 30 },
                { tier = 2, min = 10, max = 19 },
                { tier = 3, min = 5,  max = 9  },
            },
        },
    },

    shield = {
        {
            id = "blockChance",
            text = "%d%% chance to block",
            category = "defense",
            tiers = {
                { tier = 1, min = 3, max = 6 },
                { tier = 2, min = 5,  max = 8  },
                { tier = 3, min = 7,  max = 10 },
            },
        },
    },

    ring = {
        {
            id = "critChance",
            text = "%d%% critical chance",
            category = "offense",
            tiers = {
                { tier = 1, min = 4, max = 5 },
                { tier = 2, min = 2, max = 3 },
                { tier = 3, min = 1, max = 1 },
            },
        },
        {
            id = "lifeRegen",
            text = "+%d life regenerated",
            category = "utility",
            tiers = {
                { tier = 1, min = 10, max = 15 },
                { tier = 2, min = 5,  max = 9  },
            },
        },
        {
            id = "maxMana",
            text = "+%d maximum mana",
            category = "utility",
            tiers = {
                { tier = 1, min = 60, max = 80 },
                { tier = 2, min = 40, max = 59 },
                { tier = 3, min = 20, max = 39 },
            },
        },
    },

    amulet = {
        {
            id = "movespeed",
            text = "+%d movement speed",
            category = "utility",
            tiers = {
                { tier = 1, min = 200, max = 200 },
                { tier = 2, min = 200, max = 200 },
                { tier = 3, min = 200, max = 200 },
            },
        },
    },
}

for poolName, pool in pairs(PoeItemMods.MOD_POOLS) do
    for _, mod in ipairs(pool) do
        PoeItemMods.MOD_INDEX[mod.id] = mod
    end
end

local function resolveModText(modEntry, item)
    if not modEntry then
        return nil
    end

    if modEntry.text then
        return modEntry.text
    end

    local definition = PoeItemMods.MOD_INDEX[modEntry.id]
    if not definition or not definition.text or not modEntry.value then
        return nil
    end

    return string.format(definition.text, modEntry.value)
end

local function buildBaseDescription(item)
    local itemType = item and ItemType(item:getId())
    if not itemType then
        return ""
    end

    return itemType:getDescription() or ""
end

function PoeItemMods.buildDescription(item, rarityKey, mods)
    if not item then
        return ""
    end

    local descLines = {}
    local rarity = PoeItemMods.RARITIES[rarityKey]
    local rarityName = rarity and rarity.name or nil

    if rarityName then
        table.insert(descLines, string.format("%s item", rarityName))
    end

    table.insert(descLines, string.format("Item Level: %d", PoeItemMods.getItemLevel(item)))

    if mods then
        for _, mod in ipairs(mods) do
            local modText = resolveModText(mod, item)
            if modText then
                table.insert(descLines, modText)
            end
        end
    end

    local baseDescription = buildBaseDescription(item)
    if baseDescription ~= "" then
        if #descLines > 0 then
            table.insert(descLines, "")
        end
        table.insert(descLines, baseDescription)
    end

    return table.concat(descLines, "\n")
end

function PoeItemMods.applyItemDescription(item, rarityKey, mods)
    if not item then
        return
    end

    local description = PoeItemMods.buildDescription(item, rarityKey, mods)
    item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description)
end


-- ========= Helpers de encode/decode em customAttribute "poeMods" ==========

-- mods = { { id="critChance", tier=1, value=8 }, ... }
function PoeItemMods.encodeMods(mods)
    local parts = {}
    for _, m in ipairs(mods) do
        table.insert(parts, string.format("%s:%d:%d", m.id, m.tier, m.value))
    end
    return table.concat(parts, ";")
end

function PoeItemMods.decodeMods(str)
    local mods = {}
    if not str or str == "" then
        return mods
    end
    for entry in string.gmatch(str, "([^;]+)") do
        local id, tier, value = entry:match("([^:]+):([^:]+):([^:]+)")
        if id and tier and value then
            table.insert(mods, {
                id = id,
                tier = tonumber(tier) or 1,
                value = tonumber(value) or 0
            })
        end
    end
    return mods
end

function PoeItemMods.clearItemMods(item)
    if not item then
        return
    end
    item:setCustomAttribute("poeRarity", nil)
    item:setCustomAttribute("poeMods", nil)
end

function PoeItemMods.setItemMods(item, rarityKey, mods)
    if not item then
        return
    end
    mods = mods or {}
    item:setCustomAttribute("poeRarity", rarityKey)
    item:setCustomAttribute("poeMods", PoeItemMods.encodeMods(mods))
    PoeItemMods.applyItemDescription(item, rarityKey, mods)
end

function PoeItemMods.getItemMods(item)
    if not item then
        return nil, {}
    end
    local rarity = item:getCustomAttribute("poeRarity")
    local modsStr = item:getCustomAttribute("poeMods")
    local mods = PoeItemMods.decodeMods(modsStr)
    return rarity, mods
end

function PoeItemMods.debugItem(player)
    for _, slot in ipairs(PoeItemMods.EQUIP_SLOTS) do
        local item = player:getSlotItem(slot)
        if item then
            local rarity, mods = PoeItemMods.getItemMods(item)
            print("ITEM:", item:getId(), "rarity:", rarity)

            if mods then
                for k,v in pairs(mods) do
                    print("   -> mod", k, v.id, v.value)
                end
            else
                print("   -> sem mods")
            end
        else
            print("EMPTY SLOT", slot)
        end
    end
end

