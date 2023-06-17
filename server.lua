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






local curVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
local resourceName = "wasabi_sellshop"

if Config.checkForUpdates then
    CreateThread(function()
        if GetCurrentResourceName() ~= "shower" then
            resourceName = "shower (" .. GetCurrentResourceName() .. ")"
        end
    end)

    CreateThread(function()
        while true do
            PerformHttpRequest("https://api.github.com/repos/wasabirobby/wasabi_sellshop/releases/latest", CheckVersion, "GET")
            Wait(3600000)
        end
    end)

    CheckVersion = function(err, responseText, headers)
        local repoVersion, repoURL, repoBody = GetRepoInformations()

        CreateThread(function()
            if curVersion ~= repoVersion then
                Wait(4000)
                print("^0[^3WARNING^0] " .. resourceName .. " is ^1NOT ^0up to date!")
                print("^0[^3WARNING^0] Your Version: ^2" .. curVersion .. "^0")
                print("^0[^3WARNING^0] Latest Version: ^2" .. repoVersion .. "^0")
                print("^0[^3WARNING^0] Get the latest Version from: ^2" .. repoURL .. "^0")
                print("^0[^3WARNING^0] Changelog:^0")
                print("^1" .. repoBody .. "^0")
            else
                Wait(4000)
                print("^0[^2INFO^0] " .. resourceName .. " is up to date! (^2" .. curVersion .. "^0)")
            end
        end)
    end

    GetRepoInformations = function()
        local repoVersion, repoURL, repoBody = nil, nil, nil

        PerformHttpRequest("https://api.github.com/repos/wasabirobby/wasabi_sellshop/releases/latest", function(err, response, headers)
            if err == 200 then
                local data = json.decode(response)

                repoVersion = data.tag_name
                repoURL = data.html_url
                repoBody = data.body
            else
                repoVersion = curVersion
                repoURL = "https://github.com/wasabirobby/wasabi_sellshop"
            end
        end, "GET")

        repeat
            Wait(50)
        until (repoVersion and repoURL and repoBody)

        return repoVersion, repoURL, repoBody
    end
end
