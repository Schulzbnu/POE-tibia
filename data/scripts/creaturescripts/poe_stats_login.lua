local poeStatsLogin = CreatureEvent("PoeStatsLogin")

function poeStatsLogin.onLogin(player)
    -- recalcula e já manda pro client
    if PoeStats and PoeStats.recalculate then
        PoeStats.recalculate(player)
    end
    return true
end

poeStatsLogin:register()
