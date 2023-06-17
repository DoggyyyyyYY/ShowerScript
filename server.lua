ESX = nil
local showeringPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent('playerShower')
AddEventHandler('playerShower', function(x, y, z, heading)
    local src = source
    local coords = { x = x, y = y, z = z, heading = heading }

    if showeringPlayers[src] then
        TriggerClientEvent('showerNotification', src, 'Someone is already showering.')
    else
        showeringPlayers[src] = true
        TriggerClientEvent('startShower', src, coords)
    end
end)

RegisterServerEvent('playerStoppedShowering')
AddEventHandler('playerStoppedShowering', function()
    local src = source
    showeringPlayers[src] = nil
end)
