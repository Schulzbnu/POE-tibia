-- data/creaturescripts/scripts/poe_monster_damage.lua
-- Aumenta o dano que MONSTROS causam, conforme raridade PoE

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    -- creature = quem LEVA o dano (normalmente o player)
    -- attacker = quem CAUSA o dano (monstro, player, etc.)

    -- Se não tem atacante ou não é monstro, não mexe em nada
    if not attacker or not attacker:isMonster() or not PoEMonsterRarity then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Se não tem dano (heal, buff, etc.), ignora
    if primaryDamage == nil and secondaryDamage == nil then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local rank = PoEMonsterRarity.getMonsterRank(attacker)
    local cfg = PoEMonsterRarity.STATS_BY_RANK and PoEMonsterRarity.STATS_BY_RANK[rank]

    if not (cfg and cfg.dmg and cfg.dmg ~= 1.0) then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Em TFS o dano costuma ser NEGATIVO (ex: -200)
    if primaryDamage and primaryDamage < 0 then
        primaryDamage = math.floor(primaryDamage * cfg.dmg)
    end

    if secondaryDamage and secondaryDamage < 0 then
        secondaryDamage = math.floor(secondaryDamage * cfg.dmg)
    end

    -- DEBUG opcional:
    -- print(string.format(
    --     "[PoEDmg] attacker=%s rank=%s mult=%.2f -> primary=%s secondary=%s primary first=%s",
    --     attacker:getName(), rank, cfg.dmg,
    --     tostring(primaryDamage), tostring(secondaryDamage),
    -- ))

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
