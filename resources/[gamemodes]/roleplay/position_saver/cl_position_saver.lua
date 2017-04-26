Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(30000)
		local posPlayer = GetEntityCoords(GetPlayerPed(-1))
		TriggerServerEvent('savePos', posPlayer.x, posPlayer.y, posPlayer.z)
	end
end)
-- Si utilisé seul :
AddEventHandler('onClientMapStart', function()
		exports.spawnmanager:setAutoSpawn(true)
		exports.spawnmanager:forceRespawn()
		exports.spawnmanager:setAutoSpawnCallback(function()
			if spawnLock then
				return
			end
			spawnLock = false
			TriggerServerEvent('spawn')
		end)
end)
-- Si utilisé avec un mod qui override l'AutoSpawnCallBack :
AddEventHandler('onClientMapStart', function()
		TriggerServerEvent('spawn')
end)

Citizen.CreateThread(function ()
	while true do
        Wait(0)
        local player = PlayerId()
        if NetworkIsPlayerActive(player) then
            local ped = PlayerPedId()
		    if IsPedFatallyInjured(ped) then
				exports.spawnmanager:setAutoSpawnCallback(function()
			        if spawnLock then
				        return
			        end
			        spawnLock = false
			        TriggerServerEvent('spawnHospital')
			        TriggerEvent('spawnHospital')
		        end)
			end
		end
	end
end)