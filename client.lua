function dl(x)
    
    print(x)
end

ESX = nil
local L = nil


TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterNetEvent('rainf:recieveLocales')
AddEventHandler('rainf:recieveLocales', function(ld)
    print(ld.BanReason_Speedhack)
    L = ld
end)


Citizen.CreateThread(function()
    while L == nil do
        TriggerServerEvent('rainf:gimmeLocales')
        print("Locale error!")
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(2000)
    while true do
        Citizen.Wait(250)
        if RAINF_C.AntiGodMode then
            local playerped = PlayerPedId()
            local playerhealth = GetEntityHealth(playerped)
            SetEntityHealth(playerped, playerhealth - 2)
            -- local zamanlama = math.random(10, 150)
            if not IsPlayerDead(PlayerId()) and not ESX.GetPlayerData().IsDead then
                if GetEntityHealth(playerped) == playerhealth and GetEntityHealth(playerped) ~= 0 then
                    print("godcı oç")
                    TriggerServerEvent("df8227ff717b6a908856401249b4095b", L.BanReason_HealthHack)
                elseif GetEntityHealth(playerped) == playerhealth - 2 then
                    SetEntityHealth(playerped, GetEntityHealth(playerped) + 2)
                end
            end

            if GetEntityHealth(PlayerPedId()) > RAINF_C.MaxPlayerHealth then
                print("godcı oç")
                TriggerServerEvent("df8227ff717b6a908856401249b4095b", L.BanReason_HealthHack)
            end
            if GetPlayerInvincible(PlayerId()) or GetPlayerInvincible_2(PlayerId()) then
                print("godcı oç")
                TriggerServerEvent("df8227ff717b6a908856401249b4095b", L.BanReason_HealthHack)
                SetPlayerInvincible(PlayerId(), false)
            end
        end
        if RAINF_C.PlayerProtection then
            SetEntityProofs(GetPlayerPed(-1), false, true, true, false, false, false, false, false)
        end
        Citizen.Wait(250)
    end
end)
local first = false;
local commands = GetRegisteredCommands()
local actualResourceCount = Citizen.InvokeNative(0x863F27B)

AddEventHandler("playerSpawned", function()
    if first == false then
        d = #GetRegisteredCommands()
        e = Citizen.InvokeNative(0x863F27B)
        first = true
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local posx, posy, posz = table.unpack(GetEntityCoords(ped, true))
        local still = IsPedStill(ped)
        local vel = GetEntitySpeed(ped)
        local ped = PlayerPedId()
        local veh = IsPedInAnyVehicle(ped, true)
        local speed = GetEntitySpeed(ped)
        local para = GetPedParachuteState(ped)
        local flyveh = IsPedInFlyingVehicle(ped)
        local rag = IsPedRagdoll(ped)
        local fall = IsPedFalling(ped)
        local parafall = IsPedInParachuteFreeFall(ped)
        SetEntityVisible(PlayerPedId(), true) -- make sure player is visible
        Wait(3000) -- wait 3 seconds and check again

        local more = speed - 9.0 -- avarage running speed is 7.06 so just incase someone runs a bit faster it wont trigger

        local rounds = tonumber(string.format("%.2f", speed))
        local roundm = tonumber(string.format("%.2f", more))

        if not IsEntityVisible(PlayerPedId()) then
            SetEntityHealth(PlayerPedId(), -100) -- if player is invisible kill him!
        end

        newx, newy, newz = table.unpack(GetEntityCoords(ped, true))
        newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
        if GetDistanceBetweenCoords(posx, posy, posz, newx, newy, newz) > RAINF_C.PlayerSpeedLimit and still == IsPedStill(ped) and vel ==
            GetEntitySpeed(ped) and ped == newPed then
            -- TriggerServerEvent("AntiCheese:NoclipFlag", GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz))
            TriggerServerEvent("df8227ff717b6a908856401249b4095b", L.BanReason_Speedhack)
        end

        if speed > 9.0 and not veh and (para == -1 or para == 0) and not flyveh and not fall and not parafall and
            not rag then
            -- dont activate this, its broken!
            -- TriggerServerEvent("AntiCheese:SpeedFlag", rounds, roundm) -- send alert along with the rounded speed and how much faster they are
        end
    end
end)

Citizen.CreateThread(function()
    if RAINF_C.secondaryChecks then
        while true do
            Citizen.Wait(400)
            local ppi = PlayerPedId()
            SetPedInfiniteAmmoClip(ppi, false)
            SetPlayerInvisibleLocally(ppi, false);
            SetPlayerInvisibleLocally(ppi, false);
            SetPlayerInvincible(ppi, false)
            SetEntityInvincible(ppi, false)
            SetEntityCanBeDamaged(ppi, true)
            if not (IsEntityVisible(ppi)) then
                TriggerServerEvent("df8227ff717b6a908856401249b4095b", L.BanReason_Invisibility)
                SetEntityVisible(ppi, true)
            end
            ResetEntityAlpha(ppi)
        end
    end
end)

Citizen.CreateThread(function()
    if RAINF_C.resourceDetection then
        while true do
            dl("check res")
            ESX.TriggerServerCallback('rainfive:getresCount', function(rc)
                actualResourceCount = rc
            end)
            yourResourceCount = Citizen.InvokeNative(0x863F27B)
            if actualResourceCount ~= nil then
                if actualResourceCount ~= yourResourceCount then
                    dl("ban, resource instability")
                end
            end
            Citizen.Wait(10000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        if RAINF_C.removeExplosionDamage then
            SetEntityProofs(PlayerPedId(), false, true, true, false, false, false, false, false)
        end
    end
end)
RegisterCommand("tst", function(source, args, raw)
    local i = 0
    while i < 10 do
        ESX.TriggerServerCallback('rainfive:getresCount', function(rc)
            actualResourceCount = rc
        end)
        i = i + 1
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if RAINF_C.cheatEngineDetection then
            Citizen.Wait(5000)
            local j
            local k
            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                j = GetVehiclePedIsUsing(PlayerPedId())
                k = GetEntityModel(j)
                if j == b and k ~= c and c ~= nil and c ~= 0 then
                    DeleteVehicle(j)
                    TriggerServerEvent("df8227ff717b6a908856401249b4095b", L.BanReason_CheatEngine)
                    return
                end
            end
            b = j;
            c = k
        end
    end
end)
