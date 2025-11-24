AutolootSelector = {}

local AUTOLOOT_CATEGORY = 31
local autolootButton = nil

autolootSelectorController = Controller:new()
autolootSelectorController:setUI('autoloot_selector')

local function getContainerById(id)
    for containerId, container in pairs(g_game.getContainers()) do
        if containerId == id then
            return container
        end
    end
end

local function getContainerLabel(item, container)
    if not item then
        return tr('Unknown container')
    end

    if container and container:getName() then
        return container:getName()
    end

    local thingType = g_things.getThingType(item:getId(), ThingCategoryItem)
    if thingType then
        return thingType:getName()
    end

    return tr('Container %s', item:getId())
end

function autolootSelectorController:onInit()
    autolootSelectorController.ui:hide()

    autolootSelectorController:registerEvents(g_game, {
        onGameStart = AutolootSelector.onGameStart,
        onGameEnd = AutolootSelector.onGameEnd,
        onQuickLootContainers = AutolootSelector.onQuickLootContainers
    })

    connect(Container, {
        onOpen = AutolootSelector.refreshContainerList,
        onClose = AutolootSelector.refreshContainerList
    })
end

function autolootSelectorController:onTerminate()
    disconnect(Container, {
        onOpen = AutolootSelector.refreshContainerList,
        onClose = AutolootSelector.refreshContainerList
    })

    AutolootSelector.hide()
    autolootButton = nil
    AutolootSelector = {}
end

function AutolootSelector.onGameStart()
    if not autolootButton then
        autolootButton = modules.client_topmenu.addRightGameToggleButton('autolootSelector', tr('Autoloot Container'),
            '/game_quickloot/images/choose', AutolootSelector.toggle, false)
    end

    autolootButton:setOn(false)
    AutolootSelector.refreshContainerList()
    AutolootSelector.updateSelectedContainer()
    AutolootSelector.refreshFallbackCheckbox()
end

function AutolootSelector.onGameEnd()
    if autolootButton then
        autolootButton:setOn(false)
    end

    AutolootSelector.hide()
end

function AutolootSelector.onQuickLootContainers(fallbackToMainContainer, lootContainers)
    AutolootSelector.fallbackToMain = fallbackToMainContainer
    AutolootSelector.lastLootContainers = lootContainers

    AutolootSelector.updateSelectedContainer()
    AutolootSelector.refreshFallbackCheckbox()
end

function AutolootSelector.toggle()
    if autolootSelectorController.ui:isVisible() then
        return AutolootSelector.hide()
    end

    AutolootSelector.show()
end

function AutolootSelector.show()
    autolootSelectorController.ui:show()
    autolootSelectorController.ui:raise()
    autolootSelectorController.ui:focus()

    AutolootSelector.refreshContainerList()
    AutolootSelector.updateSelectedContainer()
    AutolootSelector.refreshFallbackCheckbox()
end

function AutolootSelector.hide()
    autolootSelectorController.ui:hide()
end

function AutolootSelector.refreshFallbackCheckbox()
    local fallbackCheckbox = autolootSelectorController.ui.fallbackCheckbox
    if not fallbackCheckbox then
        return
    end

    fallbackCheckbox:setChecked(AutolootSelector.fallbackToMain or false)
end

function AutolootSelector.toggleFallback(isChecked)
    AutolootSelector.fallbackToMain = isChecked
    g_game.openContainerQuickLoot(3, nil, {}, nil, nil, isChecked)
end

function AutolootSelector.assignFromButton(widget)
    local containerWidget = widget:getParent()
    local containerId = tonumber(containerWidget:getId()) or widget.containerId
    local container = containerId and getContainerById(containerId)

    if not container or container:isClosed() then
        return
    end

    local containerItem = container:getContainerItem()
    if not containerItem then
        return
    end

    g_game.openContainerQuickLoot(4, AUTOLOOT_CATEGORY, containerItem:getPosition(), containerItem:getId(),
        containerItem:getStackPos())

    AutolootSelector.assignedItemId = containerItem:getId()
    AutolootSelector.updateSelectedContainer(containerItem, container)
end

function AutolootSelector.refreshContainerList()
    local list = autolootSelectorController.ui.containerList
    if not list or not g_game.isOnline() then
        return
    end

    list:getLayout():disableUpdates()
    list:destroyChildren()

    local color = '#484848'
    for containerId, container in pairs(g_game.getContainers()) do
        local entry = g_ui.createWidget('AutolootContainerEntry', list)
        local containerItem = container:getContainerItem()

        entry:setId(containerId)
        entry:setBackgroundColor(color)
        entry.item:setItem(containerItem)
        entry.label:setText(getContainerLabel(containerItem, container))

        color = color == '#484848' and '#414141' or '#484848'
    end

    list:getLayout():enableUpdates()
    list:getLayout():update()
end

function AutolootSelector.updateSelectedContainer(item, container)
    local selectedItemWidget = autolootSelectorController.ui.selectedContainer.selectedItem
    local selectedLabel = autolootSelectorController.ui.selectedContainer.selectedLabel

    local itemId = item and item:getId() or AutolootSelector.getConfiguredItemId()
    local itemToShow = item
    if not itemToShow and itemId then
        itemToShow = Item.create(itemId)
    end

    if itemToShow then
        selectedItemWidget:setItem(itemToShow)
        selectedLabel:setText(tr('Current autoloot backpack: %s', getContainerLabel(itemToShow, container)))
    else
        selectedItemWidget:setItem(nil)
        selectedLabel:setText(tr('Current autoloot backpack: none'))
    end
end

function AutolootSelector.getConfiguredItemId()
    local lootContainers = nil

    if modules.game_quickloot and modules.game_quickloot.QuickLoot and modules.game_quickloot.QuickLoot.lootContainers then
        lootContainers = modules.game_quickloot.QuickLoot.lootContainers
    elseif AutolootSelector.lastLootContainers then
        lootContainers = AutolootSelector.lastLootContainers
    end

    if not lootContainers then
        return nil
    end

    for _, container in ipairs(lootContainers) do
        if container[1] == AUTOLOOT_CATEGORY then
            return container[3]
        end
    end

    return nil
end
