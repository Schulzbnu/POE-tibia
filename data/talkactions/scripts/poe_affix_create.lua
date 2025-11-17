local function usage(player, words)
  local example = string.format('%s itemId|name, raridade, tipo, [quantidade], atributo:tier[:valor], ...', words)
  player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Uso: ' .. example)
  player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Exemplo: ' .. string.format('%s 2494, rare, weapon, criticalChance:3, physicalDamage:2:10', words))
end

local function resolveItemType(identifier)
  local itemType = ItemType(identifier)
  if itemType:getId() == 0 and tonumber(identifier) then
    itemType = ItemType(tonumber(identifier))
  end
  return itemType
end

local function sanitizeCount(itemType, count)
  if not count or count < 1 then
    return 1
  end

  if itemType:isStackable() then
    return math.min(10000, count)
  end

  if itemType:isFluidContainer() then
    return 0
  end

  return math.min(100, count)
end

local function parseAttributeSpec(spec)
  local name, tierStr, valueStr = spec:match('^([^:]+):(%d+):?(.*)$')
  if not name then
    return nil, 'Formato inválido para atributo: use atributo:tier[:valor]'
  end

  name = string.lower(string.trim(name))
  local tier = tonumber(tierStr)
  if not tier then
    return nil, 'Tier inválido para atributo: ' .. spec
  end

  local value = nil
  if valueStr ~= nil and valueStr ~= '' then
    value = tonumber(valueStr)
    if not value then
      return nil, 'Valor inválido para atributo: ' .. spec
    end
  end

  return { name = name, tier = tier, value = value }
end

local function validateAttribute(attrSpec, itemTypeName)
  local typeConfig = ItemStatusConfig.getTypeConfig(itemTypeName)
  if not typeConfig then
    return false, 'Tipo de item inválido: ' .. itemTypeName
  end

  if not table.contains(typeConfig.attributes, attrSpec.name) then
    return false, string.format('O atributo %s não é permitido para o tipo %s', attrSpec.name, itemTypeName)
  end

  local range = ItemStatusConfig.getTierRange(attrSpec.name, attrSpec.tier)
  if not range then
    return false, string.format('Tier %d inválido para o atributo %s', attrSpec.tier, attrSpec.name)
  end

  if attrSpec.value then
    if attrSpec.value < range.min or attrSpec.value > range.max then
      return false, string.format('Valor %d fora do intervalo [%d - %d] para %s tier %d', attrSpec.value, range.min, range.max, attrSpec.name, attrSpec.tier)
    end
  end

  return true, nil
end

local function buildAttributes(parts, startIndex, itemTypeName, maxAttributes)
  local attributes = {}
  local count = 0

  for i = startIndex, #parts do
    local specText = parts[i]
    if specText ~= '' then
      local attrSpec, err = parseAttributeSpec(specText)
      if not attrSpec then
        return nil, err
      end

      local ok, validationError = validateAttribute(attrSpec, itemTypeName)
      if not ok then
        return nil, validationError
      end

      count = count + 1
      if count > maxAttributes then
        return nil, string.format('Raridade permite no máximo %d atributos', maxAttributes)
      end

      local range = ItemStatusConfig.getTierRange(attrSpec.name, attrSpec.tier)
      local value = attrSpec.value or math.random(range.min, range.max)
      attributes[attrSpec.name] = { value = value, tier = attrSpec.tier }
    end
  end

  if count == 0 and maxAttributes > 0 then
    return nil, 'Nenhum atributo informado.'
  end

  return attributes, nil
end

local function applyCustomAttributes(item, rarityName, itemTypeName, attributes)
  item:setCustomAttribute('rarity', rarityName)
  item:setCustomAttribute('itemType', itemTypeName)

  if not attributes then
    return
  end

  for name, data in pairs(attributes) do
    item:setCustomAttribute('attr_' .. name, data.value)
    item:setCustomAttribute('tier_' .. name, data.tier)
  end
end

local function createItemWithAttributes(player, itemType, count, rarityName, itemTypeName, attributes)
  local created = player:addItem(itemType:getId(), count)
  if not created then
    return false
  end

  if type(created) == 'table' then
    for _, item in ipairs(created) do
      applyCustomAttributes(item, rarityName, itemTypeName, attributes)
      item:decay()
    end
  else
    applyCustomAttributes(created, rarityName, itemTypeName, attributes)
    if not itemType:isStackable() then
      created:decay()
    end
  end

  return true
end

function onSay(player, words, param)
  if not player:getGroup():getAccess() then
    return true
  end

  if player:getAccountType() < ACCOUNT_TYPE_GOD then
    return false
  end

  local parts = param:splitTrimmed(',')
  if #parts < 3 then
    usage(player, words)
    return false
  end

  local itemType = resolveItemType(parts[1])
  if not itemType or itemType:getId() == 0 then
    player:sendCancelMessage('Item inválido: ' .. parts[1])
    return false
  end

  local rarityName = string.lower(parts[2])
  local rarityConfig = ItemStatusConfig.getRarityConfig(rarityName)
  if not rarityConfig then
    player:sendCancelMessage('Raridade inválida: ' .. parts[2])
    return false
  end

  local itemTypeName = string.lower(parts[3])
  local typeConfig = ItemStatusConfig.getTypeConfig(itemTypeName)
  if not typeConfig then
    player:sendCancelMessage('Tipo de item inválido: ' .. parts[3])
    return false
  end

  local countIndex = 4
  local count = 1
  if parts[4] and parts[4]:match('^%d+$') then
    count = sanitizeCount(itemType, tonumber(parts[4]))
    countIndex = 5
  end

  local attributes, attrError = buildAttributes(parts, countIndex, itemTypeName, rarityConfig.maxAttributes)
  if attrError then
    player:sendCancelMessage(attrError)
    return false
  end

  local success = createItemWithAttributes(player, itemType, count, rarityName, itemTypeName, attributes)
  if not success then
    player:sendCancelMessage('Não foi possível criar o item solicitado.')
    return false
  end

  player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
  player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format('Criado %s (%s) com raridade %s.', itemType:getName(), itemTypeName, rarityConfig.label))
  return false
end
