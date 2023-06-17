ESX = nil
local showering = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('startShower')
AddEventHandler('startShower', function(showerCoords)
    if showering then
        return
    end

    showering = true
    local playerPed = PlayerPedId()

    RequestAnimDict('anim@mp_yacht@shower@male@')
    while not HasAnimDictLoaded('anim@mp_yacht@shower@male@') do
        Citizen.Wait(0)
    end

    SetEntityCoords(playerPed, showerCoords.x, showerCoords.y, showerCoords.z, false, false, false, false)
    SetEntityHeading(playerPed, showerCoords.heading)
    TaskPlayAnim(playerPed, 'anim@mp_yacht@shower@male@', 'male_shower_idle_a', 8.0, -8.0, -1, 49, 0, false, false, false)

    exports['progressBars']:startUI(Config.ShowerDuration, "Taking a shower")

    Citizen.Wait(Config.ShowerDuration)

    showering = false
    ClearPedTasks(playerPed)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('playerStoppedShowering')
end)

RegisterNetEvent('showerNotification')
AddEventHandler('showerNotification', function(message)
    ESX.ShowNotification(message)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, coords in ipairs(Config.ShowerCoords) do
            local distance = #(playerCoords - vector3(coords.x, coords.y, coords.z))
            if distance < Config.MarkerDistance then
                DrawMarker(Config.MarkerType, coords.x, coords.y, coords.z - 1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, nil, nil, false)
                if distance < Config.MarkerSize.x then
                    ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to take a shower')
                    if IsControlJustReleased(0, Config.ShowerControl) and not showering and not IsEntityInWater(playerPed) then
TriggerServerEvent('playerShower', coords.x, coords.y, coords.z, coords.heading)
                    end
                end
            end
        end

        if showering then
            DisableControlAction(0, 24, true) -- Disable Attack
            DisablePlayerFiring(playerPed, true) -- Disable Firing
            DisableControlAction(0, 142, true) -- Disable MeleeAttackAlternate
            DisableControlAction(0, 106, true) -- Disable VehicleMouseControlOverride
            FreezeEntityPosition(playerPed, true)
        end
    end
end)
