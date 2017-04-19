-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "jujumanu78")
        
    RegisterServerEvent('rp:spawn')
    AddEventHandler('rp:spawn', function()
        TriggerEvent('es:getPlayerFromId', source, function(player)

            -- Get Id
            local exeQuery = MySQL:executeQuery("SELECT id FROM users WHERE identifier = '@identifier'", {['@identifier'] = player.identifier})
            local results = MySQL:getResults(exeQuery, {'id'}, "id")

            -- Get Coords by Id
            local executed_query = MySQL:executeQuery("SELECT * FROM pos WHERE id = '@id'", {['@id'] = results.id})
            result = MySQL:getResults(executed_query, {'x', 'y', 'z'}, "id")

            TriggerClientEvent('rp:getSpawnPositions', result)
        end)
    end)