function isDead()
    local playerPed = GetPlayerPed(-1)
	if IsEntityDead(playerPed) then
		TriggerEvent('rp:death', playerPed)
	end
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(50)
        isDead();
	end
end)