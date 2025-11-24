-- data/lib/poe_monster_rarity.lua

PoeMonsterRarity = PoeMonsterRarity or {}
PoeMonsterRarity._monsterRarity = PoeMonsterRarity._monsterRarity or {}

PoeMonsterRarity.RARITIES = {
    normal = { name = "Normal", skull = SKULL_NONE },
    magic = { name = "Magic", skull = SKULL_GREEN },
    rare = { name = "Rare", skull = SKULL_YELLOW },
    unique = { name = "Unique", skull = SKULL_ORANGE },
}

local function normalizeKey(rarityKey)
    if type(rarityKey) ~= "string" then
        return nil
    end

    local normalized = rarityKey:lower()
    if PoeMonsterRarity.RARITIES[normalized] then
        return normalized
    end

    return nil
end

function PoeMonsterRarity.setMonsterRarity(monster, rarityKey)
    if not monster then
        return nil
    end

    local normalized = normalizeKey(rarityKey)
    if not normalized then
        return nil
    end

    local cid = monster:getId()
    PoeMonsterRarity._monsterRarity[cid] = normalized
    return normalized
end

function PoeMonsterRarity.getMonsterRarity(monster)
    if not monster then
        return nil
    end

    local cid = monster:getId()
    return PoeMonsterRarity._monsterRarity[cid]
end

local function resolveFromCustomAttributes(monster)
    if monster.getCustomAttribute then
        local stored = monster:getCustomAttribute("poeRarity") or monster:getCustomAttribute("rarity")
        if stored then
            return normalizeKey(stored)
        end
    end

    return nil
end

function PoeMonsterRarity.defineMonsterRarity(monster)
    if not monster then
        return nil
    end

    local existing = PoeMonsterRarity.getMonsterRarity(monster)
    if existing then
        return existing
    end

    local fromAttributes = resolveFromCustomAttributes(monster)
    if fromAttributes then
        return PoeMonsterRarity.setMonsterRarity(monster, fromAttributes)
    end

    return PoeMonsterRarity.setMonsterRarity(monster, "normal")
end

function PoeMonsterRarity.getSkullForRarity(rarityKey)
    local normalized = normalizeKey(rarityKey)
    local rarityConfig = normalized and PoeMonsterRarity.RARITIES[normalized]
    return rarityConfig and rarityConfig.skull or nil
end

function PoeMonsterRarity.clearMonsterRarity(monster)
    if not monster then
        return
    end

    PoeMonsterRarity._monsterRarity[monster:getId()] = nil
end
