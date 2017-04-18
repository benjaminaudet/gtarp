Citizen.CreateThread(function ()
	Citizen.Wait(1000)
	TriggerServerEvent('life:save_money')
	TriggerServerEvent('life:starving')
	while true do
		Citizen.Wait(1000)
		TriggerServerEvent('life:salary')
		TriggerServerEvent('life:starving')
		TriggerServerEvent('life:save_money')
	end
end)

RegisterNetEvent('starvingClient')
AddEventHandler('starvingClient', function(hunger, thirst)
	SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) - 1)
end)

