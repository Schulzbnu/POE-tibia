-- data/talkactions/scripts/poe_roll_item.lua

dofile('data/lib/poe_itemmods.lua')

local function rollRarity()
    -- Exemplo de chances:
    -- 60% normal, 25% magic, 12% rare, 3% unique
    local r = math.random(100)
    if r <= 60 then
        return "normal"
    elseif r <= 85 then
        return "magic"
    elseif r <= 97 then
        return "rare"
    else
        return "unique"
    end
end

local function rollModsForItem(item, itemGroup)
    local rarityKey = rollRarity()
    local rarity = PoeItemMods.RARITIES[rarityKey]

    if not rarity or rarity.maxMods == 0 or not PoeItemMods.MOD_POOLS[itemGroup] then
        PoeItemMods.clearItemMods(item)
        return rarityKey, {}
    end

    local pool = PoeItemMods.MOD_POOLS[itemGroup]
    local maxMods = rarity.maxMods
    local available = {}

    for _, mod in ipairs(pool) do
        table.insert(available, mod)
    end

    local rolled = {}

    for i = 1, maxMods do
        if #available == 0 then
            break
        end

        local index = math.random(#available)
        local mod = available[index]

        local tier = mod.tiers[math.random(#mod.tiers)]
        local value = math.random(tier.min, tier.max)

        table.insert(rolled, {
            id = mod.id,
            tier = tier.tier,
            value = value,
            text = string.format(mod.text, value),
        })

        table.remove(available, index)
    end

    -- guarda nos custom attributes em formato compactado
    local modsToStore = {}
    for _, m in ipairs(rolled) do
        table.insert(modsToStore, {
            id = m.id,
            tier = m.tier,
            value = m.value
        })
    end
    PoeItemMods.setItemMods(item, rarityKey, modsToStore)

    -- Atualiza descrição do item
    local descLines = {}
    table.insert(descLines, rarity.name .. " item")
    for _, m in ipairs(rolled) do
        table.insert(descLines, m.text)
    end
    item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, table.concat(descLines, "\n"))

    return rarityKey, rolled
end

local function createRolledItem(player, baseItemId)
    local newItem = player:addItem(baseItemId, 1)
    if not newItem then
        return nil, "Não foi possível criar o item (ID " .. baseItemId .. ")."
    end

    -- aqui usamos direto a função do lib
    local group = PoeItemMods.getItemType(newItem)
    if not group then
        return nil, "Esse item (ID " .. baseItemId .. ") não pode receber mods PoE."
    end

    local rarityKey, mods = rollModsForItem(newItem, group)
    return {
        item = newItem,
        rarityKey = rarityKey,
        mods = mods
    }, nil
end


function onSay(player, words, param)
    param = param:gsub("%s+", "")
    local baseItemId = tonumber(param)

    -- Se não veio ID, usa a arma equipada na mão direita como base
    if not baseItemId then
        local slotItem = player:getSlotItem(CONST_SLOT_RIGHT)
        if not slotItem then
            player:sendCancelMessage("Use /rollpoe <itemid> ou equipe uma arma na mão direita.")
            return false
        end
        baseItemId = slotItem:getId()
    end

    local result, err = createRolledItem(player, baseItemId)
    if not result then
        player:sendCancelMessage(err or "Falha ao criar item rolado.")
        return false
    end

    player:sendTextMessage(
        MESSAGE_STATUS_CONSOLE_BLUE,
        string.format(
            "Item criado: %s (ID %d) rolado como %s com %d mods.",
            ItemType(baseItemId):getName(),
            baseItemId,
            result.rarityKey,
            #result.mods
        )
    )

    return false
end
