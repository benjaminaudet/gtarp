Citizen.CreateThread(function ()
	Citizen.Wait(1000)
	TriggerServerEvent('life:save_money')
	TriggerServerEvent('life:starving')
	while true do
		Citizen.Wait(60000)
		TriggerServerEvent('life:salary')
		TriggerServerEvent('life:starving')
		TriggerServerEvent('life:savepos', GetSelfPlayerPosition())
		TriggerServerEvent('life:save_money')
	end
end)

RegisterNetEvent('starvingClient')
AddEventHandler('starvingClient', function(hunger, thirst)
	SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) - 1)
end)

function GetPlayerPosition(indicator)

	      -- Get player position
      x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(indicator), true))

      return {x = x, y = y, z = z}
end

function GetSelfPlayerPosition()

	      -- Get player position
      x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

      return {x = x, y = y, z = z}
end