-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --

-- Constructor
Player = {}
Player.__index = Player

-- Meta table for users
setmetatable(Player, {
	__call = function(self, source, permission_level, money, identifier, group, ped)
		local pl = {}

		pl.source = source
		pl.permission_level = permission_level
		pl.money = money
		pl.identifier = identifier
		pl.group = group
		pl.coords = {x = 0.0, y = 0.0, z = 0.0}
		pl.session = {}
		pl.hunger = 100
		pl.thirst = 100
		pl.ped = ped

		return setmetatable(pl, Player)
	end
})

-- Getting permissions
function Player:getPermissions()
	return self.permission_level
end

-- Setting them
function Player:setPermissions(p)
	TriggerEvent("es:setPlayerData", self.source, "permission_level", p, function(response, success)
		self.permission_level = p
	end)
end

-- No need to ever call this (No, it doesn't teleport the player)
function Player:setCoords(x, y, z)
	self.coords.x, self.coords.y, self.coords.z = x, y, z
end

function Player:getCoords()
	return {x = self.coords.x, y = self.coords.y, z = self.coords.z}
end

-- Kicks a player with specified reason
function Player:kick(reason)
	DropPlayer(self.source, reason)
end

-- Add the value corresponding to the object which was eat or drink by the player
function Player:regenerate(what)
	if (what.thirst.activate == true) then
		self.thirst = self.thirst + what.thirst.value
	end
	if (what.hunger.activate == true) then
		self.hunger = self.hunger + what.hunger.value
	end
end

--  That function is called with an interval and remove thirst and hunger
function Player:spendingEnergy()
    if (self.thirst == 0 or self.hunger == 0) then
    	return ;
    end
	self.thirst = self.thirst - 2
	self.hunger = self.hunger - 1
end

-- Reset hunger and thirst of the player (when he spawn)
function Player:resetStarve()
	self.hunger = 100
	self.thirst = 100
end

-- Begin to remove life to the player because hunger or thirst is == 0
function Player:starving()
	if (self.hunger == 0 or self.thirst == 0) then
    	TriggerClientEvent('starvingClient', self.source)
	end
end

-- Sets the player money (required to call this from now)
function Player:setMoney(m)
	local prevMoney = self.money
	local newMoney : double = m

	self.money = m

	if((prevMoney - newMoney) < 0)then
		TriggerClientEvent("es:addedMoney", self.source, math.abs(prevMoney - newMoney))
	else
		TriggerClientEvent("es:removedMoney", self.source, math.abs(prevMoney - newMoney))
	end

	TriggerClientEvent('es:activateMoney', self.source , self.money)
end

-- Adds to player money (required to call this from now)
function Player:addMoney(m)
	local newMoney : double = self.money + m

	self.money = newMoney

	TriggerClientEvent("es:addedMoney", self.source, m)
	TriggerClientEvent('es:activateMoney', self.source , self.money)
end

-- Removes from player money (required to call this from now)
function Player:removeMoney(m)
	local newMoney : double = self.money - m

	self.money = newMoney

	TriggerClientEvent("es:removedMoney", self.source, m)
	TriggerClientEvent('es:activateMoney', self.source , self.money)
end

-- Player session variables
function Player:setSessionVar(key, value)
	self.session[key] = value
end

function Player:getSessionVar(key)
	return self.session[key]
end