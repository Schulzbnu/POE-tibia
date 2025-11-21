-- C:\Ot POE\data\scripts\movements\poe_on_equip.lua
-- Atualiza stats PoE ao equipar / desequipar itens específicos

-- IMPORTANTE:
-- PoeStats deve estar carregado em data/lib/lib.lua:
dofile('data/lib/poe_stats.lua')

-------------------------------------------------
-- EQUIP
-------------------------------------------------
local poeEquip = MoveEvent()

function poeEquip.onEquip(player, item, slot, isCheck)
    -- isCheck = true é só checagem do client (preview)
    if isCheck then
        return true
    end

    if not player or not player:isPlayer() then
        return true
    end

    print(string.format("[POE] onEquip: %s equipou itemId=%d slot=%d",
        player:getName(), item:getId(), slot))

    if PoeStats and PoeStats.recalculate then
        PoeStats.recalculate(player)
    else
        print("[POE] ERRO: PoeStats não carregado em onEquip")
    end

    return true
end

-- REGISTRO: aqui você coloca os IDs dos itens que quer que disparem o evento
-- EXEMPLO: helmets 2460, 2461, 2462 no slot head
poeEquip:id(2136,2494)
poeEquip:register()

-------------------------------------------------
-- DEEQUIP
-------------------------------------------------
local poeDeEquip = MoveEvent()

function poeDeEquip.onDeEquip(player, item, slot, isCheck)
    if not player or not player:isPlayer() then
        return true
    end

    print(string.format("[POE] onDeEquip: %s removeu itemId=%d slot=%d",
        player:getName(), item:getId(), slot))

    if PoeStats and PoeStats.recalculate then
        PoeStats.recalculate(player)
    else
        print("[POE] ERRO: PoeStats não carregado em onDeEquip")
    end

    return true
end

-- MESMOS IDs para o deequip
poeDeEquip:id(2136,2494)
poeDeEquip:register()
