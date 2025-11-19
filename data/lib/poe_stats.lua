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


        -- Fora de combate: conditions
    applyMoveSpeed(player, totals.movespeed)
    applyRegen(player, totals.lifeRegen, totals.manaRegen)

    PoeStats.sendToPlayer(player)
end

function PoeStats.sendToPlayer(player)
    if not player or not player:isPlayer() then
        return
    end

    local totals = PoeStats.getTotalStats(player)

    local buffer = string.format(
        "%d;%d;%d;%d;%d;%d;%d;%d",
        totals.critChance or 0,
        totals.lifeLeech or 0,
        totals.blockChance or 0,
        totals.movespeed or 0,
        totals.lifeRegen or 0,
        totals.manaLeech or 0,
        totals.manaRegen or 0,
        totals.critMulti or 0
    )

    print("[POE] sendToPlayer -> " .. buffer) -- DEBUG no console do TFS
    player:sendExtendedOpcode(PoeStats.OPCODE, buffer)
end
