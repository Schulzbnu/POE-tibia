local function buildItemType(itemTypeName)
  if not itemTypeName then
    return nil
  end

  itemTypeName = string.lower(itemTypeName)
  return ItemStatusConfig.getTypeConfig(itemTypeName) and itemTypeName or nil
end

local function resolveItemType(param)
  local itemTypeName = buildItemType(param)
  if itemTypeName then
    return itemTypeName
  end

  return nil, "Tipo de item inválido."
end

local function resolveRarity(param)
  if param then
    local rarityName = string.lower(param)
    if ItemStatusConfig.getRarityConfig(rarityName) then
      return rarityName
    end
  end

  local rarityNames = {}
  for rarityName in pairs(ItemStatusConfig.rarities) do
    table.insert(rarityNames, rarityName)
  end

  if #rarityNames == 0 then
    return nil, "Nenhuma raridade configurada."
  end

  return rarityNames[math.random(#rarityNames)]
end

local function pickRandomAttributes(attributeList, count)
  local pool = {}
  for index, attribute in ipairs(attributeList) do
    pool[index] = attribute
  end

  local selected = {}
  while count > 0 and #pool > 0 do
    local randomIndex = math.random(#pool)
    table.insert(selected, pool[randomIndex])
    table.remove(pool, randomIndex)
    count = count - 1
  end

  return selected
end

local function rollTier(attributeName)
  local definition = ItemStatusConfig.getAttributeDefinition(attributeName)
  if not definition or not definition.tiers or #definition.tiers == 0 then
    return nil
  end

  local randomTier = definition.tiers[math.random(#definition.tiers)]
  return randomTier.tier, randomTier
end

local function rollAttributeValue(range)
  if not range then
    return nil
  end

  return math.random(range.min, range.max)
end

local function applyAttributes(item, itemTypeName, rarityName)
  local availableAttributes = ItemStatusConfig.getAttributesForType(itemTypeName)
  if #availableAttributes == 0 then
    return 0
  end

  local maxAttributes = ItemStatusConfig.getMaxAttributesForRarity(rarityName)
  if maxAttributes <= 0 then
    return 0
  end

  local attributeCount = math.min(#availableAttributes, math.random(maxAttributes))
  if attributeCount <= 0 then
    return 0
  end

  local chosenAttributes = pickRandomAttributes(availableAttributes, attributeCount)
  local applied = 0

  for _, attributeName in ipairs(chosenAttributes) do
    local tier, range = rollTier(attributeName)
    if tier and range then
      local value = rollAttributeValue(range)
      if value then
        item:setCustomAttribute('attr_' .. attributeName, value)
        item:setCustomAttribute('tier_' .. attributeName, tier)
        applied = applied + 1
      end
    end
  end

  return applied
end

local function parseItemType(param)
  local itemTypeName, errorMessage = resolveItemType(param)
  if not itemTypeName then
    return nil, errorMessage
  end

  return itemTypeName
end

local function parseRarity(param)
  local rarityName, errorMessage = resolveRarity(param)
  if not rarityName then
    return nil, errorMessage
  end

  return rarityName
end

function onSay(player, words, param)
  if not player:getGroup():getAccess() then
    return true
  end

  if player:getAccountType() < ACCOUNT_TYPE_GOD then
    return false
  end

  local params = param:splitTrimmed(",")
  if #params < 2 then
    player:sendCancelMessage("Uso: /rollitem <itemId|nome>,<tipo>,[raridade]")
    return false
  end

  local itemTypeName, itemTypeError = parseItemType(params[2])
  if not itemTypeName then
    player:sendCancelMessage(itemTypeError)
    return false
  end

  local rarityName, rarityError = parseRarity(params[3])
  if not rarityName then
    player:sendCancelMessage(rarityError)
    return false
  end

  local itemType = ItemType(params[1])
  if itemType:getId() == 0 then
    itemType = ItemType(tonumber(params[1]))
    if not tonumber(params[1]) or itemType:getId() == 0 then
      player:sendCancelMessage("Nenhum item encontrado com esse id ou nome.")
      return false
    end
  end

  local item = player:addItem(itemType:getId(), 1)
  if not item then
    player:sendCancelMessage("Não foi possível criar o item.")
    return false
  end

  item:setCustomAttribute('itemType', itemTypeName)
  item:setCustomAttribute('rarity', rarityName)

  local applied = applyAttributes(item, itemTypeName, rarityName)
  local rarityLabel = (ItemStatusConfig.getRarityConfig(rarityName) or {}).label or rarityName
  local typeLabel = (ItemStatusConfig.getTypeConfig(itemTypeName) or {}).label or itemTypeName

  player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
  player:sendTextMessage(
    MESSAGE_EVENT_ADVANCE,
    string.format(
      "Você criou um item %s do tipo %s com %d atributo(s).",
      rarityLabel,
      typeLabel,
      applied
    )
  )

  return false
end
