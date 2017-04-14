require "resources/essentialmode/lib/MySQL"

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