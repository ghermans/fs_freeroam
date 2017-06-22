local stage = 0
local pickup = nil
local caseTaken = false

Citizen.CreateThread(function()
   storageinit()
   end)

Citizen.CreateThread(function()
    while true do
       Wait(0)
       tick()
     end
   end)

function storageinit()
  bank = AddBlipForCoord(-353.317, -54.1684, 49.0365)
  SetBlipSprite(bank, 304)
  SetBlipAsShortRange(bank, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(Translator.translate("blips_fleeca_bank_mission"))
  EndTextCommandSetBlipName(bank)

  --createBankCops()
  createCasePickup()
  SetPickupRegenerationTime(300000, pickup)
end

function createCasePickup()
  pickup = CreatePickup(GetHashKey("PICKUP_MONEY_SECURITY_CASE"), -354.009, -54.316, 49.096)
end

function tick()
	local  playerPed = GetPlayerPed(-1)
  local playerCoords = GetEntityCoords(playerPed, 0)

  if(stage==0) then
    if (GetDistanceBetweenCoords(-353.317, -54.1684, 49.0365, playerCoords.x, playerCoords.y, playerCoords.z, true ) < 2 ) then
      if (HasPickupBeenCollected(pickup)) then
    		SetPedComponentVariation(playerPed, 9, 1, 0, 0)
        SetPlayerWantedLevel(GetPlayerPed(playerPed),3,false)
  			SetPlayerWantedLevelNow(GetPlayerPed(playerPed),false)
        Drawing.drawMissionText(Translator.translate("eventFleecaJob_escapeCops"), 10000)
				stage = 1
        caseTaken = true
      end
    end
  end
  -- The cops are gone.
  if (stage == 1) then
      if not(IsPlayerWantedLevelGreater(GetPlayerPed(playerPed),0)) then
          if (caseTaken and stage == 1) then
            Drawing.drawMissionText(Translator.translate("eventFleecaJob_missionSuccess"), 5000)
            Citizen.Trace("Fleeca -Money money \n")
            pickup1 = CreatePickup(GetHashKey("PICKUP_MONEY_SECURITY_CASE"), -354.009, -54.316, 49.096)
            stage = 2
          end
      end
  end

  -- The player escaped successfully, award them.
  if (stage == 2) then
        -- Check if player is by bank...
    if (HasPickupBeenCollected(pickup1)) then
      SetPedComponentVariation(playerPed, 9, 0, 0, 0)
      PlayMissionCompleteAudio("FRANKLIN_BIG_01")
      TriggerServerEvent('mission:completed', 500000)
      Drawing.drawMissionText("Good job! here is some ~y~cash.", 5000)
      stage = 0
      caseTaken = false
    end
  end
end

function createBankArmy ()
  --Loading the wanted model for the pedestrian
  wanted_model="S_M_Y_MARINE_01" --Marine Army Guard
  modelHash = GetHashKey(wanted_model)

  RequestModel(modelHash)
  while not HasModelLoaded(modelHash) do
      Wait(1)
  end

  NetworkSync= true -- shared with other players (they can see him, shoot him, kill him, etc...)

  created_ped = CreatePed(5, modelHash , -353.878 ,-48.399, -49.036, 0.873, NetworkSync, NetworkSync)
end

