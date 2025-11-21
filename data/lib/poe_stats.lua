-- data/lib/poe_stats.lua

dofile('data/lib/poe_itemmods.lua')

PoeStats = PoeStats or {}

PoeStats.OPCODE = 50

-- Storages para guardar stats de combate
PoeStats.STORAGE_CRIT_CHANCE   = 90000
PoeStats.STORAGE_LIFE_LEECH    = 90002
PoeStats.STORAGE_BLOCK_CHANCE  = 90003
PoeStats.STORAGE_MOVE_SPEED  = 90004
PoeStats.STORAGE_LIFE_REGEN  = 90005
PoeStats.STORAGE_MANA_LEECH   = 90006
PoeStats.STORAGE_MANA_REGEN   = 90007
PoeStats.STORAGE_CRIT_MULTI   = 90008
PoeStats.STORAGE_FIRE_DAMAGE   = 90009
PoeStats.STORAGE_ICE_DAMAGE    = 90010
PoeStats.STORAGE_ENERGY_DAMAGE = 90011
PoeStats.STORAGE_EARTH_DAMAGE  = 90012
PoeStats.STORAGE_MAX_LIFE      = 90013
PoeStats.STORAGE_MAX_MANA      = 90014
PoeStats.STORAGE_POE_BONUS_LIFE = 90015
PoeStats.STORAGE_POE_BONUS_MANA = 90016


function PoeStats.getTotalStats(player)
    local totals = {
        critChance = 0,
        lifeLeech  = 0,
        movespeed  = 0,
        lifeRegen  = 0,
        blockChance = 0,
        manaLeech   = 0,
        manaRegen   = 0,
        critMulti   = 0,
        fireDamage  = 0,
        iceDamage   = 0,
        energyDamage = 0,
        earthDamage = 0,
        maxLife     = 0,
        maxMana     = 0,
    }

    for _, slot in ipairs(PoeItemMods.EQUIP_SLOTS) do
        local item = player:getSlotItem(slot)
        if item then
            local rarity, mods = PoeItemMods.getItemMods(item)
            if mods then
                for _, m in ipairs(mods) do
                    if m.id == "critChance" then
                        totals.critChance = totals.critChance + (m.value or 0)
                    elseif m.id == "lifeLeech" then
                        totals.lifeLeech = totals.lifeLeech + (m.value or 0)
                    elseif m.id == "movespeed" then
                        totals.movespeed = totals.movespeed + (m.value or 0)
                    elseif m.id == "lifeRegen" then
                        totals.lifeRegen = totals.lifeRegen + (m.value or 0)
                    elseif m.id == "blockChance" then
                        totals.blockChance = totals.blockChance + (m.value or 0)
                    elseif m.id == "manaLeech" then
                        totals.manaLeech = (totals.manaLeech or 0) + (m.value or 0)
                    elseif m.id == "manaRegen" then
                        totals.manaRegen = (totals.manaRegen or 0) + (m.value or 0)
                    elseif m.id == "critMulti" then
                        totals.critMulti = (totals.critMulti or 0) + (m.value or 0)
                    elseif m.id == "fireDamage" then
                        totals.fireDamage = (totals.fireDamage or 0) + (m.value or 0)
                    elseif m.id == "iceDamage" then
                        totals.iceDamage = (totals.iceDamage or 0) + (m.value or 0)
                    elseif m.id == "energyDamage" then
                        totals.energyDamage = (totals.energyDamage or 0) + (m.value or 0)
                    elseif m.id == "earthDamage" then
                        totals.earthDamage = (totals.earthDamage or 0) + (m.value or 0)
                    elseif m.id == "maxLife" then
                        totals.maxLife = (totals.maxLife or 0) + (m.value or 0)
                    elseif m.id == "maxMana" then
                        totals.maxMana = (totals.maxMana or 0) + (m.value or 0)

                    end
                    -- aqui você adiciona mais atributos conforme for criando
                end
            end
        end
    end

    return totals
end

