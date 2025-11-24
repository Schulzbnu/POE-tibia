-- data/lib/poe_monster_rarity.lua
-- Sistema simples de raridade de monstros + skull por raridade

PoEMonsterRarity = PoEMonsterRarity or {}

-- Definições de raridade (ajusta os nomes como quiser)
PoEMonsterRarity.RANK = {
    NORMAL = "Normal",
    MAGIC  = "Magic",
    RARE   = "Rare",
    UNIQUE = "Unique",
}

-- Mapa de raridade -> skull
-- Ajusta as cores de skull do jeito que você quiser
PoEMonsterRarity.SKULL_BY_RANK = {
    [PoEMonsterRarity.RANK.NORMAL] = SKULL_WHITE,
    [PoEMonsterRarity.RANK.MAGIC]  = SKULL_YELLOW,
    [PoEMonsterRarity.RANK.RARE]   = SKULL_RED,
    [PoEMonsterRarity.RANK.UNIQUE] = SKULL_BLACK,
}

-- Armazena raridade por monstro vivo (key = monsterId)
local monsterRarities = {}

-----------------------------------------------------------------
-- GET / SET por instância de monstro
-----------------------------------------------------------------
function PoEMonsterRarity.setMonsterRank(monster, rank)
    if not monster or not monster:isMonster() then
        return
    end

    -- fallback pra algo válido
    rank = rank or PoEMonsterRarity.RANK.NORMAL

    monsterRarities[monster:getId()] = rank
end

function PoEMonsterRarity.getMonsterRank(monster)
    if not monster or not monster:isMonster() then
        return PoEMonsterRarity.RANK.NORMAL
    end
    return monsterRarities[monster:getId()] or PoEMonsterRarity.RANK.NORMAL
end

-----------------------------------------------------------------
-- Aplica o skull conforme a raridade
-----------------------------------------------------------------
function PoEMonsterRarity.applySkullFromRank(monster)
    if not monster or not monster:isMonster() then
        return
    end

    local rank = PoEMonsterRarity.getMonsterRank(monster)
    local skull = PoEMonsterRarity.SKULL_BY_RANK[rank] or SKULL_NONE

    monster:setSkull(skull)
end
