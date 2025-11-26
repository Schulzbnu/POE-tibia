local ec = EventCallback

local function mergeStackableIntoContainer(container, item)
    local itemType = ItemType(item:getId())

    if not itemType:isStackable() then
        return 0
    end

    local maxStack = 100
    if itemType.getMaxItems then
        maxStack = itemType:getMaxItems() or maxStack
    elseif itemType.getStackSize then
        maxStack = itemType:getStackSize() or maxStack
    end
    local movedCount = 0
    local remaining = item:getCount()

    local function tryMerge(targetContainer)
        for _, targetItem in ipairs(targetContainer:getItems()) do
            if remaining <= 0 then
                return true
            end

            if targetItem:isContainer() then
                if tryMerge(targetItem) and remaining <= 0 then
                    return true
                end
            elseif targetItem:getId() == item:getId() then
                local targetCount = targetItem:getCount()
                if targetCount < maxStack then
                    local space = maxStack - targetCount
                    local toMove = math.min(space, remaining)
                    if targetItem.setCount then
                        targetItem:setCount(targetCount + toMove)
                        remaining = remaining - toMove
                        movedCount = movedCount + toMove
                    else
                        local transformed = targetItem:transform(targetItem:getId(), targetCount + toMove)
                        if transformed then
                            remaining = remaining - toMove
                            movedCount = movedCount + toMove
                        end
                    end
                end
            end
        end

        return remaining <= 0
    end

    tryMerge(container)

    if remaining == 0 then
        item:remove()
    elseif movedCount > 0 then
        item:transform(item:getId(), remaining)
    end

    return movedCount
end

local function collectPlayerContainers(root)
    local containers = {}
    local queue = { root }
    local index = 1

    while queue[index] do
        local container = queue[index]
        containers[#containers + 1] = container

        for _, item in ipairs(container:getItems()) do
            if item:isContainer() then
                queue[#queue + 1] = item
            end
        end

        index = index + 1
    end

    return containers
end

local function moveLootToBackpack(player, corpse)
    if not player then
        return false, "no-player"
    end

    local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
    if not backpack or not backpack:isContainer() then
        return false, "no-backpack"
    end

    local lootContainers = collectPlayerContainers(backpack)
    local items = corpse:getItems()
    if #items == 0 then
        return false, "no-loot"
    end

    local blockedBySlots = false
    local movedAnyItem = false

    for _, item in ipairs(items) do
        if not item then
            goto continue
        end

        -- 1) SEMPRE tentar agrupar primeiro
        local mergedCount = mergeStackableIntoContainer(backpack, item)
        if mergedCount > 0 then
            movedAnyItem = true
        end

        -- se o item foi totalmente consumido, já saiu do corpse
        if not item or item:getParent() ~= corpse then
            goto continue
        end

        -- 2) tentar mover para o primeiro container com espaço livre
        local moved = false
        for _, container in ipairs(lootContainers) do
            if container:getSize() < container:getCapacity() then
                moved = item:moveTo(container)
            end

            if moved then
                movedAnyItem = true
                break
            end
        end

        if not moved then
            blockedBySlots = true
        end

        ::continue::
    end

    if corpse:getSize() > 0 then
        local reason = blockedBySlots and "backpack-full" or "partial-move"
        return movedAnyItem, reason
    end

    return true, "success"
end

ec.onDropLoot = function(self, corpse)
    if configManager.getNumber(configKeys.RATE_LOOT) == 0 then
        return
    end

    local player = Player(corpse:getCorpseOwner())
    local mType = self:getType()
    if not player or player:getStamina() > 840 then
        local lootItems = {}
        if PoEMonsterLoot and PoEMonsterLoot.rollLoot then
            lootItems = PoEMonsterLoot.rollLoot(self)
        end

        if #lootItems == 0 then
            local monsterLoot = mType:getLoot()
            for i = 1, #monsterLoot do
                local item = corpse:createLootItem(monsterLoot[i])
                if not item then
                    print('[Warning] DropLoot:', 'Could not add loot item to corpse.')
                end
            end
        else
            for _, lootItem in ipairs(lootItems) do
                local created = corpse:createLootItem({
                    itemId = lootItem.itemId or lootItem.id,
                    count = lootItem.count
                })
                if not created then
                    print('[Warning] DropLoot:', 'Could not add loot item to corpse.')
                end
            end
        end

        local lootDescription = corpse:getContentDescription()
        local lootText = ("Loot of %s: %s"):format(mType:getNameDescription(), lootDescription)

        if player then
            local party = player:getParty()
            if party then
                party:broadcastPartyLoot(lootText)
            else
                player:sendTextMessage(MESSAGE_LOOT, lootText)
            end

            local movedAll, reason = moveLootToBackpack(player, corpse)
            if not movedAll and corpse:getSize() > 0 then
                local warning = "Your backpack is full. Loot remains in the corpse."
                if reason == "no-backpack" then
                    warning = "You need a backpack to auto loot. Loot remains in the corpse."
                end
                player:sendTextMessage(MESSAGE_STATUS_SMALL, warning)
            end
        end
    else
        local text = ("Loot of %s: nothing (due to low stamina)"):format(mType:getNameDescription())
        local party = player:getParty()
        if party then
            party:broadcastPartyLoot(text)
        else
            player:sendTextMessage(MESSAGE_LOOT, text)
        end
    end

    if PoEMonsterRarity and PoEMonsterRarity.clearMonsterData then
        PoEMonsterRarity.clearMonsterData(self)
    end
end

ec:register()
