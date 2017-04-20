-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --

-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"

-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open("localhost", "gta5_gamemode_essential", "root", "jujumanu78")

function LoadUser(identifier, source, new, ped)
	local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'id', 'permission_level', 'money', 'identifier', 'group'}, "identifier")

	print(result[1].id)

	-- local queryPos = MySQL:executeQuery("SELECT * FROM pos WHERE user_id = '@user_id'", {['@user_id'] = result[1].id})
    -- local resultPos = MySQL:getResults(queryPos, {'x', 'y', 'z', 'h'}, "id")

	local group = groups[result[1].group]
	Users[source] = Player(source, result[1].permission_level, result[1].money, result[1].identifier, group, result[1].id, {x = 0, y = 0, z = 0})

	TriggerEvent('es:playerLoaded', source, Users[source])

	TriggerClientEvent('rp:teleportPlayerToLastPos', source, {x = 0, y = 0, z = 0})

	if(true)then
		TriggerClientEvent('es:setPlayerDecorator', source, 'rank', Users[source]:getPermissions())
	end

	if(true)then
		TriggerEvent('es:newPlayerLoaded', source, Users[source])
	end
end

function stringsplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end

function isIdentifierBanned(id)
	local executed_query = MySQL:executeQuery("SELECT * FROM bans WHERE banned = '@name'", {['@name'] = id})
	local result = MySQL:getResults(executed_query, {'expires', 'reason', 'timestamp'}, "identifier")

	if(result)then
		for k,v in ipairs(result)do
			if v.expires > v.timestamp then
				return true
			end
		end
	end

	return false
end

AddEventHandler('es:getPlayers', function(cb)
	cb(Users)
end)

function hasAccount(identifier)
	local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'permission_level', 'money'}, "identifier")

	if(result[1] ~= nil) then
		return true
	end
	return false
end


function isLoggedIn(source)
	if(Users[GetPlayerName(source)] ~= nil)then
	if(Users[GetPlayerName(source)]['isLoggedIn'] == 1) then
		return true
	else
		return false
	end
	else
		return false
	end
end

function registerUser(identifier, source, ped)
	if not hasAccount(identifier) then
		-- Inserting Default User Account Stats
		MySQL:executeQuery("INSERT INTO users (`identifier`, `permission_level`, `money`, `group`) VALUES ('@username', '0', '@money', 'user')",
		{['@username'] = identifier, ['@money'] = settings.defaultSettings.startingCash})

		local exeQueryPlayerInfo = MySQL:executeQuery("SELECT id FROM users WHERE identifier = '@identifier'", {['@identifier'] = identifier})
		local resultsPlayerInfo = MySQL:getResults(exeQueryPlayerInfo, {'id'}, "id")

		MySQL:executeQuery("INSERT INTO pos (`user_id`, `x`, `y`, `z`, `h`) VALUES ('@user_id', '0', '0', '0', '0')",
		{['@user_id'] = resultsPlayerInfo[1].id })

		LoadUser(identifier, source, true, ped)
	else
		LoadUser(identifier, source, false, ped)
	end
end

AddEventHandler("es:setPlayerData", function(user, k, v, cb)
	if(Users[user])then
		if(Users[user][k])then

			if(k ~= "money") then
				Users[user][k] = v

				MySQL:executeQuery("UPDATE users SET `@key`='@value' WHERE identifier = '@identifier'",
			    {['@key'] = k, ['@value'] = v, ['@identifier'] = Users[user]['identifier']})
			end

			if(k == "group")then
				Users[user].group = groups[v]
			end

			cb("Player data edited.", true)
		else
			cb("Column does not exist!", false)
		end
	else
		cb("User could not be found!", false)
	end
end)

AddEventHandler("es:setPlayerDataId", function(user, k, v, cb)
	MySQL:executeQuery("UPDATE users SET @key='@value' WHERE identifier = '@identifier'",
	{['@key'] = k, ['@value'] = v, ['@identifier'] = user})

	cb("Player data edited.", true)
end)

AddEventHandler("es:getPlayerFromId", function(user, cb)
	if(Users)then
		if(Users[user])then
			cb(Users[user])
		else
			cb(nil)
		end
	else
		cb(nil)
	end
end)

AddEventHandler("es:getPlayerFromIdentifier", function(identifier, cb)
	local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'permission_level', 'money', 'identifier', 'group'}, "identifier")

	if(result[1])then
		cb(result[1])
	else
		cb(nil)
	end
end)

AddEventHandler("es:getAllPlayers", function(cb)
	local executed_query = MySQL:executeQuery("SELECT * FROM users", {})
	local result = MySQL:getResults(executed_query, {'permission_level', 'money', 'identifier', 'group'}, "identifier")

	if(result)then
		cb(result)
	else
		cb(nil)
	end
end)

-- -- Function to update player money every 60 seconds.
-- local function savePlayerMoney()
-- 	SetTimeout(300000, function()
-- 		TriggerEvent("es:getPlayers", function(users)
-- 			for k,v in pairs(users)do
-- 				v.money = v.money + 50
-- 				MySQL:executeQuery("UPDATE users SET `money`='@value' WHERE identifier = '@identifier'",
-- 			    {['@value'] = v.money, ['@identifier'] = v.identifier})
-- 			end
-- 		end)

-- 		savePlayerMoney()
-- 	end)
-- end

-- savePlayerMoney()