Citizen.CreateThread(function ()
	Citizen.Wait(1000)
	TriggerServerEvent('rp:save_money')
	TriggerServerEvent('rp:starving')
	while true do
		Citizen.Wait(60000)
		TriggerServerEvent('rp:salary')
		TriggerServerEvent('rp:starving')
		TriggerServerEvent('rp:savepos', GetSelfPlayerPosition())
		TriggerServerEvent('rp:save_money')
	end
end)

RegisterNetEvent('starvingClient')
AddEventHandler('starvingClient', function(hunger, thirst)
	SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) - 3)
end)

RegisterNetEvent('rp:teleportPlayerToLastPos')
AddEventHandler('rp:teleportPlayerToLastPos', function(pos)
	Citizen.Trace('Teleported')
	SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z, 0, 0, 0, true)
end)

RegisterNetEvent('giveAllWeapons')
AddEventHandler('giveAllWeapons', function(source)
	GiveSelfAllWeapons()
end)

function GiveSelfAllWeapons()
	weaponNames = {
		"WEAPON_KNIFE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", "WEAPON_BAT", "WEAPON_GOLFCLUB",
		"WEAPON_CROWBAR", "WEAPON_PISTOL", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50",
		"WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_ASSAULTSMG", "WEAPON_ASSAULTRIFLE",
		"WEAPON_CARBINERIFLE", "WEAPON_ADVANCEDRIFLE", "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_PUMPSHOTGUN",
		"WEAPON_SAWNOFFSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_BULLPUPSHOTGUN", "WEAPON_STUNGUN", "WEAPON_SNIPERRIFLE",
		"WEAPON_HEAVYSNIPER", "WEAPON_GRENADELAUNCHER", "WEAPON_GRENADELAUNCHER_SMOKE", "WEAPON_RPG", "WEAPON_MINIGUN",
		"WEAPON_GRENADE", "WEAPON_STICKYBOMB", "WEAPON_SMOKEGRENADE", "WEAPON_BZGAS", "WEAPON_MOLOTOV",
		"WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN", "WEAPON_FLARE", "WEAPON_SNSPISTOL", "WEAPON_SPECIALCARBINE",
		"WEAPON_HEAVYPISTOL", "WEAPON_BULLPUPRIFLE", "WEAPON_HOMINGLAUNCHER", "WEAPON_PROXMINE", "WEAPON_SNOWBALL",
		"WEAPON_VINTAGEPISTOL", "WEAPON_DAGGER", "WEAPON_FIREWORK", "WEAPON_MUSKET", "WEAPON_MARKSMANRIFLE",
		"WEAPON_HEAVYSHOTGUN", "WEAPON_GUSENBERG", "WEAPON_HATCHET", "WEAPON_RAILGUN", "WEAPON_COMBATPDW",
		"WEAPON_KNUCKLE", "WEAPON_MARKSMANPISTOL", "WEAPON_FLASHLIGHT", "WEAPON_MACHETE", "WEAPON_MACHINEPISTOL",
		"WEAPON_SWITCHBLADE", "WEAPON_REVOLVER", "WEAPON_COMPACTRIFLE", "WEAPON_DBSHOTGUN", "WEAPON_FLAREGUN",
		"WEAPON_AUTOSHOTGUN", "WEAPON_BATTLEAXE", "WEAPON_COMPACTLAUNCHER", "WEAPON_MINISMG", "WEAPON_PIPEBOMB",
		"WEAPON_POOLCUE", "WEAPON_SWEEPER", "WEAPON_WRENCH"
		};
	local i = 0
	while i < #weaponNames do
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weaponNames[i]), 1000, false, false)
		i = i + 1
	end

end

function GetPlayerPosition(indicator)

	  -- Get player position
      x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(indicator), true))

      return {x = x, y = y, z = z}
end

function GetSelfPlayerPosition()

	  -- Get player position
      x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

      return {x = x, y = y, z = z}
end