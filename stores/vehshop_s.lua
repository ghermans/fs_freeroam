local users = {}
AddEventHandler('es:playerLoaded', function(source, user)
  db.getUser(user.identifier, function(freeroamuser)
    users[source] = freeroamuser
  end)
end)

RegisterServerEvent('CheckMoneyForVeh')
AddEventHandler('CheckMoneyForVeh', function(vehicle, price)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (tonumber(user.money) >= tonumber(price)) then
      local player = user.identifier
      print(player)
      user:removeMoney((price))
      db.updateUser(player, {personalvehicle = vehicle}, function()
        TriggerClientEvent('FinishMoneyCheckForVeh', source, true)
      end)
    else
      TriggerClientEvent('FinishMoneyCheckForVeh', source, false)
    end
  end)
end)

TriggerEvent('es:addCommand', 'pv', function(source, user)
  local vehicle = users[source].personalvehicle
  TriggerClientEvent('vehshop:spawnVehicle', source, vehicle)
end)

local created = {}
AddEventHandler('es:newPlayerLoaded', function(source, user)
  local identifier = user.identifier
  if created[source] == nil then
    print('test creating acc ' .. tostring(created[source]))
    db.createDocument(database['name'], {identifier = identifier, personalvehicle = ""}, function()end)
  end
  created[source] = true
end)
