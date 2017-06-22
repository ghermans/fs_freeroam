TriggerEvent("es:setDefaultSettings", {
	pvpEnabled = Setup.pvp,
	debugInformation = false,
	startingCash = Setup.Money + 0.0,
	enableRankDecorators = true,
	moneyIcon = Setup.Currency
})

RegisterServerEvent('playerSpawn')
AddEventHandler('playerSpawn', function()
	TriggerClientEvent('fs_freeroam:spawnPlayer', source, spawnCoords.x, spawnCoords.y, spawnCoords.z)
end)

AddEventHandler('es:playerLoaded', function(source)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		user:setMoney((user.money))
	end)
end)

RegisterServerEvent('mission:completed')
AddEventHandler('mission:completed', function(total)
TriggerEvent('es:getPlayerFromId', source, function(user)
  user:addMoney((total))
 TriggerClientEvent("fs_freeroam:notify", source, "CHAR_BANK_MAZE", 9, "Maze Bank", false, "You received ~g~$".. tonumber(total))
 end)
end)

RegisterServerEvent('fs_freeroam:buy')
AddEventHandler('fs_freeroam:buy', function(amount, action)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		if(user.money > amount) then
			TriggerClientEvent("fs_freeroam:notify", source, "CHAR_BANK_MAZE", 9, "Maze Bank", false, "Your payment has been ~g~accepted.\n")
			user:removeMoney((amount))
			TriggerClientEvent(action, source)
		else
			TriggerClientEvent("fs_freeroam:notify", source, "CHAR_BANK_MAZE", 9, "Maze Bank", false, "You need more cash before you can buy this\n")
		end
	end)
end)

RegisterServerEvent('fivem-stores:weapon-menu:item-selected')
AddEventHandler('fivem-stores:weapon-menu:item-selected', function(s)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if(tonumber(user.money) >= tonumber(s.Price)) then
      local player = user.identifier
      user:removeMoney((tostring(s.Price)))

      TriggerClientEvent('fivem-stores:giveWeapon', source, s.Name)
      TriggerClientEvent("fs_freeroam:notify", source, "CHAR_AMMUNATION", 4, "Ammunation", false, "Thank you for purchasing: ~g~\n" ..s.FriendlyName)
    else
      TriggerClientEvent("fs_freeroam:notify", source, "CHAR_AMMUNATION", 4, "Ammunation", false, "~y~ Sorry but you need more cash")
    end
  end)
end)
