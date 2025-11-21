-- C:\Ot POE\data\scripts\movements\poe_on_equip.lua
-- Atualiza stats PoE ao equipar / desequipar itens específicos

-- IMPORTANTE:
-- PoeStats deve estar carregado em data/lib/lib.lua:
dofile('data/lib/poe_stats.lua')

local function recalculatePoeStats(player)
    if PoeStats and PoeStats.recalculate then
        PoeStats.recalculate(player)
    else
        print("[POE] ERRO: PoeStats não carregado em onEquip")
    end
end

local trackedItems = { 2136, 2494 }

local function registerPoeMoveEvent(eventType, logLabel, itemId)
    local event = MoveEvent()
    event:type(eventType)
    event:id(itemId)

    if eventType == "equip" then
        function event.onEquip(player, item, slot, isCheck)
            if isCheck then
                return true
            end

            if not player or not player:isPlayer() then
                return true
            end

            print(string.format("[POE] %s: %s equipou itemId=%d slot=%d",
                logLabel, player:getName(), item:getId(), slot))

            recalculatePoeStats(player)
            return true
        end
    else
        function event.onDeEquip(player, item, slot, isCheck)
            if not player or not player:isPlayer() then
                return true
            end

            print(string.format("[POE] %s: %s removeu itemId=%d slot=%d",
                logLabel, player:getName(), item:getId(), slot))

            recalculatePoeStats(player)
            return true
        end
    end

    event:register()
end

for _, itemId in ipairs(trackedItems) do
    registerPoeMoveEvent("equip", "onEquip", itemId)
    registerPoeMoveEvent("deequip", "onDeEquip", itemId)
end
