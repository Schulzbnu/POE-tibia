local ec = EventCallback

local function getRequestedValues(monster)
        local rarity = monster:getCustomAttribute and monster:getCustomAttribute("rarity")
        local level = monster:getCustomAttribute and monster:getCustomAttribute("level")
        return rarity, level
end

ec.onSpawn = function(monster, position, startup, artificial)
        local rarity, level = getRequestedValues(monster)
        local rarityId, finalLevel = MonsterRarity.ensureValues(monster, rarity, level)

        local displayName = MonsterRarity.formatName(monster, rarityId, finalLevel)
        monster:rename(displayName)

        monster:registerEvent("PoeCombat")
        return true
end

ec:register()
