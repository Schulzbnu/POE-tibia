poeAttributesButton = nil
poeAttributesWindow = nil

local poeItems = {
    {
        name = "Headhunter",
        type = "Leather Belt",
        rarity = "Unique",
        attributes = {
            "+(25-40) to maximum Life",
            "+(40-55) to Strength",
            "+(40-55) to Dexterity",
            "+(50-60) to maximum Life",
            "25% increased Damage with Hits against Rare monsters",
            "When you Kill a Rare monster, you gain its Modifiers for 60 seconds"
        }
    },
    {
        name = "Tabula Rasa",
        type = "Simple Robe",
        rarity = "Unique",
        attributes = {
            "Item has no level requirement",
            "Has 6 White Sockets",
            "Fully-linked sockets",
            "Great for leveling and experimenting with gem setups"
        }
    },
    {
        name = "Exalted Orb",
        type = "Currency",
        rarity = "Currency",
        attributes = {
            "Stack Size: 20",
            "Enriches a rare item with a new random modifier",
            "High-value crafting currency in late game"
        }
    },
    {
        name = "Voidforge",
        type = "Infernal Sword",
        rarity = "Unique",
        attributes = {
            "Adds 90 to 160 Physical Damage",
            "50% of Physical Damage converted to a random Element",
            "Gains 300% of Physical Damage as Extra Damage of a random Element",
            "Triggers random elemental theme on hit"
        }
    }
}

local function getListWidget()
    if not poeAttributesWindow then
        return nil
    end
    return poeAttributesWindow:recursiveGetChildById('itemList')
end

local function getDetailWidgets()
    if not poeAttributesWindow then
        return nil, nil, nil
    end
    local nameLabel = poeAttributesWindow:recursiveGetChildById('itemName')
    local typeLabel = poeAttributesWindow:recursiveGetChildById('itemType')
    local attributesBox = poeAttributesWindow:recursiveGetChildById('itemAttributes')
    return nameLabel, typeLabel, attributesBox
end

local function formatAttributes(attributes)
    local buffer = {}
    for _, attribute in ipairs(attributes) do
        table.insert(buffer, "• " .. attribute)
    end
    return table.concat(buffer, "\n")
end

local function selectItem(widget)
    if not widget or not widget.itemData then
        return
    end

    local nameLabel, typeLabel, attributesBox = getDetailWidgets()
    if not nameLabel or not typeLabel or not attributesBox then
        return
    end

    local itemData = widget.itemData
    nameLabel:setText(itemData.name)
    typeLabel:setText(string.format("%s (%s)", itemData.type, itemData.rarity))
    attributesBox:setText(formatAttributes(itemData.attributes or {}))
end

local function clearSelection()
    local nameLabel, typeLabel, attributesBox = getDetailWidgets()
    if nameLabel then
        nameLabel:setText(tr('Select an item'))
    end
    if typeLabel then
        typeLabel:setText('')
    end
    if attributesBox then
        attributesBox:setText(tr('Escolha um item para ver seus atributos.'))
    end
end

local function populateItems()
    local listWidget = getListWidget()
    if not listWidget then
        return
    end

    listWidget:destroyChildren()

    for index, item in ipairs(poeItems) do
        local row = g_ui.createWidget('PoeItemListLabel', listWidget)
        row:setText(item.name)
        row.itemData = item
        row.onClick = function(widget)
            selectItem(widget)
        end

        if index == 1 then
            selectItem(row)
        end
    end

    if listWidget:getChildCount() == 0 then
        clearSelection()
    end
end

function init()
    poeAttributesButton = modules.game_mainpanel.addToggleButton('poeAttributesButton', tr('POE Items'),
        '/images/topbuttons/bot', toggle, false, 2)
    poeAttributesButton:setOn(false)

    poeAttributesWindow = g_ui.loadUI('poeattributes')
    poeAttributesWindow:hide()
    poeAttributesWindow:setup()

    populateItems()

    connect(g_game, { onGameEnd = onGameEnd })
end

function terminate()
    disconnect(g_game, { onGameEnd = onGameEnd })

    if poeAttributesButton then
        poeAttributesButton:destroy()
        poeAttributesButton = nil
    end

    if poeAttributesWindow then
        poeAttributesWindow:destroy()
        poeAttributesWindow = nil
    end
end

function toggle()
    if not poeAttributesWindow or not poeAttributesButton then
        return
    end

    if poeAttributesButton:isOn() then
        poeAttributesWindow:close()
    else
        if not poeAttributesWindow:getParent() then
            local panel = modules.game_interface.findContentPanelAvailable(poeAttributesWindow,
                poeAttributesWindow:getMinimumHeight())
            if not panel then
                return
            end

            panel:addChild(poeAttributesWindow)
        end

        poeAttributesWindow:open()
    end
end

function onMiniWindowOpen()
    if poeAttributesButton then
        poeAttributesButton:setOn(true)
    end
end

function onMiniWindowClose()
    if poeAttributesButton then
        poeAttributesButton:setOn(false)
    end
end

function onGameEnd()
    if poeAttributesWindow then
        poeAttributesWindow:close()
    end
end
