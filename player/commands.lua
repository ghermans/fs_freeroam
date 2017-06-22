--Help Commands
TriggerEvent('es:addCommand', 'help', function(source, args, user)
  TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "Player Commands ")
	TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "-------------------------------------------------------")
	TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "/pv - Get teleported in your personal vehicle")
	TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "/rmwanted - Remove your wanted level")
	TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "-------------------------------------------------------")
	TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "Admin Commands ")
	TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "-------------------------------------------------------")
	TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "/addcash id amount - Add more cash to the players bank account")
	TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "/rmcash id - Reset the players cash amount")
end)

-- Add money to the players account
TriggerEvent('es:addGroupCommand', 'addcash', "mod", function(source, args, user)
  if #args ~= 3 then
    TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "Usage: addcash [user-id] [amount]\n")
    CancelEvent()
    return
  end

  if(GetPlayerName(tonumber(args[2])))then
    local player = tonumber(args[2])
    -- User permission check
    TriggerEvent("es:getPlayerFromId", player, function(target)
      if(tonumber(target.permission_level) > tonumber(user.permission_level))then
        TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "You're not allowed to target this person!")
        return
      end

      -- update player money amount
      total = args[3]
      user:addMoney((total + 0.0))
      TriggerClientEvent('chatMessage', player, "SYSTEM", {187, 235, 42}, "Your money has been set to: $" .. tonumber(args[3]))
    end)
  else
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
  end
end,
function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end)

-- Remove money from the players account
TriggerEvent('es:addGroupCommand', 'rmcash', "mod", function(source, args, user)
  if(GetPlayerName(tonumber(args[2])))then
    local player = tonumber(args[2])
    -- User permission check
    TriggerEvent("es:getPlayerFromId", player, function(target)
      if(tonumber(target.permission_level) > tonumber(user.permission_level))then
        TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "You're not allowed to target this person!")
        return
      end
      -- update player money amount
      user:setMoney((0.0))
      TriggerClientEvent('chatMessage', player, "SYSTEM", {187, 235, 42}, "Your money has been removed")
    end)
  else
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
  end
end,
function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end)

TriggerEvent('es:addCommand', 'rmwanted', function(source)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		if(user.money > 100) then
			user:removeMoney((100))
			TriggerClientEvent('fs_freeroam:clearWanted', source, true)
		else
			TriggerClientEvent('fs_freeroam:clearWanted', source, false)
		end
	end)
end)
