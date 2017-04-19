-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "jujumanu78")
        
    RegisterServerEvent('rp:spawn')
    AddEventHandler('rp:spawn', function(pos)
    local executed_query = MySQL:executeQuery("SELECT position FROM users WHERE identifier = '@id'", {['@id'] = PlayerId()})
    local result = MySQL:getResults(executed_query, {'position'}, "identifier")

    local new_positions = JSON.decode(result)
    spawn = {
    	x = 0;
    	y = 0;
    	z = 0;
	}
    if new_positions ~= nil then
        spawn.x = new_positions.x
        spawn.y = new_positions.y
        spawn.z = new_positions.z
    end