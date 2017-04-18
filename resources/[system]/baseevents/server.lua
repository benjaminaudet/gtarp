RegisterServerEvent('baseevents:onPlayerDied')
RegisterServerEvent('baseevents:onPlayerKilled')
RegisterServerEvent('baseevents:onPlayerWasted')
RegisterServerEvent('baseevents:enteringVehicle')
RegisterServerEvent('baseevents:enteringAborted')
RegisterServerEvent('baseevents:enteredVehicle')
RegisterServerEvent('baseevents:leftVehicle')

-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"

-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open("localhost", "gta5_gamemode_essential", "root", "caca")

RegisterServerEvent('baseevents:onPlayerKilled')
AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data)
	local victim = source

	RconLog({msgType = 'playerKilled', victim = victim, attacker = killedBy, data = data})

	TriggerEvent('es:getPlayerFromId', source, function(player)

		player:removeMoney(1000)

	end)

	-- local executed_query = MySQL:executeQuery("SELECT money FROM users WHERE identifier = '@identifier'", 
	-- {['@identifier'] = GetPlayerIdentifiers(source)[1]})
	-- local results = MySQL:getResults(executed_query, {'money'}, "identifier")

	-- MySQL:executeQuery("UPDATE users SET `money`='@value' WHERE identifier = '@identifier'",
	--     {['@value'] = results[1].money - 1000, ['@identifier'] = GetPlayerIdentifiers(source)[1]})

end)

RegisterServerEvent('baseevents:onPlayerDied')
AddEventHandler('baseevents:onPlayerDied', function(killedBy, pos)
	local victim = source

	RconLog({msgType = 'playerDied', victim = victim, attackerType = killedBy, pos = pos})

	TriggerEvent('es:getPlayerFromId', source, function(player)

		player:removeMoney(1000)

	end)

	-- local executed_query = MySQL:executeQuery("SELECT money FROM users WHERE identifier = '@identifier'", 
	-- {['@identifier'] = GetPlayerIdentifiers(source)[1]})
	-- local results = MySQL:getResults(executed_query, {'money'}, "identifier")

	-- MySQL:executeQuery("UPDATE users SET `money`='@value' WHERE identifier = '@identifier'",
	--     {['@value'] = results[1].money - 1000, ['@identifier'] = GetPlayerIdentifiers(source)[1]})


end)