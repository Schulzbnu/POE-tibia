-- data/lib/poe_stats.lua

dofile('data/lib/poe_itemmods.lua')

PoeStats = PoeStats or {}

-- Storages para guardar stats de combate
PoeStats.STORAGE_CRIT_CHANCE   = 90000
PoeStats.STORAGE_LIFE_LEECH    = 90002
PoeStats.STORAGE_BLOCK_CHANCE  = 90003  -- NOVO
PoeStats.STORAGE_MOVE_SPEED  = 90004
PoeStats.STORAGE_LIFE_REGEN  = 90005

function PoeStats.getTotalStats(player)
    local totals = {
        critChance = 0,
        lifeLeech  = 0,
        movespeed  = 0,
        lifeRegen  = 0,
        blockChance = 0,
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
    condition:setParameter(CONDITION_PARAM_SPEED, moveSpeed)     -- bônus total de speed
    player:addCondition(condition)
end


local function applyLifeRegen(player, lifeRegen)
    if not player or not player:isPlayer() then
        return
    end

    -- Remove qualquer regen atual
    player:removeCondition(CONDITION_REGENERATION)

    if not lifeRegen or lifeRegen <= 0 then
        return
    end

    local condition = Condition(CONDITION_REGENERATION)
    condition:setParameter(CONDITION_PARAM_TICKS, -1)             -- “infinito”
    condition:setParameter(CONDITION_PARAM_HEALTHGAIN, lifeRegen) -- quanto cura por tick
    condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 2000)     -- 1x por segundo
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
    player:setStorageValue(PoeStats.STORAGE_MOVE_SPEED,    totals.movespeed)
    player:setStorageValue(PoeStats.STORAGE_LIFE_REGEN,    totals.lifeRegen)

        -- Fora de combate: conditions
    applyMoveSpeed(player, totals.movespeed)
    applyLifeRegen(player, totals.lifeRegen)
end
