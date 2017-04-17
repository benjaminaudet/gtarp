-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "caca")

RegisterServerEvent('life:savepos')
AddEventHandler('life:savepos', function(pos)
  TriggerEvent('es:getPlayerFromId', source, function(player)

    local player = player.identifier
    print('Save Position: '..player)

      -- Save this shit to the database
      MySQL:executeQuery("UPDATE users SET lastpos='@pos' WHERE identifier = '@identifier'",
      {['@identifier'] = player, ['@pos'] = pos})

      -- Trigger some client stuff
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_DEFAULT", 1, ""..player, false, "Position sauvegardé!\n")
  end)
end)

RegisterServerEvent('life:resetStarve')
AddEventHandler('life:resetStarve', function()
  TriggerEvent('es:getPlayerFromId', source, function(player)

    player:resetStarve()

  end)
end)

RegisterServerEvent('life:starving')
AddEventHandler('life:starving', function()
  TriggerEvent('es:getPlayerFromId', source, function(player)

    player:spendingEnergy()
    player:starving()

    print("hunger: "..player.hunger)
    print("thirst: "..player.thirst)

    TriggerClientEvent('isStarve', source, player.hunger, player.thirst)

  end)
end)

RegisterServerEvent('life:save_money')
AddEventHandler('life:save_money', function()
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

RegisterServerEvent('life:salary')
AddEventHandler('life:salary', function()
  	print("Player ID " ..source)
  	local salary = 50
	-- Get the players money amount
	TriggerEvent('es:getPlayerFromId', source, function(player)

  	-- update player money amount
  	player:addMoney((salary + 0.0))
 	TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Salaire de base de ".. salary .." ~g~$ de reparation")
 	end)
end)
