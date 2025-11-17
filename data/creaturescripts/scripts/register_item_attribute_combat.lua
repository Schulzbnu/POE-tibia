function onSpawn(creature)
  if creature and creature:isMonster() then
    creature:registerEvent("ItemAttributeCombat")
  end

  return true
end
