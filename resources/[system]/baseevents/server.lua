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
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "jujumanu78")

RegisterServerEvent('baseevents:onPlayerKilled')
AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data)
	local victim = source

	RconLog({msgType = 'playerKilled', victim = victim, attacker = killedBy, data = data})
	print(GetPlayerIdentifiers(source)[1] .. "died")
	local executed_query = MySQL:executeQuery("SELECT money FROM users WHERE identifier = '@identifier'", 
	{['@identifier'] = GetPlayerIdentifiers(source)[1]})
	local results.money = MySQL:getResults(executed_query, {'money'}, "identifier")
	print (results.money) 

	MySQL:executeQuery("UPDATE users SET `money`='@value' WHERE identifier = '@identifier'",
	    {['@value'] = results.money - 1000, ['@identifier'] = GetPlayerIdentifiers(source)[1]})

	print("request was launched")
end)

RegisterServerEvent('baseevents:onPlayerDied')
AddEventHandler('baseevents:onPlayerDied', function(killedBy, pos)
	local victim = source

	RconLog({msgType = 'playerDied', victim = victim, attackerType = killedBy, pos = pos})

	print(GetPlayerIdentifiers(source)[1] .. "died")
	local executed_query = MySQL:executeQuery("SELECT money FROM users WHERE identifier = '@identifier'", 
	{['@identifier'] = GetPlayerIdentifiers(source)[1]})
	local results.money = MySQL:getResults(executed_query, {'money'}, "identifier")
	print (results.money) 

	MySQL:executeQuery("UPDATE users SET `money`='@value' WHERE identifier = '@identifier'",
	    {['@value'] = results.money - 1000, ['@identifier'] = GetPlayerIdentifiers(source)[1]})

	print("request was launched")

end)