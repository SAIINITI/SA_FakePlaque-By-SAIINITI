ESX = nil


print("SAIINITI#8638")


TriggerEvent(Config.Events["esx:getSharedObject"], function(obj) ESX = obj end)

ESX.RegisterServerCallback("SAfakeplate:changePlate", function(source, cb) 
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()

	local numberLetter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local newPlate = ""
    for i = 1, 8 do
        local randomIndex = math.random(#numberLetter)
        local plate = numberLetter:sub(randomIndex,randomIndex)
        newPlate = newPlate .. plate
    end

	if xMoney >= Config.PriceChangePlate then

        xPlayer.removeMoney(Config.PriceChangePlate)
		
        TriggerClientEvent(Config.Events["esx:showNotification"], source, "~g~-" .. Config.PriceChangePlate .."$~w~")
		TriggerClientEvent(Config.Events["esx:showNotification"], source, "La nouvelle plaque d'immatriculation a bien était installé : ~r~" .. newPlate)
		cb(newPlate)

    else
         TriggerClientEvent(Config.Events["esx:showNotification"], source, "Vous n'avez assez ~g~d\'argent ")
    end
end)

ESX.RegisterServerCallback("SAfakeplate:deletePlate", function(source, cb) 
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()


	local newPlate = "        "

    if xMoney >= Config.PriceDeletePlate then

        xPlayer.removeMoney(Config.PriceDeletePlate)

        TriggerClientEvent(Config.Events["esx:showNotification"], source, "~g~-" .. Config.PriceDeletePlate .."$~w~")
		TriggerClientEvent(Config.Events["esx:showNotification"], source, "La plaque d'immatriculation a été retirée")
		cb(newPlate)

    else
         TriggerClientEvent(Config.Events["esx:showNotification"], source, "Vous n'avez assez ~g~d\'argent ")
    end

end)