local function applyMoveSpeed(player, moveSpeed)
    if not player or not player:isPlayer() then
        return
    end

    -- Remove qualquer haste atual (independente de id/subid)
    player:removeCondition(CONDITION_HASTE)

    if not moveSpeed or moveSpeed <= 0 then
        return
    end

    local condition = Condition(CONDITION_HASTE)
    condition:setParameter(CONDITION_PARAM_TICKS, -1)            -- “infinito”
    condition:setParameter(CONDITION_PARAM_SPEED, moveSpeed * 2)     -- bônus total de speed
    player:addCondition(condition)
end


local function applyRegen(player, lifeRegen, manaRegen)
    if not player or not player:isPlayer() then
        return
    end

    -- Remove qualquer regen atual
    player:removeCondition(CONDITION_REGENERATION)

    -- Se não tem nada pra regenerar, só sai
    if (not lifeRegen or lifeRegen <= 0) and (not manaRegen or manaRegen <= 0) then
        return
    end

    local condition = Condition(CONDITION_REGENERATION)
    condition:setParameter(CONDITION_PARAM_TICKS, -1) -- infinito

    if lifeRegen and lifeRegen > 0 then
        condition:setParameter(CONDITION_PARAM_HEALTHGAIN, lifeRegen)
        condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 1000) -- 1x por segundo
    end

    if manaRegen and manaRegen > 0 then
        condition:setParameter(CONDITION_PARAM_MANAGAIN, manaRegen)
        condition:setParameter(CONDITION_PARAM_MANATICKS, 1000) -- 1x por segundo
    end

    player:addCondition(condition)
end

local function applyMaxStats(player, bonusLife, bonusMana)
    if not player or not player:isPlayer() then
        return
    end

    bonusLife = bonusLife or 0
    bonusMana = bonusMana or 0
    if bonusLife < 0 then bonusLife = 0 end
    if bonusMana < 0 then bonusMana = 0 end

    -- Últimos bônus aplicados
    local oldBonusLife = player:getStorageValue(PoeStats.STORAGE_POE_BONUS_LIFE)
    local oldBonusMana = player:getStorageValue(PoeStats.STORAGE_POE_BONUS_MANA)
    if oldBonusLife < 0 then oldBonusLife = 0 end
    if oldBonusMana < 0 then oldBonusMana = 0 end

    -- Valor atual do TFS
    local oldMaxHealth = player:getMaxHealth()
    local oldMaxMana   = player:getMaxMana()
    local oldHealth    = player:getHealth()
    local oldMana      = player:getMana()

    if oldMaxHealth <= 0 then oldMaxHealth = 1 end
    if oldMaxMana <= 0 then oldMaxMana = 1 end

    -- Mantém % de vida/mana
    local healthRatio = oldHealth / oldMaxHealth
    local manaRatio   = oldMana   / oldMaxMana

    -- 🎯 AQUI ESTÁ A LÓGICA QUE VOCÊ QUER:
    -- base = (max atual - bônus que estava ativo antes)
    local baseMaxHealth = oldMaxHealth - oldBonusLife
    local baseMaxMana   = oldMaxMana   - oldBonusMana

    if baseMaxHealth < 1 then baseMaxHealth = 1 end
    if baseMaxMana < 0 then baseMaxMana = 0 end

    -- Novo max real
    local newMaxHealth = baseMaxHealth + bonusLife
    local newMaxMana   = baseMaxMana   + bonusMana

    -- Aplica novos valores
    if player.setMaxHealth then
        player:setMaxHealth(newMaxHealth)
    end
    if player.setMaxMana then
        player:setMaxMana(newMaxMana)
    end

    -- Salva o bônus atual para o próximo recálculo
    player:setStorageValue(PoeStats.STORAGE_POE_BONUS_LIFE, bonusLife)
    player:setStorageValue(PoeStats.STORAGE_POE_BONUS_MANA, bonusMana)

