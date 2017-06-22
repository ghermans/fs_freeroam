RegisterServerEvent('CheckMoneyForVeh')
AddEventHandler('CheckMoneyForVeh', function(vehicle, price)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (tonumber(user.money) >= tonumber(price)) then
      local player = user.identifier)
      user:removeMoney((price))
      db.updateUser(player, {personalvehicle = vehicle}, function()
        TriggerClientEvent('FinishMoneyCheckForVeh', source, true)
      end)
    else
      TriggerClientEvent('FinishMoneyCheckForVeh', source, false)
    end
  end)
end)