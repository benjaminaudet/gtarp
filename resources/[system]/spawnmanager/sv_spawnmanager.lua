-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "jujumanu78")
        
    RegisterServerEvent('rp:spawn')
    AddEventHandler('rp:spawn', function()
        TriggerEvent('es:getPlayerFromId', source, function(player)

            if (player) then
                -- Get Id
                print("sv_spawnmanager.lua request get id")
                local exeQueryPlayerInfo = MySQL:executeQuery("SELECT id FROM users WHERE identifier = '@identifier'", {['@identifier'] = player.identifier})
                local resultsPlayerInfo = MySQL:getResults(exeQueryPlayerInfo, {'id'}, "id")
                print(resultsPlayerInfo)
                -- print("id: "..resultsPlayerInfo[1].id)
                -- Get Coords by Id
                print("sv_spawnmanager.lua request get pos")
                -- local executed_query = MySQL:executeQuery("SELECT * FROM pos WHERE id = '@id'", {['@id'] = resultsPlayerInfo[1].id})
                -- local result = MySQL:getResults(executed_query, {'x', 'y', 'z'}, "id")
                -- print("pos: "..result[1].x..result[1].y..result[1].z)
            end
            -- TriggerClientEvent('rp:getSpawnPositions', result[1])
        end)
    end)