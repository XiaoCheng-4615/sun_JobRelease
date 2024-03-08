
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

Citizen.CreateThread(function()


	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, Config.key) then 
		  ESX.PlayerData = ESX.GetPlayerData()
		  	for v, k in ipairs(Config.job) do
				if ESX.PlayerData.job.name == k then
					ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "coming_JobOrder", {
						title = "接單系統: <單號>"
					}, function(data, menu)
						local JobOrder = tonumber(data.value)
						if JobOrder == nil then
				 			ESX.ShowNotification('~r~請輸入數字')
						else
							TriggerServerEvent("sun_JobRelease:mes", JobOrder)
							
							menu.close()
						end
					end, function(data, menu)
			 		menu.close()
					end)
				end
		  	end				
		end
	end
end)


RegisterNetEvent('sun_JobRelease:sumbit')
AddEventHandler('sun_JobRelease:sumbit', function(coords,xPlayer)
	print(coords)
	-- local myPoss = GetEntityCoords(PlayerId(mes))
	-- print(myPoss,myPosss)
	if xPlayer then
		SetNewWaypoint(tonumber(coords.x), tonumber(coords.y))
	end
end)

