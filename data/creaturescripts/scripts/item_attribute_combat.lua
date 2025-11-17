local monitoredSlots = {
  CONST_SLOT_HEAD,
  CONST_SLOT_NECKLACE,
  CONST_SLOT_BACKPACK,
  CONST_SLOT_ARMOR,
  CONST_SLOT_RIGHT,
  CONST_SLOT_LEFT,
  CONST_SLOT_LEGS,
  CONST_SLOT_FEET,
  CONST_SLOT_RING,
  CONST_SLOT_AMMO,
}

local function addAttributeTotalsFromItem(totals, item)
  if not item then
    return
  end

  local attributeList
  local itemTypeName = item:getCustomAttribute('itemType')
  if itemTypeName then
    local typeConfig = ItemStatusConfig.getTypeConfig(itemTypeName)
    attributeList = typeConfig and typeConfig.attributes
  end

  -- Fallback: if the item has attributes but no itemType metadata, scan all
  -- known attribute definitions so custom values are still applied in combat.
  if not attributeList then
    attributeList = {}
    for attributeName in pairs(ItemStatusConfig.baseAttributes) do
      table.insert(attributeList, attributeName)
    end
  end

  for _, attributeName in ipairs(attributeList) do
    local value = item:getCustomAttribute('attr_' .. attributeName)
    if value then
      totals[attributeName] = (totals[attributeName] or 0) + value
    end
  end
end

local function collectAttributeTotals(creature)
  local totals = {}
  if not creature or not creature.getSlotItem or not creature:isPlayer() then
    return totals
  end

  for _, slot in ipairs(monitoredSlots) do
    local slotItem = creature:getSlotItem(slot)
    addAttributeTotalsFromItem(totals, slotItem)
  end

  return totals
end

local function isDistanceAttacker(creature)
  if not creature or not creature:isPlayer() then
    return false
  end

  local left = creature:getSlotItem(CONST_SLOT_LEFT)
  if left then
    local itemType = left:getType()
    if itemType and itemType:getWeaponType() == WEAPON_DISTANCE then
      return true
    end
  end

  local right = creature:getSlotItem(CONST_SLOT_RIGHT)
  if right then
    local itemType = right:getType()
    if itemType and itemType:getWeaponType() == WEAPON_DISTANCE then
      return true
    end
  end

  return false
end

local function applyOffensiveAttributes(damageValue, damageType, totals, distanceAttacker)
  local result = damageValue

  if damageType == COMBAT_PHYSICALDAMAGE then
    result = result + (totals.physicalDamage or 0)
    result = result - math.floor((totals.physicalMitigation or 0) * 0.01 * result)
  else
    result = result + (totals.elementalDamage or 0)
    result = result - math.floor((totals.elementalResistance or 0) * 0.01 * result)
  end

  if distanceAttacker and totals.projectileDamage then
    result = result + math.floor(result * totals.projectileDamage * 0.01)
  end

  if totals.attackSpeed and totals.attackSpeed > 0 then
    result = result + math.floor(result * totals.attackSpeed * 0.01)
  end

  local criticalChance = totals.criticalChance or 0
  if criticalChance > 0 and math.random(100) <= criticalChance then
    result = math.floor(result * 1.5)
  end

  return math.max(result, 0)
end

local function applyDefensiveAttributes(damageValue, damageType, totals)
  local result = damageValue

  if damageType == COMBAT_PHYSICALDAMAGE then
    result = result - (totals.armorRating or 0)
    result = result - math.floor((totals.physicalMitigation or 0) * 0.01 * result)
    if totals.blockChance and totals.blockChance > 0 then
      if math.random(100) <= totals.blockChance then
        result = 0
      end
    end
  else
    result = result - math.floor((totals.elementalResistance or 0) * 0.01 * result)
    if totals.spellBlock and totals.spellBlock > 0 then
      if math.random(100) <= totals.spellBlock then
        result = 0
      end
    end
  end

  if totals.maximumLife and totals.maximumLife > 0 then
    result = result - math.floor(totals.maximumLife * 0.05)
  end

  if damageType ~= COMBAT_PHYSICALDAMAGE and totals.maximumMana and totals.maximumMana > 0 then
    result = result - math.floor(totals.maximumMana * 0.05)
  end

  if totals.movementSpeed and totals.movementSpeed > 0 then
    result = result - math.floor(result * totals.movementSpeed * 0.01)
  end

  return math.max(result, 0)
end

local function applyLeech(attacker, damageDealt, totals)
  if not attacker or not attacker:isPlayer() then
    return
  end

  if damageDealt <= 0 then
    return
  end

  local lifeLeechPercent = totals.lifeLeech or 0
  if lifeLeechPercent > 0 then
    local healAmount = math.floor(damageDealt * lifeLeechPercent * 0.01)
    if healAmount > 0 then
      attacker:addHealth(healAmount)
    end
  end

  local manaLeechPercent = totals.manaLeech or 0
  if manaLeechPercent > 0 then
    local manaAmount = math.floor(damageDealt * manaLeechPercent * 0.01)
    if manaAmount > 0 then
      attacker:addMana(manaAmount)
    end
  end
end

local function applyRegeneration(creature, totals)
  if not creature then
    return
  end

  local lifeTick = (totals.lifeRegeneration or 0)
  if totals.maximumLife and totals.maximumLife > 0 then
    lifeTick = lifeTick + math.floor(totals.maximumLife * 0.02)
  end

  if lifeTick > 0 then
    creature:addHealth(lifeTick)
  end

  local manaTick = (totals.manaRegeneration or 0)
  if totals.maximumMana and totals.maximumMana > 0 then
    manaTick = manaTick + math.floor(totals.maximumMana * 0.02)
  end

  if manaTick > 0 then
    creature:addMana(manaTick)
  end
end

local function sendServlogMessage(target, message)
  if target and target:isPlayer() then
    target:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, message)
  end
end

local function logCombatEvent(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, modifiedPrimary, modifiedSecondary)
  local attackerName = (attacker and attacker.getName and attacker:getName()) or "Unknown"
  local defenderName = (creature and creature.getName and creature:getName()) or "Unknown"

  local message = string.format(
    "ItemAttributeCombat: %s -> %s | Primary %d→%d (type %d), Secondary %d→%d (type %d)",
    attackerName,
    defenderName,
    primaryDamage,
    modifiedPrimary,
    primaryType,
    secondaryDamage,
    modifiedSecondary,
    secondaryType
  )

  sendServlogMessage(attacker, message)
  sendServlogMessage(creature, message)
end

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
  local attackerTotals = collectAttributeTotals(attacker)
  local defenderTotals = collectAttributeTotals(creature)

  local distanceAttacker = isDistanceAttacker(attacker)

  local modifiedPrimary = applyOffensiveAttributes(primaryDamage, primaryType, attackerTotals, distanceAttacker)
  modifiedPrimary = applyDefensiveAttributes(modifiedPrimary, primaryType, defenderTotals)

  local modifiedSecondary = applyOffensiveAttributes(secondaryDamage, secondaryType, attackerTotals, distanceAttacker)
  modifiedSecondary = applyDefensiveAttributes(modifiedSecondary, secondaryType, defenderTotals)

  local totalDealt = math.max(modifiedPrimary, 0) + math.max(modifiedSecondary, 0)
  applyLeech(attacker, totalDealt, attackerTotals)

  applyRegeneration(attacker, attackerTotals)
  applyRegeneration(creature, defenderTotals)

  logCombatEvent(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, modifiedPrimary, modifiedSecondary)

  return modifiedPrimary, primaryType, modifiedSecondary, secondaryType
end
