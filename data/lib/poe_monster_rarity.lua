-- data/lib/poe_monster_rarity.lua
-- Sistema de raridade de monstros + skull + multiplicadores + Level

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

-- Multiplicadores por raridade (base)
-- Esses multiplicadores serão COMBINADOS com o Level
R.STATS_BY_RANK = R.STATS_BY_RANK or {
    [R.RANK.NORMAL] = { hp = 1.0, dmg = 1.0, exp = 1.0 },
    [R.RANK.MAGIC]  = { hp = 1.5, dmg = 1.2, exp = 1.5 },
    [R.RANK.RARE]   = { hp = 2.5, dmg = 1.8, exp = 2.0 },
    [R.RANK.UNIQUE] = { hp = 4.0, dmg = 2.5, exp = 4.0 },
}

-----------------------------------------------------------------
-- Config de Level
-----------------------------------------------------------------
-- Aqui você controla o scaling por Level.
-- Exemplo abaixo:
--  +8% HP por level
--  +5% dano por level
--  +10% exp por level
R.MAX_LEVEL = R.MAX_LEVEL or 100

-- Função que retorna os multiplicadores do Level
function R.getLevelMultipliers(level)
    level = tonumber(level) or 1
    if level < 1 then
        level = 1
    elseif level > R.MAX_LEVEL then
        level = R.MAX_LEVEL
    end

    local lvlIndex = level - 1
    local hpPerLevel  = 0.08  -- 8% HP a cada level
    local dmgPerLevel = 0.05  -- 5% dano a cada level
    local expPerLevel = 0.8  -- 8% exp a cada level

    local hpMult  = 1.0 + hpPerLevel  * lvlIndex
    local dmgMult = 1.0 + dmgPerLevel * lvlIndex
    local expMult = 1.0 + expPerLevel * lvlIndex

    return {
        hp  = hpMult,
        dmg = dmgMult,
        exp = expMult
    }
end

-----------------------------------------------------------------
-- Armazenamento por instância de monstro
-----------------------------------------------------------------
-- Raridade
R.monsterRarities = R.monsterRarities or {}
local monsterRarities = R.monsterRarities

-- Level
R.monsterLevels = R.monsterLevels or {}
local monsterLevels = R.monsterLevels

-----------------------------------------------------------------
-- GET / SET RANK
-----------------------------------------------------------------
function R.setMonsterRank(monster, rank)
    if not monster or not monster:isMonster() then
        return
    end

    rank = rank or R.RANK.NORMAL
    local id = monster:getId()
    if not id then
        return
    end

    monsterRarities[id] = rank
end

function R.getMonsterRank(monster)
    if not monster or not monster:isMonster() then
        return R.RANK.NORMAL
    end

    local id = monster:getId()
    if not id then
        return R.RANK.NORMAL
    end

    return monsterRarities[id] or R.RANK.NORMAL
end

-----------------------------------------------------------------
-- GET / SET LEVEL
-----------------------------------------------------------------
function R.setMonsterLevel(monster, level)
    if not monster or not monster:isMonster() then
        return
    end

    local id = monster:getId()
    if not id then
        return
    end

    level = tonumber(level) or 1
    if level < 1 then
        level = 1
    elseif level > R.MAX_LEVEL then
        level = R.MAX_LEVEL
    end

    monsterLevels[id] = level
end

function R.getMonsterLevel(monster)
    if not monster or not monster:isMonster() then
        return 1
    end

    local id = monster:getId()
    if not id then
        return 1
    end

    return monsterLevels[id] or 1
end

-----------------------------------------------------------------
-- Limpar dados do monstro
-----------------------------------------------------------------
function R.clearMonsterRank(monster)
    if not monster or not monster:isMonster() then
        return
    end

    local id = monster:getId()
    if not id then
        return
    end

    monsterRarities[id] = nil
end

function R.clearMonsterLevel(monster)
    if not monster or not monster:isMonster() then
        return
    end

    local id = monster:getId()
    if not id then
        return
    end

    monsterLevels[id] = nil
end

-- Helper para limpar tudo de uma vez (usar no onDropLoot por exemplo)
function R.clearMonsterData(monster)
    if not monster or not monster:isMonster() then
        return
    end

    local id = monster:getId()
    if not id then
        return
    end

    monsterRarities[id] = nil
    monsterLevels[id] = nil
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
-- Multiplicadores combinados (Rank + Level)
-----------------------------------------------------------------
-- Retorna um table com { hp, dmg, exp } combinando rank e level
function R.getCombinedMultipliers(monster)
    if not monster or not monster:isMonster() then
        return { hp = 1.0, dmg = 1.0, exp = 1.0 }
    end

    local rank = R.getMonsterRank(monster)
    local level = R.getMonsterLevel(monster)

    local rankCfg = R.STATS_BY_RANK[rank] or { hp = 1.0, dmg = 1.0, exp = 1.0 }
    local lvlCfg  = R.getLevelMultipliers(level)

    return {
        hp  = (rankCfg.hp  or 1.0) * (lvlCfg.hp  or 1.0),
        dmg = (rankCfg.dmg or 1.0) * (lvlCfg.dmg or 1.0),
        exp = (rankCfg.exp or 1.0) * (lvlCfg.exp or 1.0),
    }
end

-- Helpers específicos se quiser usar só um de cada vez
function R.getHealthMultiplier(monster)
    return R.getCombinedMultipliers(monster).hp
end

function R.getDamageMultiplier(monster)
    return R.getCombinedMultipliers(monster).dmg
end

function R.getExpMultiplier(monster)
    return R.getCombinedMultipliers(monster).exp
end

-----------------------------------------------------------------
-- Vida extra conforme raridade + level
-----------------------------------------------------------------
-- Substitui a antiga applyHealthFromRank
function R.applyHealthFromRankAndLevel(monster)
    if not monster or not monster:isMonster() then
        return
    end

    local mult = R.getHealthMultiplier(monster)
    if not mult or mult == 1.0 then
        return
    end

    local oldMax = monster:getMaxHealth()
    if oldMax <= 0 then
        return
    end

    local newMax = math.floor(oldMax * mult)

    monster:setMaxHealth(newMax)

    local cur = monster:getHealth()
    if cur < newMax then
        monster:addHealth(newMax - cur)
    end
end
