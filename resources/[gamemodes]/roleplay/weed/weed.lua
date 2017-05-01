----------------------------------------------------
--===================Aurelien=====================--
----------------------------------------------------
------------------------Lua-------------------------
-- SORRY FOR BAD ENGLISH, Baguette :') 

local DrawMarkerShow = False
local DrawBlipTradeShow = False

-- -900.0, -3002.0, 13.0
-- -800.0, -3002.0, 13.0
-- -1078.0, -3002.0, 13.0

local Price = 55 -- PRICE FOR EACH CANNABIS TREATY

local Position = {
    Recolet={x=2221.34,y=5577.2,z=53.82, distance=5, bli}, -- POSITION OF RECOLT
    traitement={x=-180.189,y=6400.62,z=31.4904, distance=15, bli}, -- POSITION OF TREATMENT
    vente0={x=86.2145,y=-1954.44,z=20.7889, distance=5, bli}, -- POSITION OF SELL



}

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y)
end

function ShowInfo(text, state)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

local ShowMsgtime = {msg="",time=0}

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if ShowMsgtime.time ~= 0 then
        drawTxt(ShowMsgtime.msg, 0,1,0.5,0.8,0.6,255,255,255,255)
        ShowMsgtime.time = ShowMsgtime.time - 1
      end
    end
end)

Citizen.CreateThread(function()

    if DrawBlipTradeShow then
        SetBlipTrade(140, "~g~ Recuperation de ~b~Cannabis", 1, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z)  -- POSITION OF MARKERS ON MAP
        SetBlipTrade(140, "~g~ Traitement de ~b~Cannabis", 1, Position.traitement.x, Position.traitement.y, Position.traitement.z)  -- POSITION OF MARKERS ON MAP
 	SetBlipTrade(140, "~g~ Vente de ~b~Cannabis", 1, Position.vente0.x, Position.vente0.y, Position.vente0.z)  -- POSITION OF MARKERS ON MAP

    end

    while true do
       Citizen.Wait(0)
       if DrawMarkerShow then
          DrawMarker(0, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
          DrawMarker(0, Position.traitement.x, Position.traitement.y, Position.traitement.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	  DrawMarker(0, Position.vente0.x, Position.vente0.y, Position.vente0.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)



       end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPos = GetEntityCoords(GetPlayerPed(-1))

        local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, true)
        if distanceWeedFarm < Position.Recolet.distance then
           ShowInfo('~b~Appuyez sur ~INPUT_CONTEXT~ pour recolter', 0) -- MESSAGE TO RECOLT WHEN YOU PRESS [E]
           if IsControlJustPressed(1,38) then -- SEE IF [E] IS PRESSED
                local weedcount = 0
                TriggerEvent("player:getQuantity", 1, function(data) -- GET QUANTITY ON INVENTORY
                    weedcount = data.count
                end)
                Citizen.Wait(1)
                if weedcount < 30 then -- IF IN INVENTORY [<30 CANNABIS]
                        ShowMsgtime.msg = '~g~ Recolte en cours.' -- YOU CAN RECOLT
                        ShowMsgtime.time = 800
                        Wait(8500)
                        ShowMsgtime.msg = '~g~ + 1 ~b~Cannabis' -- RECOLT MESSAGE
                        ShowMsgtime.time = 150
						-- ("player:receiveItem", 1, 1) = ADD ITEM , ID1 ( CANNABIS ), AND "+1"
                        TriggerEvent("player:receiveItem", 1, 1) -- [+ CANNABIS] ( ALSO ADD NEW LINE [CANNABIS] IN INVENTORY )
                else
                        ShowMsgtime.msg = '~r~ Inventaire complet !' -- IF [30 CANNABIS] SAY INVENTORY FULL
                        ShowMsgtime.time = 150
                end
           end
        end

        local distanceWeedTreat = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement.x, Position.traitement.y, Position.traitement.z, true)
        if distanceWeedTreat < Position.traitement.distance then
           ShowInfo('~b~Appuyez sur ~INPUT_CONTEXT~ pour traiter votre ~b~Cannabis', 0) -- MESSAGE TO TREATY WHEN YOU PRESS [E]
           if IsControlJustPressed(1,38) then -- SEE IF [E] IS PRESSED
                local weedcount = 0
                TriggerEvent("player:getQuantity", 1, function(data) -- GET QUANTITY ON INVENTORY
                     weedcount = data.count
                end)
                if weedcount ~= 0 then  -- IF IN INVENTORY [0> CANNABIS]
                        ShowMsgtime.msg = '~g~ Traitement en cours.' -- YOU CAN TREATY
                        ShowMsgtime.time = 800
                        Wait(8500)
                        ShowMsgtime.msg = '~g~ + 1 ~b~Cannabis Traite' -- TREATMENT MESSAGE
                        ShowMsgtime.time = 150
						-- ("player:looseItem", 1, 1) = REMOVE ITEM , ID1 ( CANNABIS ), AND "-1"
                        TriggerEvent("player:looseItem", 1, 1) -- [-1 CANNNABIS]
						-- ("player:receiveItem", 3, 1) = ADD ITEM , ID3 ( CANNABIS ROLLING ), AND "+1"
                        TriggerEvent("player:receiveItem", 3, 1) -- [+1 CANNABIS ROLLING]
                else
                        ShowMsgtime.msg = '~r~ Vous n avez pas de Cannabis !' -- MESSAGE FOR 0 CANNABIS IN INVENTORY
                        ShowMsgtime.time = 150
                end
           end
        end

        local distanceWeedDealer = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente0.x, Position.vente0.y, Position.vente0.z, true)

        if distanceWeedDealer < Position.vente0.distance then
           ShowInfo('~b~ Appuyez sur ~INPUT_CONTEXT~ pour vendre votre Cannabis', 0) -- MESSAGE TO SELL WHEN YOU PRESS [E]
           if IsControlJustPressed(1,38) then -- SEE IF [E] PESSED
                local weedcount = 0
                TriggerEvent("player:getQuantity", 3, function(data)
                        weedcount = data.count
                end)
                if weedcount ~= 0 then -- IF IN INVENTORY [0> CANNABIS ROLLING]
                        ShowMsgtime.msg = '~g~ Vente en cours.' -- YOU CAN SELL
                        ShowMsgtime.time = 150
                        Wait(2500)
                        ShowMsgtime.msg = '~g~ +'.. Price ..'$' -- GIVE MONEY TO PLAYER [ SET ON LINE : 13 ]
                        ShowMsgtime.time = 150
						-- ("player:sellItem", 3, 1) = SELL ITEM , ID3 ( CANNABIS ROLLING ), AND "-1" + GIVE THE MONEY
                        TriggerEvent("player:sellItem", 3, Price) -- REMOVE 1 CANNABIS ROLLING AND GIVE MONEY
                else
                        ShowMsgtime.msg = '~r~ Vous n avez pas de Cannabis Traite !' -- MESSAGE FOR 0 CANNABIS ROLLING IN INVENTORY
                        ShowMsgtime.time = 150
                end
           end
        end

    end
end)

function SetBlipTrade(id, text, color, x, y, z)
    local Blip = AddBlipForCoord(x, y, z)

    SetBlipSprite(Blip, id)
    SetBlipColour(Blip, color)
        
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(Blip)
end