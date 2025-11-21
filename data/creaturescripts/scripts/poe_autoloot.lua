local POE_AUTOLOOT_OPCODE = 51

local function split(str, sep)
  if not str then
    return {}
  end

  if type(str.split) == 'function' then
    return str:split(sep)
  end

  if type(string.explode) == 'function' then
    return string.explode(str, sep)
  end

  local result = {}
  local pattern = string.format('([^%s]+)', sep)
  str:gsub(pattern, function(value) table.insert(result, value) end)
  return result
end

local function sendConfigToClient(player)
  local enabled = player:getStorageValue(95000) == 1
  local minRarity = player:getStorageValue(95001) ~= -1 and player:getStorageValue(95001) or "Normal"
  local itemType = player:getStorageValue(95002) ~= -1 and player:getStorageValue(95002) or "Armaduras"
  local itemsStr = player:getStorageValue(95003) ~= -1 and player:getStorageValue(95003) or ""

  local payload = table.concat({
    enabled and "1" or "0",
    minRarity,
    itemType,
    itemsStr
  }, "|")

  player:sendExtendedOpcode(POE_AUTOLOOT_OPCODE, payload)
end

local poeAutolootEvent = CreatureEvent("PoeAutolootOpcode")

function poeAutolootEvent.onExtendedOpcode(player, opcode, buffer)
  if opcode ~= POE_AUTOLOOT_OPCODE then
    return true
  end

  local parts = split(buffer, "|")
  if #parts < 4 then
    return true
  end

  local enabled = (parts[1] == "1")
  local minRarity = parts[2]
  local itemType = parts[3]
  local itemsStr = parts[4]

  player:setStorageValue(95000, enabled and 1 or 0)
  player:setStorageValue(95001, minRarity)
  player:setStorageValue(95002, itemType)
  player:setStorageValue(95003, itemsStr)

  print(string.format("[POE_AUTOLOOT] %s updated config enabled=%s minRarity=%s type=%s items=%s",
    player:getName(), tostring(enabled), minRarity, itemType, itemsStr))

  return true
end

poeAutolootEvent:register()

local poeAutolootLogin = CreatureEvent("PoeAutolootLogin")

function poeAutolootLogin.onLogin(player)
  sendConfigToClient(player)
  return true
end

poeAutolootLogin:register()
