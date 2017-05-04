fuel = 1.50 -- Fuel Cost, this could be made to randomise between 1.05 and 1.30 or something like that

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

RegisterServerEvent('frfuel:fuelAdded')
AddEventHandler('frfuel:fuelAdded', function(amount)

    for k,v in ipairs(GetPlayers())do
        TriggerEvent("es:getPlayerFromId", k, function(user)
            
            local wallet = user.money
            local cost = fuel * amount
            local new_wallet = wallet - round(cost)

            if(tonumber(user.money) >= round(cost))then

                TriggerEvent("es:setPlayerData", source, "money", new_wallet, function(response, success)
                    TriggerClientEvent('es:activateMoney', source, new_wallet)

                    if(success)then
                        user:removeMoney(round(cost))
                    end
                end)

            else
                -- argent < prix
                TriggerEvent("es:setPlayerData", source, "money", 0, function(response, success)
                    TriggerClientEvent('es:activateMoney', source, 0)

                    if(success)then
                        user:removeMoney(wallet)
                    end
                end)
            end
        end)
    end

end)