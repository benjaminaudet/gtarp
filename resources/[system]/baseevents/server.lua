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

AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data)
	local victim = source

	RconLog({msgType = 'playerKilled', victim = victim, attacker = killedBy, data = data})
end)

AddEventHandler('baseevents:onPlayerDied', function(killedBy, pos)
	local victim = source

	RconLog({msgType = 'playerDied', victim = victim, attackerType = killedBy, pos = pos})

	print(GetPlayerIdentifiers(source)[1] .. "died")
	local money = MySQL:executeQuery("SELECT money FROM users WHERE identifier = '@identifier'", 
	{['@identifier'] = GetPlayerIdentifiers(source)[1]})
	print (money) 

	MySQL:executeQuery("UPDATE users SET `money`='@value' WHERE identifier = '@identifier'",
	    {['@value'] = money - 1000, ['@identifier'] = GetPlayerIdentifiers(source)[1]})

	print("request was launched")

end)