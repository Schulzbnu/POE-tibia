-- data/scripts/eventcallbacks/poe_monster_spawn_skull.lua

local ec = EventCallback

function ec.onSpawn(monster, position, startup, artificial)
    if not monster or not monster:isMonster() then
        return true
    end

    PoEMonsterRarity.applySkullFromRank(monster)

    return true
end

ec:register()
