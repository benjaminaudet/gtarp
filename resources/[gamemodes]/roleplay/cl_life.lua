Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(360000)
		TriggerServerEvent('life:salary')
		local pos = GetEntityCoords(GetPlayerPed(-1))
		TriggerServerEvent('life:savepos', pos)
	end
end)
