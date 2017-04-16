Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(60000)
		TriggerServerEvent('life:salary')
		local pos = GetEntityCoords(GetPlayerPed(-1))
		TriggerServerEvent('life:savepos', pos)
		TriggerServerEvent('life:savemoney')
	end
end)
