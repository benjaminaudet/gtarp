require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "jujumanu78")

RegisterServerEvent('savePos')
AddEventHandler('savePos', function(x, y, z)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
      MySQL:executeQuery("UPDATE users SET x='@x', y='@y', z='@z' WHERE identifier = '@username'", {['@username'] = player, ['@x'] = x, ['@y'] = y, ['@z'] = z})
  end)
end)

RegisterServerEvent('spawn')
-- Configuré pour être utilisé avec "freeroam"
AddEventHandler('spawn', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
	local player = user.identifier
	local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = player})
	local result = MySQL:getResults(executed_query, {'x', 'y', 'z'}, "identifier")
	if(result) then
		for k,v in ipairs(result) do
		  if tonumber(v.z) < 1.3 or tonumber(v.x) <= -5000 then -- Si hors map
		    local model = "mp_m_freemode_01"
		    TriggerClientEvent('es_freeroam:spawnPlayer', source, 464.091, -997.166, 24.915) -- Position d'un poste de police en cas de problème de spawn (à améliorer)
		  else
		    local model = "mp_m_freemode_01"
		    TriggerClientEvent('es_freeroam:spawnPlayer', source, tonumber(v.x), tonumber(v.y), tonumber(v.z))
		  end
		end
	end
  end)
end)

RegisterServerEvent('spawnHospital')
AddEventHandler('spawnHospital', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local model = "mp_m_freemode_01"
    TriggerClientEvent('es_freeroam:spawnPlayer', source, 357.43, -593.36, 28.79) -- Position d'un hopital en cas de mort
  end)
end)