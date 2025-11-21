dofile('data/lib/poe_stats.lua')

function onSay(player, words, param)

    -- Lê valores calculados
    local crit        = player:getStorageValue(PoeStats.STORAGE_CRIT_CHANCE)
    local leech       = player:getStorageValue(PoeStats.STORAGE_LIFE_LEECH)
    local block       = player:getStorageValue(PoeStats.STORAGE_BLOCK_CHANCE)
    local moveSpeed    = player:getStorageValue(PoeStats.STORAGE_MOVE_SPEED)
    local lifeRegen    = player:getStorageValue(PoeStats.STORAGE_LIFE_REGEN)
    local fireDamage   = player:getStorageValue(PoeStats.STORAGE_FIRE_DAMAGE)
    local iceDamage    = player:getStorageValue(PoeStats.STORAGE_ICE_DAMAGE)
    local energyDamage = player:getStorageValue(PoeStats.STORAGE_ENERGY_DAMAGE)
    local earthDamage  = player:getStorageValue(PoeStats.STORAGE_EARTH_DAMAGE)
    local maxLife      = player:getStorageValue(PoeStats.STORAGE_MAX_LIFE)
    local maxMana      = player:getStorageValue(PoeStats.STORAGE_MAX_MANA)

    -- Zero para negativos
    crit     = crit  > 0 and crit  or 0
    leech    = leech > 0 and leech or 0
    block    = block > 0 and block or 0
    fireDamage = fireDamage > 0 and fireDamage or 0
    iceDamage = iceDamage > 0 and iceDamage or 0
    energyDamage = energyDamage > 0 and energyDamage or 0
    earthDamage = earthDamage > 0 and earthDamage or 0
    maxLife = maxLife > 0 and maxLife or 0
    maxMana = maxMana > 0 and maxMana or 0

    player:sendTextMessage(MESSAGE_INFO_DESCR,
        string.format(
            "🟦 Player Stats (PoE)\n" ..
            "• Crit Chance: %d%%\n" ..
            "• Life Leech: %d%%\n" ..
            "• Block Chance: %d%%\n" ..
            "• Move Speed: +%d\n" ..
            "• Life Regen: +%d/s\n" ..
            "• Maximum Life: +%d\n" ..
            "• Maximum Mana: +%d\n" ..
            "• Fire Damage: +%d\n" ..
            "• Ice Damage: +%d\n" ..
            "• Energy Damage: +%d\n" ..
            "• Earth Damage: +%d",
            crit, leech, block, moveSpeed, lifeRegen, maxLife, maxMana, fireDamage, iceDamage, energyDamage, earthDamage
        )
    )

    return false
end
