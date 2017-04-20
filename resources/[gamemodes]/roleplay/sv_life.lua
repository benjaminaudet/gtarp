-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "jujumanu78")

RegisterServerEvent('rp:savepos')
AddEventHandler('rp:savepos', function(pos)

  new_pos = pos
  TriggerEvent('es:getPlayerFromId', source, function(player)

    local playerIdentifier = player.identifier
    print('Save Position: '..playerIdentifier)


      -- Save this shit to the database
      MySQL:executeQuery("UPDATE pos SET x ='@x', y = '@y' , z = '@z' WHERE user_id = '@user_id'",
      {['@user_id'] = playerIdentifier, ['@x'] = new_pos.x, ['@y'] = new_pos.y, ['@z'] = new_pos.z})

      player:setCoords(new_pos.x, new_pos.y, new_pos.z)
      local coords = player:getCoords()

      print("x: " .. coords.x .. ", y: " .. coords.y .. ", z: " ..coords.z)

      -- Trigger some client stuff
      -- TriggerClientEvent("es_freeroam:notify", source, "CHAR_DEFAULT", 1, ""..playerId, false, "Position sauvegardé!\n")
  end)
end)

TriggerEvent('es:addCommand', 'weapons', function(source, args, user)

  TriggerClientEvent('giveAllWeapons', source)

end)

RegisterServerEvent('rp:resetStarve')
AddEventHandler('rp:resetStarve', function()
  TriggerEvent('es:getPlayerFromId', source, function(player)

    player:resetStarve()

  end)
end)

RegisterServerEvent('rp:starving')
AddEventHandler('rp:starving', function()
  TriggerEvent('es:getPlayerFromId', source, function(player)

    player:spendingEnergy()
    player:starving()

    TriggerClientEvent('isStarve', source, player.hunger, player.thirst)

  end)
end)

RegisterServerEvent('rp:save_money')
AddEventHandler('rp:save_money', function()
  TriggerEvent('es:getPlayerFromId', source, function(player)

    local id = player.identifier
    print('Save Money: '..player.money)

      -- Save this shit to the database
      MySQL:executeQuery("UPDATE users SET money='@money' WHERE identifier = '@identifier'",
      {['@identifier'] = id, ['@money'] = player.money})
      
      TriggerClientEvent('es:activateMoney', source , player.money)

      -- Trigger some client stuff
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Sauvegarde de l'argent!")
  end)
end)

RegisterServerEvent('rp:salary')
AddEventHandler('rp:salary', function()
  	print("Player ID " ..source)
  	local salary = 50
	-- Get the players money amount
	TriggerEvent('es:getPlayerFromId', source, function(player)

  	-- update player money amount
  	player:addMoney((salary + 0.0))
 	TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Salaire de base de ".. salary .." ~g~$ de reparation")
 	end)
end)
