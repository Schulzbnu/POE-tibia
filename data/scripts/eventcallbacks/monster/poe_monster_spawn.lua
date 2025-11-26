local ec = EventCallback

function ec.onSpawn(monster, position, startup, artificial)
    if not monster or not monster:isMonster() then
        return true
    end

    -- Adia a lógica 1 tick para garantir ID real
    addEvent(function()
        if not monster or not monster:isMonster() then
            return
        end

        PoEMonsterRarity.setMonsterRank(monster, rank)
        PoEMonsterRarity.setMonsterLevel(monster, level)

        PoEMonsterRarity.applySkullFromRank(monster, rank)
        PoEMonsterRarity.applyHealthFromRankAndLevel(monster)

    end, 1)

    return true
end

ec:register()
