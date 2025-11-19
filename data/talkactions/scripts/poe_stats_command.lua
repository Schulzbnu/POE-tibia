dofile('data/lib/poe_stats.lua')

function onSay(player, words, param)

    -- Lê valores calculados
    local crit        = player:getStorageValue(PoeStats.STORAGE_CRIT_CHANCE)
    local leech       = player:getStorageValue(PoeStats.STORAGE_LIFE_LEECH)
    local block       = player:getStorageValue(PoeStats.STORAGE_BLOCK_CHANCE)    
    local moveSpeed    = player:getStorageValue(PoeStats.STORAGE_MOVE_SPEED)
    local lifeRegen    = player:getStorageValue(PoeStats.STORAGE_LIFE_REGEN)

    -- Zero para negativos
    crit     = crit  > 0 and crit  or 0
    leech    = leech > 0 and leech or 0
    block    = block > 0 and block or 0

    player:sendTextMessage(MESSAGE_INFO_DESCR,
        string.format(
            "🟦 Player Stats (PoE)\n" ..
            "• Crit Chance: %d%%\n" ..
            "• Life Leech: %d%%\n" ..
            "• Block Chance: %d%%\n" ..
            "• Move Speed: +%d\n" ..
            "• Life Regen: +%d/s",
            crit, leech, block, moveSpeed, lifeRegen
        )
    )

    return false
end
