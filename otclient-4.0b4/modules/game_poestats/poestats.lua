local poeStatsButton
local poeStatsWindow

local statusLabel
local critChanceLabel
local lifeLeechLabel
local blockChanceLabel
local moveSpeedLabel
local lifeRegenLabel

local STAT_PREFIX = 'Player Stats (PoE)'
local REQUEST_COMMAND = '/stats'

local messageModeConnections = {}

local function isPoeStatsMessage(message)
    return message:find(STAT_PREFIX, 1, true) ~= nil
end

local function setStatus(text)
    if statusLabel then
        statusLabel:setText(text)
    end
end

local function setStatValue(label, value, suffix)
    if not label then
        return
    end
    suffix = suffix or ''
    label:setText(string.format('%s%s', value, suffix))
end

local function resetStats()
    setStatValue(critChanceLabel, '--')
    setStatValue(lifeLeechLabel, '--')
    setStatValue(blockChanceLabel, '--')
    setStatValue(moveSpeedLabel, '--')
    setStatValue(lifeRegenLabel, '--')
end

local function parseNumber(message, key)
    local pattern = key .. ':%s*([%d]+)'
    local value = message:match(pattern)
    if value then
        return tonumber(value) or 0
    end
    return nil
end

local function updateStatsFromMessage(message)
    local crit = parseNumber(message, 'Crit Chance') or 0
    local leech = parseNumber(message, 'Life Leech') or 0
    local block = parseNumber(message, 'Block Chance') or 0
    local speed = parseNumber(message, 'Move Speed') or 0
    local regen = parseNumber(message, 'Life Regen') or 0

    setStatValue(critChanceLabel, crit, '%')
    setStatValue(lifeLeechLabel, leech, '%')
    setStatValue(blockChanceLabel, block, '%')
    setStatValue(moveSpeedLabel, speed)
    setStatValue(lifeRegenLabel, regen, '/s')

    setStatus(tr('Valores atualizados a partir do servidor.'))
end

local function onTextMessage(_, message)
    if not poeStatsWindow or not poeStatsWindow:isVisible() then
        return
    end

    if not isPoeStatsMessage(message) then
        return
    end

    updateStatsFromMessage(message)
end

local function connectMessageModes()
    for _, mode in pairs(MessageModes) do
        if type(mode) == 'number' and not messageModeConnections[mode] then
            registerMessageMode(mode, onTextMessage)
            messageModeConnections[mode] = true
        end
    end
end

local function disconnectMessageModes()
    for mode, connected in pairs(messageModeConnections) do
        if connected then
            unregisterMessageMode(mode, onTextMessage)
            messageModeConnections[mode] = false
        end
    end
end

local function ensureButton()
    if poeStatsButton then
        return
    end

    poeStatsButton = modules.game_mainpanel.addToggleButton('poeStatsButton', tr('PoE Stats'),
        '/images/options/button_skills', modules.game_poestats.toggle, false, 6)
    poeStatsButton:setOn(false)
end

function requestStats()
    if not g_game.isOnline() then
        setStatus(tr('Você precisa estar online para ver os atributos.'))
        return
    end

    setStatus(tr('Solicitando atributos ao servidor...'))
    resetStats()
    g_game.talk(REQUEST_COMMAND)
end

function toggle()
    if not poeStatsWindow then
        return
    end

    local visible = poeStatsWindow:isVisible()
    poeStatsWindow:setVisible(not visible)

    if poeStatsButton then
        poeStatsButton:setOn(not visible)
    end

    if not visible then
        poeStatsWindow:raise()
        poeStatsWindow:focus()
        requestStats()
    end
end

local function online()
    ensureButton()
    connectMessageModes()
    setStatus(tr('Aguardando atualização...'))
    resetStats()
end

local function offline()
    if poeStatsButton then
        poeStatsButton:setOn(false)
    end
    if poeStatsWindow then
        poeStatsWindow:hide()
    end
    setStatus(tr('Você está offline.'))
    resetStats()
end

function init()
    connect(g_game, { onGameStart = online, onGameEnd = offline })

    poeStatsWindow = g_ui.displayUI('poestats', modules.game_interface.getRightPanel())
    poeStatsWindow:hide()

    statusLabel = poeStatsWindow:recursiveGetChildById('statusLabel')
    critChanceLabel = poeStatsWindow:recursiveGetChildById('critChanceValue')
    lifeLeechLabel = poeStatsWindow:recursiveGetChildById('lifeLeechValue')
    blockChanceLabel = poeStatsWindow:recursiveGetChildById('blockChanceValue')
    moveSpeedLabel = poeStatsWindow:recursiveGetChildById('moveSpeedValue')
    lifeRegenLabel = poeStatsWindow:recursiveGetChildById('lifeRegenValue')

    ensureButton()
    connectMessageModes()
end

function terminate()
    disconnect(g_game, { onGameStart = online, onGameEnd = offline })
    disconnectMessageModes()

    if poeStatsWindow then
        poeStatsWindow:destroy()
        poeStatsWindow = nil
    end

    if poeStatsButton then
        poeStatsButton:destroy()
        poeStatsButton = nil
    end
end
