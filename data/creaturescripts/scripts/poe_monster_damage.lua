-- data/creaturescripts/scripts/poe_monster_damage.lua
-- Aumenta o dano que MONSTROS causam, conforme raridade + level PoE

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    -- creature = quem LEVA o dano (normalmente o player)
    -- attacker = quem CAUSA o dano (monstro, player, etc.)

    -- Se não tem atacante ou não é monstro, não mexe em nada
    if not attacker or not attacker:isMonster() or not PoEMonsterRarity or not PoEMonsterRarity.getDamageMultiplier then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Se não tem dano (heal, buff, etc.), ignora
    if primaryDamage == nil and secondaryDamage == nil then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Multiplicador combinado (raridade + level)
    local dmgMult = PoEMonsterRarity.getDamageMultiplier(attacker) or 1.0
    if dmgMult == 1.0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Em TFS o dano costuma ser NEGATIVO (ex: -200)
    if primaryDamage and primaryDamage < 0 then
        primaryDamage = math.floor(primaryDamage * dmgMult)
    end

    if secondaryDamage and secondaryDamage < 0 then
        secondaryDamage = math.floor(secondaryDamage * dmgMult)
    end

    -- DEBUG opcional:
    -- local rank = PoEMonsterRarity.getMonsterRank(attacker)
    -- local level = PoEMonsterRarity.getMonsterLevel(attacker)
    -- print(string.format(
    --     "[PoEDmg] attacker=%s rank=%s lvl=%d mult=%.2f -> primary=%s secondary=%s",
    --     attacker:getName(), tostring(rank), level or 1, dmgMult,
    --     tostring(primaryDamage), tostring(secondaryDamage)
    -- ))

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
