i18nMenu.setup(Setup.lang)

-- Spawn override
AddEventHandler('onClientMapStart', function()
	i18nMenu.setup(Setup.lang)
    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
end)

AddEventHandler("playerSpawned", function(spawn)
	Citizen.CreateThread(function()
		Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', Setup.friendlyResourceName)
		SetAudioFlag("LoadMPData", true)
		SetAudioFlag("WantedMusicDisabled", Setup.WantedMusicDisabled)

		SetNotificationTextEntry("STRING");
    AddTextComponentString(Translator.translate("client_notification_part_1").. GetPlayerName() ..Translator.translate("client_notification_part_2"));
    SetNotificationMessage("CHAR_LESTER", "CHAR_LESTER", true, 4, "Essential Freeroam", "v0.1.5");
    DrawNotification(false, true)

		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNIFE"), true, true)
	end)
end)

RegisterNetEvent("fs_freeroam:clearWanted")
AddEventHandler("fs_freeroam:clearWanted", function(status)
	if status == true then
		SetPlayerWantedLevel(PlayerId(), 0, 0)
		SetPlayerWantedLevelNow(PlayerId(), 0)
		TriggerEvent("fs_freeroam:notify", "CHAR_CALL911", 9, "Dirty Cops", false, Translator.translate("playerCommands_rmWantedSuccess"))
	else
		TriggerEvent("fs_freeroam:notify", "CHAR_CALL911", 4, "Dirty Cops", false, Translator.translate("playerCommands_rmWantedMoreMoney"))
	end
end)

-- Display text
RegisterNetEvent("fs_freeroam:displaytext")
AddEventHandler("fs_freeroam:displaytext", function(text, time)
  ClearPrints()
  SetTextEntry_2("STRING")
  AddTextComponentString(text)
  DrawSubtitleTimed(time, 1)
end)

-- Display notification
RegisterNetEvent("fs_freeroam:notify")
AddEventHandler("fs_freeroam:notify", function(icon, type, sender, title, text)
  Citizen.CreateThread(function()
    Wait(1)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(text);
    SetNotificationMessage(icon, icon, true, type, sender, title, text);
    DrawNotification(false, true);
    Citizen.Wait(60000)
  end)
end)

RegisterNetEvent('i18n:getLocales', function(source)
  TriggerEvent("i18n:iSupport",source,GetCurrentResourceName(),avalLangs)
end)
