ESX = nil
local showeringPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('playerShower')
AddEventHandler('playerShower', function()
    local src = source

    if showeringPlayers[src] then
        TriggerClientEvent('showerNotification', src, 'Someone is already showering.')
    else
        showeringPlayers[src] = true
        TriggerClientEvent('startShower', src)
    end
end)

RegisterServerEvent('playerStoppedShowering')
AddEventHandler('playerStoppedShowering', function()
    local src = source
    showeringPlayers[src] = nil
end)

