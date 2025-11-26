-- data/scripts/eventcallbacks/monster/poe_monster_exp_scaling.lua
-- Escala a experiência ganha ao matar monstros, conforme raridade + level PoE

local ec = EventCallback

function ec.onGainExperience(player, source, exp, rawExp)
    if not (source and source:isMonster() and PoEMonsterRarity and PoEMonsterRarity.getExpMultiplier) then
        return exp
    end

    -- Multiplicador combinado (raridade + level)
    local expMult = PoEMonsterRarity.getExpMultiplier(source) or 1.0
    if expMult == 1.0 then
        return exp
    end

    local newExp = math.floor(exp * expMult)

    -- DEBUG opcional:
    -- local rank = PoEMonsterRarity.getMonsterRank(source)
    -- local level = PoEMonsterRarity.getMonsterLevel(source)
    -- print(string.format(
    --     "[PoEExp] source=%s rank=%s lvl=%d mult=%.2f -> exp=%d -> %d",
    --     source:getName(), tostring(rank), level or 1, expMult, exp, newExp
    -- ))

    return newExp
end

ec:register()
