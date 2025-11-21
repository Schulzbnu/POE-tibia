-- Monster rarity/level utilities

MonsterRarity = MonsterRarity or {}

MonsterRarity.DEFAULT_LEVEL = 1
MonsterRarity.DEFAULT_RARITY = "normal"

MonsterRarity.STORAGE_LEVEL = 91000
MonsterRarity.STORAGE_RARITY = 91001

MonsterRarity.RARITIES = {
        normal = { id = 1, label = "normal" },
        magic = { id = 2, label = "magic" },
        rare = { id = 3, label = "rare" },
        unique = { id = 4, label = "unique" }
}

MonsterRarity.DISPLAY_COLORS = {
        normal = "white",
        magic = "blue",
        rare = "yellow",
        unique = "purple",
}

MonsterRarity.RARITY_BY_ID = {}
for name, rarity in pairs(MonsterRarity.RARITIES) do
        MonsterRarity.RARITY_BY_ID[rarity.id] = name
end

function MonsterRarity.resolveRarityId(rarity)
        if type(rarity) == "string" then
                local normalized = rarity:lower()
                local rarityData = MonsterRarity.RARITIES[normalized]
                if rarityData then
                        return rarityData.id
                end
        elseif type(rarity) == "number" then
                if MonsterRarity.RARITY_BY_ID[rarity] then
                        return rarity
                end
        end

        return MonsterRarity.RARITIES[MonsterRarity.DEFAULT_RARITY].id
end

function MonsterRarity.validateLevel(level)
        local parsedLevel = tonumber(level) or MonsterRarity.DEFAULT_LEVEL
        parsedLevel = math.max(MonsterRarity.DEFAULT_LEVEL, math.floor(parsedLevel))
        return parsedLevel
end

function MonsterRarity.setMonsterLevel(monster, level)
        local finalLevel = MonsterRarity.validateLevel(level)
        monster:setStorageValue(MonsterRarity.STORAGE_LEVEL, finalLevel)
        return finalLevel
end

function MonsterRarity.setMonsterRarity(monster, rarity)
        local rarityId = MonsterRarity.resolveRarityId(rarity)
        monster:setStorageValue(MonsterRarity.STORAGE_RARITY, rarityId)
        return rarityId
end

function MonsterRarity.ensureValues(monster, rarity, level)
        local storedRarity = monster:getStorageValue(MonsterRarity.STORAGE_RARITY)
        if storedRarity < 0 then
                storedRarity = MonsterRarity.setMonsterRarity(monster, rarity)
        end

        local storedLevel = monster:getStorageValue(MonsterRarity.STORAGE_LEVEL)
        if storedLevel < 0 then
                storedLevel = MonsterRarity.setMonsterLevel(monster, level)
        end

        return storedRarity, storedLevel
end

function MonsterRarity.getMonsterRarity(monster)
        local rarityId = monster:getStorageValue(MonsterRarity.STORAGE_RARITY)
        if rarityId < 0 then
                return MonsterRarity.RARITIES[MonsterRarity.DEFAULT_RARITY]
        end

        return MonsterRarity.RARITIES[MonsterRarity.RARITY_BY_ID[rarityId]]
end

function MonsterRarity.getMonsterLevel(monster)
        local level = monster:getStorageValue(MonsterRarity.STORAGE_LEVEL)
        if level < 0 then
                return MonsterRarity.DEFAULT_LEVEL
        end

        return level
end

local function capitalize(text)
        return text:gsub("^%l", string.upper)
end

function MonsterRarity.formatName(monster, rarityId, level)
        local rarityName = MonsterRarity.RARITY_BY_ID[rarityId] or MonsterRarity.DEFAULT_RARITY
        local rarityData = MonsterRarity.RARITIES[rarityName]
        local rarityLabel = rarityData and rarityData.label or rarityName
        local color = MonsterRarity.DISPLAY_COLORS[rarityName]

        local baseName = string.format("[%d] %s", MonsterRarity.validateLevel(level), capitalize(rarityLabel))

        if color then
                return string.format("{%s, %s}", baseName, color)
        end

        return baseName
end
