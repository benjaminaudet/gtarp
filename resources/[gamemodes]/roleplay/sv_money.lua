-- Function to update player money every 60 seconds.
local function savePlayerMoney()
	SetTimeout(6000, function()
		TriggerEvent("es:getPlayers", function(users)
			for k,v in pairs(users)do
				MySQL:executeQuery("UPDATE users SET `money`='@value' WHERE identifier = '@identifier'",
			    {['@value'] = v.money , ['@identifier'] = v.identifier})
			end
		end)

		savePlayerMoney()
	end)
end

savePlayerMoney()