local ec = EventCallback

function ec.onGainExperience(player, source, exp, rawExp)
    if not (source and source:isMonster() and PoEMonsterRarity) then
        return exp
    end

    local id = source:getId()
    local rank = PoEMonsterRarity.getMonsterRank(source)

    local cfg = PoEMonsterRarity.STATS_BY_RANK[rank]
    if not (cfg and cfg.exp) then
        return exp
    end

    local newExp = math.floor(exp * cfg.exp)
    return newExp
end


ec:register()
