ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job2)  
	PlayerData.job = job
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
   
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setjob')
AddEventHandler('esx:setjob', function(job2)
  PlayerData.job = job
end)


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.Events["esx:getSharedObject"], function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

function SAfakeplate()
    local SAfakeplate = RageUI.CreateMenu("Menu Plaque")

    RageUI.Visible(SAfakeplate, not RageUI.Visible(SAfakeplate))

    while SAfakeplate do
        
        Citizen.Wait(0)

        RageUI.IsVisible(SAfakeplate, true, true, true, function()
    
            RageUI.Separator("")
            RageUI.Separator("→ ~r~ Plaque d'immatriculation ~s~ ←")
            RageUI.Button("Changer la plaque", nil, {RightLabel = "~g~" .. Config.PriceChangePlate .. "$"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                ChangePlate()
                end
            end)
            RageUI.Button("Supprimer la plaque", nil, {RightLabel = "~g~" .. Config.PriceDeletePlate .. "$"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                DeletePlate()
                end
            end)

        end)

        if not RageUI.Visible(SAfakeplate) then
            SAfakeplate = RMenu:DeleteType("SAfakeplate", true)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local interval = 750
        
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.Position)

        if IsPedInAnyVehicle(PlayerPedId(), false) then
            if dist <= 3.0 and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
                interval = 1
                draw2dText(("Appuyez sur [~m~E~s~] pour faire des modifications avec votre plaque"), { 0.39, 0.95 } )
                
                if IsControlJustPressed(1,51) then
                    SAfakeplate()
                end
        
            end
        end

        Citizen.Wait(interval)
    
    end

end)

function ChangePlate()
    local PlayerPed = PlayerPedId()
    local coords = GetEntityCoords(PlayerPed)
    local vehicle = ESX.Game.GetClosestVehicle(coords)
    local vehiclepos = GetEntityCoords(vehicle)

    ESX.TriggerServerCallback("SAfakeplate:changePlate", function(newPlate)
        SetVehicleNumberPlateText(vehicle, newPlate)
    end)

end

function DeletePlate()
    local PlayerPed = PlayerPedId()
    local coords = GetEntityCoords(PlayerPed)
    local vehicle = ESX.Game.GetClosestVehicle(coords)
    local vehiclepos = GetEntityCoords(vehicle)

    ESX.TriggerServerCallback("SAfakeplate:deletePlate", function(newPlate)
        SetVehicleNumberPlateText(vehicle, newPlate)
    end)

end

function draw2dText(text, pos)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.55, 0.55)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(table.unpack(pos))
end