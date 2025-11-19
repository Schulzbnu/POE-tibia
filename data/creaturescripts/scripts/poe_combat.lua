-- poe_combat.lua
-- Lê atributos PoE dos itens do atacante e aplica crítico + life leech

dofile('data/lib/poe_stats.lua')

local ELEMENTAL_DAMAGE_CONFIG = {
    { storage = PoeStats.STORAGE_FIRE_DAMAGE,   combatType = COMBAT_FIREDAMAGE,  effect = CONST_ME_HITBYFIRE },
    { storage = PoeStats.STORAGE_ICE_DAMAGE,    combatType = COMBAT_ICEDAMAGE,   effect = CONST_ME_ICEATTACK },
    { storage = PoeStats.STORAGE_ENERGY_DAMAGE, combatType = COMBAT_ENERGYDAMAGE, effect = CONST_ME_ENERGYHIT },
    { storage = PoeStats.STORAGE_EARTH_DAMAGE,  combatType = COMBAT_EARTHDAMAGE, effect = CONST_ME_HITBYPOISON },
}

local poeDamageGuard = {}

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

    if poeDamageGuard[creature:getId()] then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Ignora cura
    if primaryType == COMBAT_HEALING then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Em TFS 1.x o dano vem sempre POSITIVO nas callbacks (se no teu for negativo, é só tirar esse filtro).
    if (primaryDamage or 0) <= 0 and (secondaryDamage or 0) <= 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    --------------------------------------------------------------------
    -- 1) BLOCK (defensor) - funciona contra QUALQUER atacante
    --------------------------------------------------------------------
    local blockChance = 0
    if creature and creature:isPlayer() then
        blockChance = creature:getStorageValue(PoeStats.STORAGE_BLOCK_CHANCE)
        if blockChance < 0 then
            blockChance = 0
        end
    end

    if blockChance > 0 then
        local rollBlock = math.random(100)
        if rollBlock <= blockChance then
            creature:say("BLOCK!", TALKTYPE_MONSTER_SAY)
            creature:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)

            -- bloqueia todo o dano
            return 0, primaryType, 0, secondaryType
        end
    end

    --------------------------------------------------------------------
    -- 2) CRÍTICO + LEECH (atacante) - só se o atacante for player
    --------------------------------------------------------------------
    if not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local critChance = attacker:getStorageValue(PoeStats.STORAGE_CRIT_CHANCE)
    local lifeLeech  = attacker:getStorageValue(PoeStats.STORAGE_LIFE_LEECH)
    local manaLeech   = attacker:getStorageValue(PoeStats.STORAGE_MANA_LEECH)
    local critMulti   = attacker:getStorageValue(PoeStats.STORAGE_CRIT_MULTI)

    local elementalBonuses = {}
    local elementalSum = 0
    for _, entry in ipairs(ELEMENTAL_DAMAGE_CONFIG) do
        local value = math.max(0, attacker:getStorageValue(entry.storage))
        if value > 0 then
            table.insert(elementalBonuses, { amount = value, combatType = entry.combatType, effect = entry.effect })
            elementalSum = elementalSum + value
        end
    end

    if critChance < 0 then critChance = 0 end
    if lifeLeech  < 0 then lifeLeech  = 0 end
    if manaLeech < 0 then manaLeech = 0 end
    if critMulti < 0 then critMulti = 0 end

    -- === CRÍTICO ===
    local critMultiplier = 1.0
    if critChance > 0 then
        local roll = math.random(100)
        if roll <= critChance then
            critMultiplier = 1.0 + (critMulti / 100)
            primaryDamage = math.floor((primaryDamage or 0) * critMultiplier)
            if secondaryDamage and secondaryDamage > 0 then
                secondaryDamage = math.floor(secondaryDamage * critMultiplier)
            end

            for _, bonus in ipairs(elementalBonuses) do
                bonus.amount = math.floor(bonus.amount * critMultiplier)
            end

            elementalSum = 0
            for _, bonus in ipairs(elementalBonuses) do
                elementalSum = elementalSum + bonus.amount
            end

            attacker:say("CRIT!", TALKTYPE_MONSTER_SAY)
            creature:getPosition():sendMagicEffect(CONST_ME_CRITICAL_DAMAGE)
        end
    end

    -- === LIFE LEECH ===
    if lifeLeech > 0 then
        local totalDamage = (primaryDamage or 0) + (secondaryDamage or 0) + elementalSum
        if totalDamage > 0 then
            local leechAmount = math.floor(totalDamage * (lifeLeech / 100))
            if leechAmount > 0 then
                attacker:addHealth(leechAmount)
                attacker:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
            end
        end
    end

    if manaLeech > 0 then
        local leechAmount = math.floor(((primaryDamage or 0) + (secondaryDamage or 0) + elementalSum) * (manaLeech / 100))
        if leechAmount > 0 then
            attacker:addMana(leechAmount)
            attacker:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        end
    end


    if #elementalBonuses > 0 then
        poeDamageGuard[creature:getId()] = true
        for _, bonus in ipairs(elementalBonuses) do
            doTargetCombatHealth(attacker, creature, bonus.combatType, -bonus.amount, -bonus.amount, bonus.effect)
        end
        poeDamageGuard[creature:getId()] = nil
    end


    return primaryDamage, primaryType, secondaryDamage, secondaryType
end


