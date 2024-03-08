
if Config.oldESX then
    print('framework use esx limit(1.1)')
    print('SUN SRCIPT | PHACS DEV')
    ESX = nil
    
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
else
    ESX = exports["es_extended"]:getSharedObject()
    print('framework use Esx Legacy')
    print('SUN SRCIPT | PHACS DEV')
end

RegisterServerEvent('sun_JobRelease:mes')
AddEventHandler('sun_JobRelease:mes', function(mes, mes2)
    local xPlayer = ESX.GetPlayerFromId(source)
    local zPlayer = ESX.GetPlayerFromId(mes)

     if source == mes then 
        NotifyPlayer(source, "不行輸入自己的id")
    else
        HandleJobOrder(xPlayer, zPlayer, mes)
    end
end)





function SendToDiscordChannel(channel, message)
    PerformHttpRequest(Config.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({ username = channel, content = message }), { ['Content-Type'] = 'application/json' })
end