-- 🔥 Ajuste da VIDA / MANA ATUAL SEM CURAR AO AUMENTAR MAX

    local desiredHealth
    if newMaxHealth > oldMaxHealth then
        -- max subiu → NÃO cura
        desiredHealth = oldHealth
    elseif newMaxHealth < oldMaxHealth then
        -- max desceu → só clampa se necessário
        desiredHealth = math.min(oldHealth, newMaxHealth)
    else
        -- max igual → não mexe
        desiredHealth = oldHealth
    end

    if desiredHealth < 1 then
        desiredHealth = 1
    end

    local desiredMana
    if newMaxMana > oldMaxMana then
        desiredMana = oldMana
    elseif newMaxMana < oldMaxMana then
        desiredMana = math.min(oldMana, newMaxMana)
    else
        desiredMana = oldMana
    end

    if desiredMana < 0 then
        desiredMana = 0
    end

    if player.setHealth then
        player:setHealth(desiredHealth)
    else
        player:addHealth(desiredHealth - player:getHealth())
    end

    if player.setMana then
        player:setMana(desiredMana)
    else
        player:addMana(desiredMana - player:getMana())
    end


    print(string.format(
        "[POE] applyMaxStats -> base=%d oldMax=%d newMax=%d bonusOld=%d bonusNew=%d",
        baseMaxHealth, oldMaxHealth, newMaxHealth, oldBonusLife, bonusLife
    ))
end


function PoeStats.recalculate(player)
    if not player or not player:isPlayer() then
        return
    end

    local totals = PoeStats.getTotalStats(player)

    -- Combate: gravamos em storage
    player:setStorageValue(PoeStats.STORAGE_CRIT_CHANCE, totals.critChance)
    player:setStorageValue(PoeStats.STORAGE_LIFE_LEECH, totals.lifeLeech)
    player:setStorageValue(PoeStats.STORAGE_BLOCK_CHANCE, totals.blockChance)
    player:setStorageValue(PoeStats.STORAGE_MOVE_SPEED, totals.movespeed)
    player:setStorageValue(PoeStats.STORAGE_LIFE_REGEN, totals.lifeRegen)
    player:setStorageValue(PoeStats.STORAGE_MANA_LEECH, totals.manaLeech)
    player:setStorageValue(PoeStats.STORAGE_MANA_REGEN, totals.manaRegen)
    player:setStorageValue(PoeStats.STORAGE_CRIT_MULTI, totals.critMulti)
    player:setStorageValue(PoeStats.STORAGE_FIRE_DAMAGE, totals.fireDamage)
    player:setStorageValue(PoeStats.STORAGE_ICE_DAMAGE, totals.iceDamage)
    player:setStorageValue(PoeStats.STORAGE_ENERGY_DAMAGE, totals.energyDamage)
    player:setStorageValue(PoeStats.STORAGE_EARTH_DAMAGE, totals.earthDamage)
    player:setStorageValue(PoeStats.STORAGE_MAX_LIFE, totals.maxLife)
    player:setStorageValue(PoeStats.STORAGE_MAX_MANA, totals.maxMana)


        -- Fora de combate: conditions
    applyMoveSpeed(player, totals.movespeed)
    applyRegen(player, totals.lifeRegen, totals.manaRegen)
    applyMaxStats(player, totals.maxLife, totals.maxMana)

    PoeStats.sendToPlayer(player, totals)
end

function PoeStats.sendToPlayer(player, totals)
    if not player or not player:isPlayer() then
        return
    end

    totals = totals or PoeStats.getTotalStats(player)

    local buffer = string.format(
        "%d;%d;%d;%d;%d;%d;%d;%d;%d;%d;%d;%d;%d;%d",
        totals.critChance or 0,
        totals.lifeLeech or 0,
        totals.blockChance or 0,
        totals.movespeed or 0,
        totals.lifeRegen or 0,
        totals.manaLeech or 0,
        totals.manaRegen or 0,
        totals.critMulti or 0,
        totals.fireDamage or 0,
        totals.iceDamage or 0,
        totals.energyDamage or 0,
        totals.earthDamage or 0,
        totals.maxLife or 0,
        totals.maxMana or 0
    )

    print("[POE] sendToPlayer -> " .. buffer) -- DEBUG no console do TFS
    player:sendExtendedOpcode(PoeStats.OPCODE, buffer)
end
