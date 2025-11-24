-- data/lib/poe_monster_rarity.lua
-- Sistema de raridade de monstros + skull + multiplicadores

PoEMonsterRarity = PoEMonsterRarity or {}
local R = PoEMonsterRarity

-----------------------------------------------------------------
-- Definições básicas
-----------------------------------------------------------------
R.RANK = R.RANK or {
    NORMAL = "Normal",
    MAGIC  = "Magic",
    RARE   = "Rare",
    UNIQUE = "Unique",
}

-- Skull por raridade
R.SKULL_BY_RANK = R.SKULL_BY_RANK or {
    [R.RANK.NORMAL] = SKULL_WHITE,
    [R.RANK.MAGIC]  = SKULL_YELLOW,
    [R.RANK.RARE]   = SKULL_RED,
    [R.RANK.UNIQUE] = SKULL_BLACK,
}

-- Multiplicadores por raridade
R.STATS_BY_RANK = R.STATS_BY_RANK or {
    [R.RANK.NORMAL] = { hp = 1.0, dmg = 1.0, exp = 1.0 },
    [R.RANK.MAGIC]  = { hp = 1.5, dmg = 1.2, exp = 1.5 },
    [R.RANK.RARE]   = { hp = 2.5, dmg = 1.8, exp = 2.0 },
    [R.RANK.UNIQUE] = { hp = 4.0, dmg = 2.5, exp = 4.0 },
}

-- Armazena raridade por ID do monstro
R.monsterRarities = R.monsterRarities or {}
local monsterRarities = R.monsterRarities

-----------------------------------------------------------------
-- GET / SET por instância de monstro
-----------------------------------------------------------------
function R.setMonsterRank(monster, rank)
    if not monster or not monster:isMonster() then
        return
    end

    rank = rank or R.RANK.NORMAL
    local id = monster:getId()
    monsterRarities[id] = rank

end

function R.getMonsterRank(monster)
    if not monster or not monster:isMonster() then
        return R.RANK.NORMAL
    end

    local id = monster:getId()
    return monsterRarities[id] or R.RANK.NORMAL
end

function R.clearMonsterRank(monster)
    if not monster or not monster:isMonster() then
        return
    end

    local id = monster:getId()
    monsterRarities[id] = nil
end

-----------------------------------------------------------------
-- Skull conforme raridade
-----------------------------------------------------------------
function R.applySkullFromRank(monster)
    if not monster or not monster:isMonster() then
        return
    end

    local rank = R.getMonsterRank(monster)
    local skullMap = R.SKULL_BY_RANK or {}
    local skull = skullMap[rank] or SKULL_NONE

    monster:setSkull(skull)
end

-----------------------------------------------------------------
-- Vida extra conforme raridade
-----------------------------------------------------------------
function R.applyHealthFromRank(monster)
    if not monster or not monster:isMonster() then
        return
    end

    local rank = R.getMonsterRank(monster)
    local cfg = R.STATS_BY_RANK[rank]
    if not cfg or not cfg.hp or cfg.hp == 1.0 then
        return
    end

    local oldMax = monster:getMaxHealth()
    local newMax = math.floor(oldMax * cfg.hp)

    monster:setMaxHealth(newMax)

    local cur = monster:getHealth()
    if cur < newMax then
        monster:addHealth(newMax - cur)
    end

end
