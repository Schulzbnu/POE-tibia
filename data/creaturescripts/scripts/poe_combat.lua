-- poe_combat.lua
-- Lê atributos PoE dos itens do atacante e aplica crítico + life leech

dofile('data/lib/poe_stats.lua')

local EQUIP_SLOTS = {
    CONST_SLOT_HEAD,
    CONST_SLOT_NECKLACE,
    CONST_SLOT_ARMOR,
    CONST_SLOT_RIGHT,
    CONST_SLOT_LEFT,
    CONST_SLOT_LEGS,
    CONST_SLOT_FEET,
    CONST_SLOT_RING,
    CONST_SLOT_AMMO
}

local function getItemPoeStatsFromDescription(item)
    local critChance = 0
    local lifeLeech = 0

    if not item then
        return critChance, lifeLeech
    end

    local desc = item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
    if not desc or desc == "" then
        return critChance, lifeLeech
    end

    -- Exatamente essas frases:
    -- "7% critical chance"
    -- "3% of damage leeched as life"

    local crit = desc:match("(%d+)%%%s*critical chance")
    if crit then
        critChance = critChance + tonumber(crit)
    end

    local leech = desc:match("(%d+)%%%s*of damage leeched as life")
    if leech then
        lifeLeech = lifeLeech + tonumber(leech)
    end

    return critChance, lifeLeech
end

local function getPlayerPoeStats(player)
    local totalCrit = 0
    local totalLeech = 0

    for _, slot in ipairs(EQUIP_SLOTS) do
        local item = player:getSlotItem(slot)
        if item then
            local c, l = getItemPoeStatsFromDescription(item)
            totalCrit = totalCrit + c
            totalLeech = totalLeech + l
        end
    end

    return totalCrit, totalLeech
end

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    -- Evento roda na VÍTIMA (creature).
    if not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Ignora cura
    if primaryType == COMBAT_HEALING then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Em TFS 1.x o dano vem sempre POSITIVO nas callbacks.
    if (primaryDamage or 0) <= 0 and (secondaryDamage or 0) <= 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- ====== BLOCK (defensor) ======
    local blockChance = 0
    if creature:isPlayer() then
        blockChance = creature:getStorageValue(PoeStats.STORAGE_BLOCK_CHANCE)
        if blockChance < 0 then
            blockChance = 0
        end
    end

    if blockChance > 0 then
        local rollBlock = math.random(100)
        if rollBlock <= blockChance then
            -- Dano totalmente bloqueado (estilo PoE)
            creature:say("BLOCK!", TALKTYPE_MONSTER_SAY)
            creature:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)

            return 0, primaryType, 0, secondaryType
        end
    end

    -- ====== CRÍTICO + LEECH (atacante) ======
    local critChance = attacker:getStorageValue(PoeStats.STORAGE_CRIT_CHANCE)
    local lifeLeech  = attacker:getStorageValue(PoeStats.STORAGE_LIFE_LEECH)

    if critChance < 0 then critChance = 0 end
    if lifeLeech  < 0 then lifeLeech  = 0 end

    -- === CRÍTICO ===
    if critChance > 0 then
        local roll = math.random(100)
        if roll <= critChance then
            local critMultiplier = 1.5 -- 50% a mais de dano
            primaryDamage = math.floor((primaryDamage or 0) * critMultiplier)
            if secondaryDamage and secondaryDamage > 0 then
                secondaryDamage = math.floor(secondaryDamage * critMultiplier)
            end

            attacker:say("CRIT!", TALKTYPE_MONSTER_SAY)
            creature:getPosition():sendMagicEffect(CONST_ME_CRITICAL_DAMAGE)
        end
    end

    -- === LIFE LEECH ===
    if lifeLeech > 0 then
        local totalDamage = (primaryDamage or 0) + (secondaryDamage or 0)
        if totalDamage > 0 then
            local leechAmount = math.floor(totalDamage * (lifeLeech / 100))
            if leechAmount > 0 then
                attacker:addHealth(leechAmount)
                attacker:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
            end
        end
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

