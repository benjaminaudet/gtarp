-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "jujumanu78")
        
    RegisterServerEvent('rp:spawn')
    AddEventHandler('rp:spawn', function()
        TriggerEvent('es:getPlayerFromId', source, function(player)

            -- Get Id
            local exeQueryPlayerInfo = MySQL:executeQuery("SELECT id FROM users WHERE identifier = '@identifier'", {['@identifier'] = player.identifier})
            local resultsPlayerInfo = MySQL:getResults(exeQueryPlayerInfo, {'id'}, "id")

            -- Get Coords by Id
            local executed_query = MySQL:executeQuery("SELECT * FROM pos WHERE id = '@id'", {['@id'] = resultsPlayerInfo.id})
            result = MySQL:getResults(executed_query, {'x', 'y', 'z'}, "id")

            print ('Get Position OK')
            TriggerClientEvent('rp:getSpawnPositions', result)
        end)
    end)