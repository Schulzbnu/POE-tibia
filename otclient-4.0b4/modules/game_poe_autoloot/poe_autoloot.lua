-- modules/game_poe_autoloot/poe_autoloot.lua

local POE_AUTOLOOT_OPCODE = 51 -- escolhe um diferente do de stats (50)

game_poe_autoloot = {}

local lootWindow
local rarityCombo
local typeCombo
local enableCheck
local itemsTable

local rarities = { "Normal", "Magic", "Rare", "Unique" }
local types = { "Armaduras", "Armas", "Anéis", "Amuletos", "Gemas", "Diversos" }

-- Estrutura local de config
local config = {
  enabled = false,
  minRarity = "Normal",
  type = "Armaduras",
  items = {} -- { {id=2494, name="Demon Armor", rarity="Unique"}, ... }
}

local function split(str, sep)
  if string.split then
    return str:split(sep)
  end

  local result = {}
  local pattern = string.format("([^%s]+)", sep)
  str:gsub(pattern, function(value) table.insert(result, value) end)
  return result
end

local function fillCombos()
  rarityCombo:clear()
  for _, r in ipairs(rarities) do
    rarityCombo:addOption(r)
  end
  rarityCombo:setCurrentOptionByText(config.minRarity)

  typeCombo:clear()
  for _, t in ipairs(types) do
    typeCombo:addOption(t)
  end
  typeCombo:setCurrentOptionByText(config.type)
end

local function refreshItemsTable()
  itemsTable:clear()
  for _, entry in ipairs(config.items) do
    local row = itemsTable:addRow()
    row:setColumnText(1, tostring(entry.id))
    row:setColumnText(2, entry.name or "")
    row:setColumnText(3, entry.rarity or "")
  end
end

local function applyConfigToUI()
  enableCheck:setChecked(config.enabled)
  fillCombos()
  refreshItemsTable()
end

local function serializeConfig()
  -- simples: usa JSON se tiver lib, ou string "enabled|minRarity|type|id1,rarity1;id2,rarity2"
  -- aqui um formato simples:
  local parts = {}
  table.insert(parts, config.enabled and "1" or "0")
  table.insert(parts, config.minRarity)
  table.insert(parts, config.type)

  local itemsParts = {}
  for _, entry in ipairs(config.items) do
    table.insert(itemsParts, string.format("%d,%s", entry.id, entry.rarity or ""))
  end
  table.insert(parts, table.concat(itemsParts, ";"))

  return table.concat(parts, "|")
end

local function parseConfig(str)
  if not str or str == "" then return end
  local p = split(str, "|")
  if #p < 4 then return end

  config.enabled = (p[1] == "1")
  config.minRarity = p[2] or "Normal"
  config.type = p[3] or "Armaduras"

  config.items = {}
  if p[4] ~= "" then
    local itemsParts = split(p[4], ";")
    for _, itemStr in ipairs(itemsParts) do
      local fields = split(itemStr, ",")
      local id = tonumber(fields[1])
      local rarity = fields[2] or "Normal"
      if id then
        table.insert(config.items, { id = id, name = "", rarity = rarity })
      end
    end
  end
end

-- Enviar config pro servidor
local function sendConfigToServer()
  if not g_game.isOnline() then return end
  local payload = serializeConfig()
  g_game.getProtocolGame():sendExtendedOpcode(POE_AUTOLOOT_OPCODE, payload)
end

-- Receber config do servidor
local function onExtendedOpcode(protocol, opcode, buffer)
  if opcode ~= POE_AUTOLOOT_OPCODE then
    return
  end

  -- servidor manda string no mesmo formato de serializeConfig()
  parseConfig(buffer)
  if lootWindow and lootWindow:isVisible() then
    applyConfigToUI()
  end
end

-- Botões / eventos UI

local function onSaveClicked()
  config.enabled = enableCheck:isChecked()
  config.minRarity = rarityCombo:getCurrentOption().text
  config.type = typeCombo:getCurrentOption().text

  sendConfigToServer()
end

local function onAddItemClicked()
  -- aqui você pode abrir uma mini janela pra digitar ID/raridade
  -- por enquanto, só exemplo bruto
  local newId = tonumber(g_game.getLocalPlayer():getId()) -- só pra não ficar vazio kkk
  table.insert(config.items, { id = newId, name = "Teste", rarity = config.minRarity })
  refreshItemsTable()
end

local function onRemoveItemClicked()
  local row = itemsTable:getFocusedRow()
  if not row then return end
  local rowIndex = row:getId()
  table.remove(config.items, rowIndex)
  refreshItemsTable()
end

-- API pública

function game_poe_autoloot.show()
  if not lootWindow then
    lootWindow = g_ui.displayUI('poe_autoloot.otui')
    lootWindow:hide()

    enableCheck = lootWindow:getChildById('enableAutolootCheck')
    rarityCombo = lootWindow:getChildById('rarityCombo')
    typeCombo = lootWindow:getChildById('typeCombo')
    itemsTable = lootWindow:getChildById('itemsTable')

    local addBtn = lootWindow:getChildById('addItemButton')
    local remBtn = lootWindow:getChildById('removeItemButton')
    local saveBtn = lootWindow:getChildById('saveButton')

    connect(addBtn, { onClick = onAddItemClicked })
    connect(remBtn, { onClick = onRemoveItemClicked })
    connect(saveBtn, { onClick = onSaveClicked })

    -- Config de colunas da tabela (3 colunas: ID, Nome, Raridade)
    itemsTable:addColumn("ID")
    itemsTable:addColumn("Nome")
    itemsTable:addColumn("Raridade")
  end

  applyConfigToUI()
  lootWindow:show()
  lootWindow:raise()
  lootWindow:focus()
end

function game_poe_autoloot.hide()
  if lootWindow then
    lootWindow:hide()
  end
end

function game_poe_autoloot.toggle()
  if not lootWindow or not lootWindow:isVisible() then
    game_poe_autoloot.show()
  else
    game_poe_autoloot.hide()
  end
end

function init()
  ProtocolGame.registerExtendedOpcode(POE_AUTOLOOT_OPCODE, onExtendedOpcode)

  -- você pode adicionar um botão na barra de skills/teclas
  -- ou usar hotkey: ex: bind Ctrl+L
  g_keyboard.bindKeyPress('Ctrl+L', game_poe_autoloot.toggle)
end

function terminate()
  g_keyboard.unbindKeyPress('Ctrl+L')
  ProtocolGame.unregisterExtendedOpcode(POE_AUTOLOOT_OPCODE)
  if lootWindow then
    lootWindow:destroy()
    lootWindow = nil
  end
end
