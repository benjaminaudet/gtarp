Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(360000)
		TriggerServerEvent('life:salary')
		TriggerServerEvent('life:savepos')
	end
end)
