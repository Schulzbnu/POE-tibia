dofile('data/lib/poe_itemmods.lua')

local ec = EventCallback

local RARITY_SKULL_MAP = {
    normal = SKULL_NONE,
    magic = SKULL_GREEN,
    rare = SKULL_YELLOW,
    unique = SKULL_ORANGE,
}

local function resolveRarity(monster)
    if not monster then
        return nil
    end

    local rarity = monster.getRarity and monster:getRarity()
    if rarity then
        return rarity
    end

    if monster.getCustomAttribute then
        local customRarity = monster:getCustomAttribute("poeRarity") or monster:getCustomAttribute("rarity")
        if customRarity then
            return customRarity
        end
    end

    return nil
end

ec.onSpawn = function(self, position, startup, artificial)
    self:registerEvent("PoeCombat")

    local rarityKey = resolveRarity(self)
    if rarityKey and type(rarityKey) == "string" then
        local normalized = rarityKey:lower()
        local rarityConfig = PoeItemMods.RARITIES and PoeItemMods.RARITIES[normalized]
        if rarityConfig then
            local skullType = RARITY_SKULL_MAP[normalized]
            if skullType then
                self:setSkull(skullType)
            end
        end
    end

    return true
end


ec:register()
