local ec = EventCallback

ec.onLookInBattleList = function(self, creature, distance)
	local description = "You see " .. creature:getDescription(distance)

    if creature:isCreature() then
            if creature:isMonster() then
                    local lvl = 0
                    local rank = "Normal"
                    if PoEMonsterLevels and PoEMonsterLevels.getMonsterLevel then
                    lvl = PoEMonsterLevels.getMonsterLevel(creature) or 0
                    end
                    if PoEMonsterRarity and PoEMonsterRarity.getMonsterRank then
                    rank = PoEMonsterRarity.getMonsterRank(creature) or "Normal"
                    end
                    description = string.format(
                    "%s\n[RARITY: %s] [LEVEL: %d]",
                    description, rank, lvl
                    )
            end
    end

	if self:getGroup():getAccess() then
		local str = "%s\nHealth: %d / %d"
		if creature:isPlayer() and creature:getMaxMana() > 0 then
			str = string.format("%s, Mana: %d / %d", str, creature:getMana(), creature:getMaxMana())
		end
		description = string.format(str, description, creature:getHealth(), creature:getMaxHealth()) .. "."

		local position = creature:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)

		if creature:isPlayer() then
			description = string.format("%s\nIP: %s", description, Game.convertIpToString(creature:getIp()))
		end
	end
	return description
end

ec:register()
