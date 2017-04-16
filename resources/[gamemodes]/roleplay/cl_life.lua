Citizen.CreateThread(function ()
	Citizen.Wait(1000)
	TriggerServerEvent('life:save_money')
	while true do
	Citizen.Wait(30000)
		TriggerServerEvent('life:salary')
		TriggerServerEvent('life:save_money')
	end
end)
