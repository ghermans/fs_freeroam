--
-- Created by IntelliJ IDEA.
-- User: Stephen
-- Date: 6/15/2017
-- Time: 4:37 PM
--


local aptMapMarkers = {
    ["4_integrity_way_apt_28"] = {
        inMarker = { X = -63.292, Y = -616.444, Z = 34.265 },
        name = "4 integrity way apt 28",
        exitMarker = { X = -18.07856, Y = -18.07856, Z = -583.6725 },
        nearbyApts = {
            ["4_integrity_way_apt_30"] = {
                name = "4 integrity way apt 30",
                exitMarker = { X = -18.617, Y = -591.467, Z = 88.115 }
            }
        }
    },
    ["del_perro_heights_apt7"] = {
        inMarker = { X = -1446.868, Y = -538.276, Z = 32.820 },
        name = "del perro heights apt7",
        exitMarker = { X = -1450.000, Y = -525.800, Z = 68.529 },
        nearbyApts = {
            ["del_perro_heights_apt4"] = {
                name = "del perro heights apt4",
                exitMarker = { X = -1452.6318359375, Y = -540.032165527344, Z = 72.044303894043 }
            }
        }
    },
    ["richard_majestic_apt_2"] = {
        inMarker = { X = -937.054382324219, Y = -379.453918457031, Z = 36.9613342285156 },
        name = "richard majestic apt 2",
        exitMarker = { X = -922.989440917969, Y = -378.582458496094, Z = 83.4804840087891 },
        nearbyApts = {}
    },
    ["tinsel towers apt42"] = {
        inMarker = { X = -614.111328125, Y = 45.2735786437988, Z = 41.5914611816406 },
        name = "tinsel towers apt42",
        exitMarker = { X = -603.991760253906, Y = 58.9186134338379, Z = 96.2001953125 },
        nearbyApts = {}
    },
    ["eclipse towers apt 3"] = {
        inMarker = { X = -770.377319335938, Y = 317.040802001953, Z = 83.6626510620117 },
        name = "eclipse towers apt 3",
        exitMarker = { X = -784.596923828125, Y = 323.659393310547, Z = 209.997131347656 },
        nearbyApts = {}
    },
    ["3655 wild oats drive"] = {
        inMarker = { X = -175.676788330078, Y = 502.43408203125, Z = 135.420684814453 },
        name = "3655 wild oats drive",
        exitMarker = { X = -173.819839477539, Y = 496.174224853516, Z = 135.6669921875 },
        nearbyApts = {}
    },
    ["2044 north conker avenue"] = {
        inMarker = { X = 347.220794677734, Y = 441.418212890625, Z = 145.701843261719 },
        name = "2044 north conker avenue",
        exitMarker = { X = 340.936645507813, Y = 437.107482910156, Z = 147.394088745117 },
        nearbyApts = {}
    },
    ["2045 north conker avenue"] = {
        inMarker = { X = 373.370208740234, Y = 428.043243408203, Z = 143.684555053711 },
        name = "2045 north conker avenue",
        exitMarker = { X = 373.347686767578, Y = 423.132690429688, Z = 143.907897949219 },
        nearbyApts = {}
    },
    ["2862 hillcrest avenue"] = {
        inMarker = { X = -686.790588378906, Y = 596.580810546875, Z = 141.642028808594 },
        name = "2862 hillcrest avenue",
        exitMarker = { X = -681.863403320313, Y = 592.153503417969, Z = 143.393051147461 },
        nearbyApts = {}
    },
    ["2868 hillcrest avenue"] = {
        inMarker = { X = -751.216918945313, Y = 621.410888671875, Z = 140.261199951172 },
        name = "2868 hillcrest avenue",
        exitMarker = { X = -758.76220703125, Y = 618.773254394531, Z = 142.153930664063 },
        nearbyApts = {}
    },
    ["2874 hillcrest avenue"] = {
        inMarker = { X = -853.353759765625, Y = 696.033020019531, Z = 146.784759521484 },
        name = "2874 hillcrest avenue",
        exitMarker = { X = -859.948425292969, Y = 689.782836914063, Z = 151.860733032227 },
        nearbyApts = {}
    },
    ["whispymound drive 3677"] = {
        inMarker = { X = 119.131958007813, Y = 564.880004882813, Z = 181.959335327148 },
        name = "whispymound drive 3677",
        exitMarker = { X = 117.198219299316, Y = 559.311462402344, Z = 182.304901123047 },
        nearbyApts = {}
    },
    ["2113 mad wayne thunder"] = {
        inMarker = { X = -1294.97436523438, Y = 455.17041015625, Z = 95.4321670532227 },
        name = "2113 mad wayne thunder",
        exitMarker = { X = -1290.00170898438, Y = 448.739990234375, Z = 95.9025268554688 },
        nearbyApts = {}
    },
}

