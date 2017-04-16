Citizen.CreateThread(function ()
	while true do
		TriggerServerEvent('life:save_money')
		Citizen.Wait(30000)
		TriggerServerEvent('life:salary')
	end
end)
