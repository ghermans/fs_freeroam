local generalPed
local generalLoaded = false

-- Configure the coordinates for the vendors.
local general_peds = {
  { hash="mp_m_shopkeep_01", x=-46.313, y=-1757.504, z=29.421, a=46.395},
  { hash="mp_m_shopkeep_01", x=24.376, y=-1345.558, z=29.421, a=267.940},
  { hash="mp_m_shopkeep_01", x=1134.182, y=-982.477, z=46.416, a=275.432},
  { hash="mp_m_shopkeep_01", x=373.015, y=328.332, z=103.566, a=257.309},
  { hash="mp_m_shopkeep_01", x=2676.389, y=3280.362, z=55.241, a=332.305},
  { hash="mp_m_shopkeep_01", x=1958.960, y=3741.979, z=32.344, a=303.196},
  { hash="mp_m_shopkeep_01", x=-2966.391, y=391.324, z=15.043, a=88.867},
  { hash="mp_m_shopkeep_01", x=-1698.542, y=4922.583, z=42.064, a=324.021},
  { hash="mp_m_shopkeep_01", x=1164.565, y=-322.121, z=69.205, a=100.492},
  { hash="mp_m_shopkeep_01", x=-1486.530, y=-377.768, z=40.163, a=147.669},
  { hash="mp_m_shopkeep_01", x=-1221.568, y=-908.121, z=12.326, a=31.739},
  { hash="mp_m_shopkeep_01", x=-706.153, y=-913.464, z=19.216, a=82.056},
  { hash="mp_m_shopkeep_01", x=-1820.230, y=794.369, z=138.089, a=130.327},
  { hash="mp_m_shopkeep_01", x=2555.474, y=380.909, z=108.623, a=355.737},
  { hash="mp_m_shopkeep_01", x=1728.614, y=6416.729, z=35.037, a=247.369},
}

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    playerPed = GetPlayerPed(-1)
    playerCoords = GetEntityCoords(playerPed, 0)

    if (not generalLoaded) then
      for k,v in pairs(general_peds) do
        RequestModel(GetHashKey(v.hash))
        while not HasModelLoaded(GetHashKey(v.hash)) do
          Wait(1)
        end

        -- Load the animation for the vendors
        RequestAnimDict("amb@prop_human_bum_shopping_cart@male@base")
        while not HasAnimDictLoaded("amb@prop_human_bum_shopping_cart@male@base") do
          Wait(0)
        end

        generalPed = CreatePed(2, v.hash, v.x, v.y, v.z, v.a, false, false)
        SetBlockingOfNonTemporaryEvents(generalPed, true)
        SetPedFleeAttributes(generalPed, 0, 0)
        SetEntityInvincible(generalPed, true)
        -- Annimations
        TaskPlayAnim(generalPed,"amb@prop_human_bum_shopping_cart@male@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
      end
      generalLoaded = true
    end

    for k,v in pairs(general_peds) do
      local doordist = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, v.x, v.y, v.z)
      if doordist < 11 then
        aiming, ent = GetEntityPlayerIsFreeAimingAt(PlayerId(), Citizen.ReturnResultAnyway())
        if aiming and ent and IsEntityAPed(ent) then
          if IsPedDeadOrDying(ent, 1) then
            SetPlayerWantedLevel(PlayerId(), 3, false)
            SetPlayerWantedLevelNow(PlayerId() ,false)
          end
            if not(IsPlayerWantedLevelGreater(PlayerId(), 0)) then
            PlayPoliceReport("SCRIPTED_SCANNER_REPORT_ASS_MULTI_01", 0)
            SetPlayerWantedLevel(PlayerId(), 2, false)
            SetPlayerWantedLevelNow(PlayerId() ,false)
          end
        end
      end
    end

  end
end)