local markerScaleX = 1.2
local markerScaleY = 1.2
local markerScaleZ = 1.5

Citizen.CreateThread(function()
    Citizen.Trace("Test apartments")
    while true do
        Citizen.Wait(0)
        aptMapMarkerInit()
    end
end)

Citizen.CreateThread(function()
    Citizen.Trace("Test apartments")
    while true do
        Citizen.Wait(0)
        aptCheckPlayerPosInAreas()
    end
end)
-- use in a loop
function aptMapMarkerInit()
    -- make the markers
    for k, v in pairs(aptMapMarkers) do

        -- in marker
        DrawMarker(1, v.inMarker.X, v.inMarker.Y, v.inMarker.Z, 0, 0, 0, 0, 0, 0, markerScaleX, markerScaleY, markerScaleZ, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)

        -- Draw the levels 3d text if any...
        if (v.nearbyApts == nil) then
            -- in marker 3d text
            Drawing.draw3DText(v.inMarker.X, v.inMarker.Y, v.inMarker.Z + .500, v.name, 7, 0.3, 0.2)
        else
            Drawing.draw3DText(v.inMarker.X, v.inMarker.Y, v.inMarker.Z + .500, v.name, 7, 0.3, 0.2)
            for aptLevelKey, aptLevel in pairs(v.nearbyApts) do
                --  in marker 3d text
                Drawing.draw3DText(v.inMarker.X, v.inMarker.Y, v.inMarker.Z + .100, aptLevel.name, 7, 0.3, 0.2)

                -- aptlevel out marker
                DrawMarker(1, aptLevel.exitMarker.X, aptLevel.exitMarker.Y, aptLevel.exitMarker.Z, 0, 0, 0, 0, 0, 0, markerScaleX, markerScaleY, markerScaleZ, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)

                -- out marker 3d text
                Drawing.draw3DText(aptLevel.exitMarker.X, aptLevel.exitMarker.Y, aptLevel.exitMarker.Z + .500, Translator.translate("common_exit"), 7, 0.3, 0.2)
            end
        end

        -- out marker
        DrawMarker(1, v.exitMarker.X, v.exitMarker.Y, v.exitMarker.Z, 0, 0, 0, 0, 0, 0, markerScaleX, markerScaleY, markerScaleZ, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)

        -- out marker 3d text
        Drawing.draw3DText(v.exitMarker.X, v.exitMarker.Y, v.exitMarker.Z + .500, Translator.translate("common_exit"), 7, 0.3, 0.2)
    end
end

function aptCheckPlayerPosInAreas()
    for i, v in pairs(aptMapMarkers) do

        local playerPed = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(playerPed, 0)



        -- Just let player in if its a single house or single apartment
        -- Drawing.drawMissionText("in the area", 5000)

        -- in marker checks
        if (GetDistanceBetweenCoords(playerCoords, v.inMarker.X, v.inMarker.Y, v.inMarker.Z) < 0.5) then
            RequestCollisionAtCoord(v.inMarker.X, v.inMarker.Y, v.inMarker.Z)
            while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
                RequestCollisionAtCoord(v.inMarker.X, v.inMarker.Y, v.exitMarker.Z)
                Citizen.Wait(0)
            end

            Citizen.Wait(1000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            SetEntityCoords(GetPlayerPed(-1), v.exitMarker.X + 0.500, v.exitMarker.Y, v.exitMarker.Z + 2)
            -- SetEntityHeading(GetPlayerPed(-1), 100.475)
            DoScreenFadeIn(1000)
        end

        -- exit marker checks
        if (GetDistanceBetweenCoords(playerCoords, v.exitMarker.X, v.exitMarker.Y, v.exitMarker.Z) < 0.5) then
            RequestCollisionAtCoord(v.exitMarker.X, v.exitMarker.Y, v.exitMarker.Z)
            while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
                RequestCollisionAtCoord(v.exitMarker.X, v.exitMarker.Y, v.exitMarker.Z)
                Citizen.Wait(0)
            end

            Citizen.Wait(1000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            SetEntityCoords(GetPlayerPed(-1), v.inMarker.X + .500, v.inMarker.Y, v.inMarker.Z + 2)
            -- SetEntityHeading(GetPlayerPed(-1), 100.475)
            DoScreenFadeIn(1000)
            Citizen.Wait(1000)
        end
    end
end