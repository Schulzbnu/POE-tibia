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

        local rank = PoEMonsterRarity.RANK.UNIQUE

        PoEMonsterRarity.setMonsterRank(monster, rank)

        PoEMonsterRarity.applySkullFromRank(monster, rank)
        PoEMonsterRarity.applyHealthFromRank(monster, rank)

    end, 1)

    return true
end

ec:register()
