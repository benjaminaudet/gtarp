-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT BEN AND NUJUT! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT BEN AND NUJUT! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT BEN AND NUJUT! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT BEN AND NUJUT! --

-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"

-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open("localhost", "gta5_gamemode_essential", "root", "jujumanu78")

RegisterServerEvent('rp:death')
AddEventHandler("rp:death", function(playerPed)
		MySQL:executeQuery("UPDATE users SET `money`='@value' WHERE ped = '@ped'",
	    {['@value'] = v.money - 1000, ['@ped'] = playerPed})
end)