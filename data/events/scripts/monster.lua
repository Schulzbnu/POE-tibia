function Monster:onDropLoot(corpse)
	if hasEventCallback(EVENT_CALLBACK_ONDROPLOOT) then
		EventCallback(EVENT_CALLBACK_ONDROPLOOT, self, corpse)
	end
end

function Monster:onSpawn(position, startup, artificial)	
	if hasEventCallback(EVENT_CALLBACK_ONSPAWN) then		
		if not self:registerEvent("PoeCombat") then
			self:registerEvent("PoeCombat")
		end
		return EventCallback(EVENT_CALLBACK_ONSPAWN, self, position, startup, artificial)		
	else
		self:registerEvent("PoeCombat")		
		return true
	end
end
