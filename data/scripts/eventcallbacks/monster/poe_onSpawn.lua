local ec = EventCallback

dofile('data/lib/poe_monster_rarity.lua')

local function resolveRarity(monster)
    if not monster then
        return nil
    end

    local rarity = PoeMonsterRarity.defineMonsterRarity(monster)
    if rarity then
        return rarity
    end

    return nil
end

ec.onSpawn = function(self, position, startup, artificial)
    self:registerEvent("PoeCombat")

    local rarityKey = resolveRarity(self)
    if rarityKey then
        local skullType = PoeMonsterRarity.getSkullForRarity(rarityKey)
        if skullType then
            self:setSkull(skullType)
        end
    end

    return true
end

ec.onDisappear = function(self, creature)
    PoeMonsterRarity.clearMonsterRarity(self)
    return true
end


ec:register()
