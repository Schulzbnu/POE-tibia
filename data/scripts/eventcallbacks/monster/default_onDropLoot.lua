local ec = EventCallback

local function moveLootToBackpack(player, corpse)
	if not player then
		return false, "no-player"
	end

	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
	if not backpack or not backpack:isContainer() then
		return false, "no-backpack"
	end

	local items = corpse:getItems()
	if #items == 0 then
		return false, "no-loot"
	end

	if backpack:getSize() >= backpack:getCapacity() then
		return false, "backpack-full"
	end

	local blockedBySlots = false
	local movedAnyItem = false
	for _, item in ipairs(items) do
		if backpack:getSize() >= backpack:getCapacity() then
			blockedBySlots = true
			break
		end

		if item:moveTo(backpack) then
			movedAnyItem = true
		else
			if backpack:getSize() >= backpack:getCapacity() then
				blockedBySlots = true
			end
		end
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
		local monsterLoot = mType:getLoot()
		for i = 1, #monsterLoot do
			local item = corpse:createLootItem(monsterLoot[i])
			if not item then
				print('[Warning] DropLoot:', 'Could not add loot item to corpse.')
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
end

ec:register()
