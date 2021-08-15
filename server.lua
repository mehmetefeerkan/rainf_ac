Citizen.CreateThread(function()
    Citizen.Wait(5000)
    -- LOCALES
    local L = {}
    ESX = nil
    RAINF_S = nil
    TriggerEvent('rainf:getlocales', function(obj)
        L = obj
    end)
    TriggerEvent('rainf:getServerConfig', function(obj)
        RAINF_S = obj
    end)
    TriggerEvent('esx:getSharedObject', function(obj)
        ESX = obj
    end)
    --

    -- BANLIST VARS
    local BanList = {}
    local BanListLoad = false
    --

    admincache = {}
    BannedPlayerCache = {}
    CheckPlayers = {}
    CheckPlayers2 = {}
    loaded  = {}
    charset    = ''
    charTable  = {}
    carSpamCheck = {}
    pedSpam = {}

    CreateThread(function()
        while true do
            Wait(1000)
            if BanListLoad == false then
                loadBanList()
                if BanList ~= {} then
                    BanListLoad = true
                else
                    print("^2 BANLIST ERROR!")
                    Citizen.Wait(3000)
                    os.exit()
                    return
                end
            end
        end
    end)

    CreateThread(function()
        while true do
            Wait(600000)
            if BanListLoad == true then
                loadBanList()
            end
        end
    end)

    ESX.RegisterServerCallback("rainfive:getresCount", function(a, b)
        b(Citizen.InvokeNative(0x863F27B))
    end)

    RegisterServerEvent('0630b3126acf5311d1c4928e8abcdf70')
    AddEventHandler('0630b3126acf5311d1c4928e8abcdf70', function(reason, servertarget)
        local license, identifier, liveid, xblid, discord, playerip, target
        local duree = 0
        local reason = reason

        if not reason then
            reason = "Auto Anti-Cheat"
        end

        if tostring(source) == "" then
            target = tonumber(servertarget)
        else
            target = source
        end

        if target and target > 0 then
            local ping = GetPlayerPing(target)

            if ping and ping > 0 then
                if duree and duree < 365 then
                    local sourceplayername = "RainFiveAC"
                    local targetplayername = GetPlayerName(target)
                    for k, v in ipairs(GetPlayerIdentifiers(target)) do
                        if string.sub(v, 1, string.len("license:")) == "license:" then
                            license = v
                        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                            identifier = v
                        elseif string.sub(v, 1, string.len("live:")) == "live:" then
                            liveid = v
                        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                            xblid = v
                        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                            discord = v
                        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                            playerip = v
                        end
                    end

                    if duree > 0 then
                        ban(target, license, identifier, liveid, xblid, discord, playerip, targetplayername,
                            sourceplayername, duree, reason, 0) -- Timed ban here
                        DropPlayer(target, "Ban : " .. reason)
                    else
                        ban(target, license, identifier, liveid, xblid, discord, playerip, targetplayername,
                            sourceplayername, duree, reason, 1) -- Perm ban here
                        DropPlayer(target, "Ban : " .. reason)
                    end

                else
                    -- print("BanSql Error : Auto-Cheat-Ban time invalid.")
                end
            else
                -- print("BanSql Error : Auto-Cheat-Ban target are not online.")
            end
        else
            -- print("BanSql Error : Auto-Cheat-Ban have recive invalid id.")
        end
    end)

    print("deferrals ready")
    AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
        local license, steamID, liveid, xblid, discord, playerip = "n/a", "n/a", "n/a", "n/a", "n/a", "n/a"
        local player = source
        deferrals.defer()

                    Wait(4000)

                    deferrals.presentCard([==[
                        {
                            "type": "AdaptiveCard",
                            "body": [
                                {
                                    "color": "Dark",
                                    "type": "TextBlock",
                                    "size": "Medium",
                                    "weight": "Bolder",
                                    "text": "RainFive Anti-Cheat",
                                    "horizontalAlignment": "Center"
                                },
                                {
                                    "color": "Dark",
                                    "type": "TextBlock",
                                    "wrap": true,
                                    "horizontalAlignment": "Center",
                                    "text": "Banlist check..."
                                }
                            ],
                            "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                            "version": "1.3",
                            "backgroundImage": {
                                "url": "https://img.freepik.com/free-vector/blue-abstract-background_1393-339.jpg?size=626&ext=jpg",
                                "horizontalAlignment": "Center",
                                "verticalAlignment": "Center"
                            }
                        }
			]==])
            Citizen.Wait(2000)
        for k, v in ipairs(GetPlayerIdentifiers(player)) do
            if string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamID = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xblid = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                playerip = v
            end
        end

        -- Si Banlist pas chargée
        if (Banlist == {}) then
            Citizen.Wait(1000)
        end
        local canProceed = true
        for i = 1, #BanList, 1 do
            if ((tostring(BanList[i].license)) == tostring(license) or (tostring(BanList[i].identifier)) ==
                tostring(steamID) or (tostring(BanList[i].liveid)) == tostring(liveid) or (tostring(BanList[i].xblid)) ==
                tostring(xblid) or (tostring(BanList[i].discord)) == tostring(discord) or
                (tostring(BanList[i].playerip)) == tostring(playerip)) then
                    canProceed = false
                if (tonumber(BanList[i].permanent)) == 1 then
                    
                    
                    deferrals.done("P R O T E C T E D  B Y  R A I N F I V E" .. BanList[i].reason)
                    CancelEvent()
                    canProceed = false
                    --print("^1rainfive - " .. GetPlayerName(source) .. L.DoneDeferralsCuzBanned)
                    break
                end
            end
        end
        if canProceed then
            deferrals.done()
        end
    end)

    function ban(source, license, identifier, liveid, xblid, discord, playerip, targetplayername, sourceplayername,
        duree, reason, permanent)
        -- calcul total expiration (en secondes)
        local expiration = duree * 86400
        local timeat = os.time()
        local added = os.date()

        if expiration < os.time() then
            expiration = os.time() + expiration
        end

        table.insert(BanList, {
            license = license,
            identifier = identifier,
            liveid = liveid,
            xblid = xblid,
            discord = discord,
            playerip = playerip,
            reason = reason,
            expiration = expiration,
            permanent = permanent
        })

        MySQL.Async.execute(
            'INSERT INTO rfacban (license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)',
            {
                ['@license'] = license,
                ['@identifier'] = identifier,
                ['@liveid'] = liveid,
                ['@xblid'] = xblid,
                ['@discord'] = discord,
                ['@playerip'] = playerip,
                ['@targetplayername'] = targetplayername,
                ['@sourceplayername'] = sourceplayername,
                ['@reason'] = reason,
                ['@expiration'] = expiration,
                ['@timeat'] = timeat,
                ['@permanent'] = permanent
            }, function()
            end)
        BanListHistoryLoad = false
    end

    function loadBanList()
        if (RAINF_S.DatabaseBan) then
            BanList = {}
            MySQL.Async.fetchAll('SELECT * FROM rfacban', {}, function(data)
                BanList = {}

                for i = 1, #data, 1 do
                    table.insert(BanList, {
                        license = data[i].license,
                        identifier = data[i].identifier,
                        liveid = data[i].liveid,
                        xblid = data[i].xblid,
                        discord = data[i].discord,
                        playerip = data[i].playerip,
                        reason = data[i].reason,
                        expiration = data[i].expiration,
                        permanent = data[i].permanent
                    })
                end

            end)
        end
    end
--[[
    AddEventHandler('playerConnecting', function()
        local color = "^" .. math.random(0, 9)
        print("[RainFive] ^7- " .. color .. " " .. GetPlayerName(source) .. L.PlayerConnecting .. "^0") 
    end)
]]
    RegisterCommand("wsunban", function(source, args, raw)
        if IsPlayerAceAllowed(source, "rainfivebypass") then
            cmdunban(source, args)
        end
    end)
    RegisterCommand("reloadbanlist", function(source, args, raw)
        if source == 0 then
            loadBanList()
        end
    end)

    function cmdunban(source, args)
        if args[1] then
            local target = table.concat(args, " ")
            MySQL.Async.fetchAll('SELECT * FROM banlist WHERE targetplayername like @playername', {
                ['@playername'] = ("%" .. target .. "%")
            }, function(data)
                if data[1] then
                    if #data > 1 then
                    else
                        MySQL.Async.execute('DELETE FROM banlist WHERE targetplayername = @name', {
                            ['@name'] = data[1].targetplayername
                        }, function()
                            loadBanList()
                            TriggerClientEvent('chat:addMessage', source, {
                                args = {'^1Banlist ', data[1].targetplayername .. L.UnBanned}
                            })
                        end)
                    end
                else
                end
            end)
        else
        end
    end

    for k, v in pairs(RAINF_S.TriggerLimitedEvents) do
        RegisterServerEvent(v)
        AddEventHandler(v, function(...)
            TriggerEvent("rainf:logCallback", source)
            print(v)
        end)
    end

    RegisterServerEvent('esx:triggerServerCallback')
    AddEventHandler('esx:triggerServerCallback', function(name, requestId, ...)
        local playerID = source
        TriggerEvent("rainf:logCallback", source, name)
    end)

    callbackLogs = {}
    RegisterServerEvent('rainf:logCallback')
    AddEventHandler('rainf:logCallback', function(src, name)
        if callbackLogs[src] == nil then
            callbackLogs[src] = 1
        else
            if callbackLogs[src] > RAINF_S.TriggerSpamLimit then
                if RAINF_S.TriggerRateLimits[name] then
                    callbackLogs[src] = callbackLogs[src] + 1
                    if callbackLogs[src] > RAINF_S.TriggerRateLimits[name] then
                        TriggerEvent('0630b3126acf5311d1c4928e8abcdf70',
                            L.CallbackLimitExceeded .. name, src)
                    end
                else
                    if RAINF_S.TriggerLimitIsStrict then
                        TriggerEvent('0630b3126acf5311d1c4928e8abcdf70', L.CallbackLimitExceeded .. name, src)
                    end
                end
            else
                callbackLogs[src] = callbackLogs[src] + 1
            end
        end
    end)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(RAINF_S.TriggerRateLimitReset)
            callbackLogs = {}
        end
    end)

    RegisterServerEvent('esx_communityservice:sendToCommunityService')
    AddEventHandler('esx_communityservice:sendToCommunityService', function()
        local xPlayer = ESX.GetPlayerFromId(source)
        print("^2Kamu İşlemi: | Kullanıcı :.^2 ^5" .. GetPlayerName(source) .. "^6 [" .. source ..
                  "] ^3Tarafından tetiklendi.^3")
        if xPlayer.getJob().name ~= RAINF_S.PolisJob and xPlayer.getJob().name ~= RAINF_S.SheriffJob then
            TriggerEvent('0630b3126acf5311d1c4928e8abcdf70', src,
                L.InsufficientPermsForTrigger .. "SendToCommunityService")
            print(L.EndingECS)
            Citizen.Wait(1000)
            MySQL.Sync.execute('DELETE from communityservice', {})
            TriggerClientEvent('esx_communityservice:finishCommunityService', -1)
        end
    end)

    RegisterServerEvent('esx_jail:sendToJail')
    AddEventHandler('esx_jail:sendToJail', function(playerID)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getJob().name ~= RAINF_S.PolisJob and xPlayer.getJob().name ~= RAINF_S.SheriffJob then
            TriggerEvent('0630b3126acf5311d1c4928e8abcdf70', src, L.InsufficientPermsForTrigger .. "sendToJail")
        end
    end)

    RegisterServerEvent('esx_sheriffjob:message')
    AddEventHandler('esx_sheriffjob:message', function(playerID)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getJob().name ~= RAINF_S.PolisJob and xPlayer.getJob().name ~= RAINF_S.SheriffJob then
            TriggerEvent('0630b3126acf5311d1c4928e8abcdf70', src, L.InsufficientPermsForTrigger .. "sheriffjob:message")
        end
    end)

    local newestversion = "v1.6.4"
    local versionac = RAINF_S.Version

    function inTable(tbl, item)
        for key, value in pairs(tbl) do
            if value == item then
                return key
            end
        end
        return false
    end

    -- =====================================================--
    -- ============== AUTHENTIFICATION SYSTEM ==============--
    -- =====================================================--
    Citizen.CreateThread(function()
        SetConvarServerInfo("RainF-AC", L.ACWebsite)
        logo()
        print("^3[RAINF-AC] ^0 " .. L.DevelopedBy)
        if RAINF_S.TriggerCheck then
            ExecuteCommand("triggerCheck")
            print("^3[RAINF-AC] ^2 " .. L.TriggerScan)
        end
        if RAINF_S.GlobalBanlist then
            print("^3[RAINF-AC] ^2 " .. L.BanlistActive)
        end
        print("^3[RAINF-AC] ^2 " .. L.BanlistActive)
        if nullfieldcheck() then
            ACStarted()
        else
            print(L.DelayedLaunch)
            -- Citizen.Wait(10000)
        end
    end)

    function logo()
        print([[^7
        ########     ###    #### ##    ## ######## 
        ##     ##   ## ##    ##  ###   ## ##        
        ##     ##  ##   ##   ##  ####  ## ##        
        ########  ##     ##  ##  ## ## ## ######    
        ##   ##   #########  ##  ##  #### ##        
        ##    ##  ##     ##  ##  ##   ### ##        
        ##     ## ##     ## #### ##    ## ##       
    
    ]])
    end

    function nullfieldcheck()
        if RAINF_S.LogBanWebhook == "" or RAINF_S.LogBanWebhook == nil then
            print("^3[RAINF-AC] ^4 " .. L.NoLogBanWebhook)
        elseif RAINF_S.ServerName == "" or RAINF_S.ServerName == nil then
            print("^3[RAINF-AC] ^4 " .. L.NoServerName)
        elseif RAINF_S.ModelsLogWebhook == "" or RAINF_S.ModelsLogWebhook == nil then
            print("^3[RAINF-AC] ^4 " .. L.NoModelsLogWebhook)
        elseif RAINF_S.ExplosionLogWebhook == "" or RAINF_S.ExplosionLogWebhook == nil then
            print("^3[RAINF-AC] ^4 " .. L.NoExplosionLogWebhook)
        elseif RAINF_S.AntiVPN == nil then
            print("^3[RAINF-AC] ^4 " .. L.NoAntiVPN)
        elseif RAINF_S.AntiVPNDiscordLogs == nil then
            print("^3[RAINF-AC] ^4 " .. L.NoAntiVPNDiscordLogs)
        else
            return true
        end
    end

    -- =====================================================--
    -- =====================================================--

    LogBanToDiscord = function(playerId, reason, typee)
        playerId = tonumber(playerId)
        local name = GetPlayerName(playerId)
        if playerId == 0 then
            local name = "YOU HAVE TRIGGERED A BLACKLISTED TRIGGER"
            local reason = "YOU HAVE TRIGGERED A BLACKLISTED TRIGGER"
        else
        end
        local steamid = "Unknown"
        local license = "Unknown"
        local discord = "Unknown"
        local xbl = "Unknown"
        local liveid = "Unknown"
        local ip = "Unknown"

        if name == nil then
            name = "Unknown"
        end

        for k, v in pairs(GetPlayerIdentifiers(playerId)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamid = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xbl = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                ip = string.sub(v, 4)
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discordid = string.sub(v, 9)
                discord = "<@" .. discordid .. ">"
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
            end
        end

        local discordInfo = {
            ["color"] = "15158332",
            ["type"] = "rich",
            ["title"] = L.PlayerWasBanned,
            ["description"] = "**Name : **" .. name .. "\n **Reason : **" .. "\n **Type : **" .. typee .. reason ..
                "\n **ID : **" .. playerId .. "\n **IP : **" .. ip .. "\n **Steam Hex : **" .. steamid ..
                "\n **License : **" .. license .. "\n **Discord : **" .. discord,
            ["footer"] = {
                ["text"] = " RainFiveAC"
            }
        }

    end

    ACStarted = function()
        local discordInfo = {
            ["color"] = "15158332",
            ["type"] = "rich",
            ["title"] = " RainFiveAC " .. L.Integrity,
            ["footer"] = {
                ["text"] = " RainFiveAC "
            }
        }

        PerformHttpRequest(RAINF_S.LogBanWebhook, function(err, text, headers)
        end, "POST", json.encode({
            username = " RainFiveAC",
            embeds = {discordInfo}
        }), {
            ["Content-Type"] = "application/json"
        })
    end
    function playerInfoExtraction(src)
        local s = "Unknown"
        local l = "Unknown"
        local d = "Unknown"
        local x = "Unknown"
        local l2 = "Unknown"
        local ip = "Unknown"

        if n == nil then
            n = "Unknown"
        end

        for k, v in pairs(GetPlayerIdentifiers(src)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                s = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                l = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                x = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                ip = string.sub(v, 4)
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                d = string.sub(v, 9)
                d = "<@" .. d .. ">"
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                l2 = v
            end
        end

        return {
            ["steam"] = s,
            ["discord"] = d,
            ["license"] = l,
            ["ip"] = ip,
            ["live"] = l2,
            ["name"] = GetPlayerName(src)
        }
    end
    ACFailed = function()
    end

    -- =====================================================--
    -- =====================================================--

    RegisterServerEvent("df8227ff717b6a908856401249b4095b")
    AddEventHandler("df8227ff717b6a908856401249b4095b", function(reason)
        print(source .. " :  " .. reason)
        local p = playerInfoExtraction(source)
        ban(source, p["steam"], p["steam"], p["live"], p["live"], p["discord"], p["ip"], p["name"],
            "RainFive Anti-Cheat", 365, reason, true)
        DropPlayer(source, reason)
        -- local _type = type or "default"
        -- local _item = item or "none"
        -- _type = string.lower(_type)

        -- if not IsPlayerAceAllowed(source, "rainfivebypass") then
        --    LogBanToDiscord(source, type, "basic")
        -- end
    end)

    Citizen.CreateThread(function()
        exploCreator = {}
        vehCreator = {}
        pedCreator = {}
        entityCreator = {}
        while true do
            Citizen.Wait(2500)
            exploCreator = {}
            vehCreator = {}
            pedCreator = {}
            entityCreator = {}
        end
    end)

    if RAINF_S.ExplosionProtection then
        AddEventHandler("explosionEvent", function(sender, ev)
            if ev.damageScale ~= 0.0 then
                local BlacklistedExplosionsArray = {}

                for kkk, vvv in pairs(RAINF_S.BlockedExplosions) do
                    table.insert(BlacklistedExplosionsArray, vvv)
                end

                if inTable(BlacklistedExplosionsArray, ev.explosionType) ~= false then
                    CancelEvent()
                    LogBanToDiscord(sender, L.ExplosionAttempt .. " " .. ev.explosionType, "explosion")
                    TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : " .. L.ExplosionAttempt, sender)
                else
                    -- LogBanToDiscord(sender, "Tried to Explose a player","explosion")
                end

                if ev.explosionType ~= 9 then
                    exploCreator[sender] = (exploCreator[sender] or 0) + 1
                    if exploCreator[sender] > 3 then
                        LogBanToDiscord(sender, L.MassExplosionAttempt .. ev.explosionType, "explosion")
                        TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : " .. L.MassExplosionAttempt,
                            sender)
                        CancelEvent()
                    end
                else
                    exploCreator[sender] = (exploCreator[sender] or 0) + 1
                    if exploCreator[sender] > 3 then
                        LogBanToDiscord(sender, L.GasPumpMishap, "explosion")
                        -- TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : Spawned Mass Explosion", sender)
                        CancelEvent()
                    end
                end

                if ev.isAudible == false then
                    LogBanToDiscord(sender, L.SilentExplosionAttempt .. ev.explosionType, "explosion")
                    TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : " .. L.SilentExplosionAttempt,
                        sender)
                end

                if ev.isInvisible == true then
                    LogBanToDiscord(sender, L.HiddenExplosionAttempt .. ev.explosionType, "explosion")
                    TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : " .. L.HiddenExplosionAttempt,
                        sender)
                end

                if ev.damageScale > 1.0 then
                    LogBanToDiscord(sender, L.WhatTheFuckExplosion .. ev.explosionType, "explosion")
                    TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : " .. L.WhatTheFuckExplosion, sender)
                end
                CancelEvent()
            end
        end)
    end

    if RAINF_S.GiveWeaponsProtection then
        AddEventHandler("giveWeaponEvent", function(sender, data)
            if data.givenAsPickup == false then
                LogBanToDiscord(sender, L.AttemptedWeaponGive, "basic")
                TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : " .. L.AttemptedWeaponGive, sender)
                CancelEvent()
            end
        end)

        AddEventHandler("RemoveWeaponEvent", function(sender, data)
            CancelEvent()
            LogBanToDiscord(sender, L.AttemptedWeaponRemove, "basic")
            TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : " .. L.AttemptedWeaponRemove, sender)
        end)

        AddEventHandler("RemoveAllWeaponsEvent", function(sender, data)
            CancelEvent()
            LogBanToDiscord(sender, L.AttemptedWeaponRemoveAll, "basic")
            TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : " .. L.AttemptedWeaponRemoveAll, sender)
        end)
    end

    if RAINF_S.WordsProtection then
        AddEventHandler("chatMessage", function(source, n, message)
            for k, n in pairs(RAINF_S.BlacklistedWords) do
                if string.match(message:lower(), n:lower()) then
                    LogBanToDiscord(source, L.CensoredThat .. n, "basic")
                    TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : Blacklist Chat", source)
                end
            end
        end)
    end

    if RAINF_S.TriggersProtection then
        for k, events in pairs(RAINF_S.BlacklistedEvents) do
            RegisterServerEvent(events)
            AddEventHandler(events, function()
                LogBanToDiscord(source, L.PreventedThatTrigger .. events, "basic")
                TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : Blacklist Event", source)
                CancelEvent()
            end)
        end
    end

    AddEventHandler("entityCreating", function(entity)
        if DoesEntityExist(entity) then
            local src = NetworkGetEntityOwner(entity)
            local model = GetEntityModel(entity)
            local blacklistedPropsArray = {}
            local WhitelistedPropsArray = {}
            local eType = GetEntityPopulationType(entity)

            if src == nil then
                CancelEvent()
            end

            for bl_k, bl_v in pairs(RAINF_S.BlacklistedModels) do
                table.insert(blacklistedPropsArray, GetHashKey(bl_v))
            end

            for wl_k, wl_v in pairs(RAINF_S.WhitelistedProps) do
                table.insert(WhitelistedPropsArray, GetHashKey(wl_v))
            end

            if eType == 0 then
                CancelEvent()
            end

            if GetEntityType(entity) == 3 then
                if eType == 6 or eType == 7 then
                    if inTable(WhitelistedPropsArray, model) == false then
                        if model ~= 0 then
                            LogBanToDiscord(src, L.PreventedBlacklistProp .. model, "model")
                            -- TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : Spawned Prop", src)
                            CancelEvent()

                            entityCreator[src] = (entityCreator[src] or 0) + 1
                            if entityCreator[src] > 30 then
                                LogBanToDiscord(src, L.TriedToSpawn .. entityCreator[src] .. " entities", "model")
                                -- TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : Spawned Mass Entities", src)
                            end
                        end
                    end
                end
            else
                if GetEntityType(entity) == 2 then
                    if eType == 6 or eType == 7 then
                        if inTable(blacklistedPropsArray, model) ~= false then
                            if model ~= 0 then
                                LogBanToDiscord(src, L.TriedToSpawn .. model, "model")
                                -- TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : Spawned Blacklisted Vehicle", src)
                                CancelEvent()
                            end
                        end
                        vehCreator[src] = (vehCreator[src] or 0) + 1
                        if vehCreator[src] > 20 then
                            LogBanToDiscord(src, L.TriedToSpawn .. vehCreator[src] .. " vehs", "model")
                            TriggerEvent("0630b3126acf5311d1c4928e8abcdf70",
                                " RainFiveAC : " .. L.TriedToSpawn .. vehCreator[src], src)
                        end
                    end
                elseif GetEntityType(entity) == 1 then
                    if eType == 6 or eType == 7 then
                        if inTable(blacklistedPropsArray, model) ~= false then
                            if model ~= 0 or model ~= 225514697 then
                                LogBanToDiscord(src, L.TriedToSpawn .. model, "model")
                                -- TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : Spawned Blacklisted Ped", src)
                                CancelEvent()
                            end
                        end
                        pedCreator[src] = (pedCreator[src] or 0) + 1
                        if pedCreator[src] > 20 then
                            LogBanToDiscord(src, L.TriedToSpawn .. pedCreator[src] .. " peds", "model")
                            TriggerEvent("0630b3126acf5311d1c4928e8abcdf70",
                                " RainFiveAC : " .. L.TriedToSpawn .. pedCreator[src], src)
                        end
                    end
                else
                    if inTable(blacklistedPropsArray, GetHashKey(entity)) ~= false then
                        if model ~= 0 or model ~= 225514697 then
                            LogBanToDiscord(src, L.TriedToSpawn .. model, "model")
                            -- TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : Spawned Blacklisted Model", src)
                            CancelEvent()
                        end
                    end
                end
            end
        end
    end)

    RegisterNetEvent("rainfive:DeleteEntity")
    AddEventHandler('rainfive:DeleteEntity', function(Entity)
        local object = NetworkGetEntityFromNetworkId(Entity)
        NetworkRequestControlOfEntity(object)
        local timeout = 2000
        while timeout > 0 and not NetworkHasControlOfEntity(object) do
            Wait(100)
            timeout = timeout - 100
        end
        if DoesEntityExist(object) then
            ESX.Game.DeleteObject(object)
        end
    end)

    RegisterNetEvent("rainfive:DeletePeds")
    AddEventHandler('rainfive:DeletePeds', function(Ped)
        local ped = NetworkGetEntityFromNetworkId(Ped)
        if DoesEntityExist(ped) then
            if not IsPedAPlayer(ped) then
                local model = GetEntityModel(ped)
                if not IsPedAPlayer(ped) then
                    if IsPedInAnyVehicle(ped) then
                        local vehicle = GetVehiclePedIsIn(ped)
                        NetworkRequestControlOfEntity(vehicle)
                        local timeout = 2000
                        while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
                            Wait(100)
                            timeout = timeout - 100
                        end
                        SetEntityAsMissionEntity(vehicle, true, true)
                        local timeout = 2000
                        while timeout > 0 and not IsEntityAMissionEntity(vehicle) do
                            Wait(100)
                            timeout = timeout - 100
                        end
                        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
                        DeleteEntity(vehicle)
                        NetworkRequestControlOfEntity(ped)
                        local timeout = 2000
                        while timeout > 0 and not NetworkHasControlOfEntity(ped) do
                            Wait(100)
                            timeout = timeout - 100
                        end
                        DeleteEntity(ped)
                    else
                        NetworkRequestControlOfEntity(ped)
                        local timeout = 2000
                        while timeout > 0 and not NetworkHasControlOfEntity(ped) do
                            Wait(100)
                            timeout = timeout - 100
                        end
                        DeleteEntity(ped)
                    end
                end
            end
        end
    end)

    RegisterNetEvent("rainfive:DeleteCars")
    AddEventHandler('rainfive:DeleteCars', function(vehicle)
        local vehicle = NetworkGetEntityFromNetworkId(vehicle)
        if DoesEntityExist(vehicle) then
            NetworkRequestControlOfEntity(vehicle)
            local timeout = 2000
            while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
                Wait(100)
                timeout = timeout - 100
            end
            SetEntityAsMissionEntity(vehicle, true, true)
            local timeout = 2000
            while timeout > 0 and not IsEntityAMissionEntity(vehicle) do
                Wait(100)
                timeout = timeout - 100
            end
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
        end
    end)

    AddEventHandler('entityCreated', function(entity)
        local model = GetEntityModel(entity)
        local eType = GetEntityType(entity)
        local plyr = NetworkGetEntityOwner(entity)
        local xPlayer = ESX.GetPlayerFromId(plyr)
        local hash = GetHashKey(entity)
        local entity = entity

        if not DoesEntityExist(entity) then
            return
        end

        local src = NetworkGetEntityOwner(entity)

        if carSpamCheck[src] == true then
            TriggerClientEvent("rainfive:DeleteEntity", -1, entID)
            return
        end

        if carSpamCheck[src] == nil then
            carSpamCheck[src] = {}
        end

        local entID = NetworkGetNetworkIdFromEntity(entity)
        local model = GetEntityModel(entity)
        local hash = GetHashKey(entity)
        local SpawnerName = GetPlayerName(src)

        if RAINF_S.VehicleProtection and GetEntityType(entity) == 2 then
            if carSpamCheck[src][model] then
                carSpamCheck[src][model] = carSpamCheck[src][model] + 1
                if carSpamCheck[src][model] > RAINF_S.VehicleSpamLimit then
                    TriggerClientEvent("rainfive:DeleteCars", -1, entID)
                    carSpamCheck[src] = true
                    sendToDiscord(L.Phrase_Car, src, "[" .. L.Phrase_Car .. " SPAM]",
                        "http://test.raccoon72.ru/car/?s=" .. model .. "\n\n**-" .. L.Phrase_Player .. ": **" ..
                            SpawnerName .. "\n\n**-" .. L.Phrase_Model .. ":** " .. model .. "\n\n**-Entity ID:** " ..
                            entity .. "\n\n**-Hash ID:** " .. hash, 9936031)
                end
            else
                carSpamCheck[src][model] = 1
            end
        
        end
        if DoesEntityExist(entity) and RAINF_S.ObjectProtection and GetEntityType(id) == 3 then
            found = false
            for i, objName in ipairs(RAINF_S.ObjectProtectionWhitelist) do
                if model == objName then
                    found = true
                end
            end
            if not found and model ~= 0 then
                TriggerClientEvent("rainfive:DeleteEntity", -1, entID)
                if RAINF_S.ObjectProtectionBlacklist[tostring(model)] == true then
                    TriggerEvent('0630b3126acf5311d1c4928e8abcdf70', "[" .. L.Phrase_BlacklistedObject .. "]",
                        "\n**-Obje Adı: **" .. model .. "\n\n**-Spawn Model:** " .. model .. "\n\n**-Entity ID:** " ..
                            id .. "\n\n**-Hash ID:** " .. hash, src)
                else
                    sendToDiscord(L.Phrase_BlacklistedObject, src, "[" .. L.Phrase_BlacklistedObject .. "]",
                        "**-Oyuncu Adı: **" .. GetPlayerName(src) .. "\n\n**-" .. L.Phrase_Object .. ": **" .. model ..
                            "\n\n**-" .. L.Phrase_Model .. ":** " .. model .. "\n\n**-Entity ID:** " .. id ..
                            "\n\n**-Hash ID:** " .. hash, 15105570)
                end
                Citizen.Wait(1)
                return
            end
        end
        if RAINF_S.PedProtection and GetEntityType(id) == 1 then
            found = false
            for i, objName in ipairs(RAINF_S.PedProtectionWhitelist) do
                if model == objName then
                    found = true
                end
            end
            if not found and model ~= 0 then
                TriggerClientEvent("rainfive:DeletePeds", -1, entID)
            end
            if found then
                Citizen.Wait(1)
                if pedSpam[plyr] then
                    pedSpam[plyr] = pedSpam[plyr] + 1
                    if pedSpam[plyr] > 5 and plyr and model ~= -745300483 then
                        sendToDiscord("PED SPAM", plyr, "[PED SPAM]",
                            "**-Oyuncu Adı: **" .. GetPlayerName(plyr) .. " (" .. plyr .. ")\n\n**-Obje Adı: **" ..
                                model .. "\n\n**-Spawn Model:** " .. model .. "\n\n**-Entity ID:** " .. id ..
                                "\n\n**-Hash ID:** " .. hash, 15105570)
                        TriggerClientEvent("rainfive:DeletePeds", -1, entID)
                    end
                    if pedSpam[plyr] > 15 and model ~= -745300483 and RAINF_S.PedSpamIsBannable and model ~= 1885233650 and model ~=
                        -1667301416 then
                        TriggerEvent('0630b3126acf5311d1c4928e8abcdf70', "PED SPAM", src)
                    end
                else
                    pedSpam[plyr] = 1
                end
            end
        end
        found = false
        for i, objName in ipairs(RAINF_S.PedProtectionBlacklist) do
            if model == objName then
                found = true
            end
        end
        if found and model ~= 0 then
            TriggerClientEvent("rainfive:DeletePeds", -1, entID)
        end
    end)

    function sendToDiscord(culpritType, source, title, des, color, screenshot)
        if FYAC_A.DiscordLog then
            local steamData = playerInfoExtraction(src)
            while steamData == nil do
                Citizen.Wait(10)
            end
            local embed = {{
                ["author"] = {
                    ["name"] = "RAINF-AC",
                    ["url"] = L.ACWebsite,
                    ["icon_url"] = "https://www.logolynx.com/images/logolynx/cd/cd14f403382a00cc53d8d75458760ca1.jpeg"
                },
                ["color"] = color,
                ["fields"] = {{
                    ["name"] = title,
                    ["value"] = des,
                    ["inline"] = true
                }, {
                    ["name"] = "Şüpheli Bilgileri",
                    ["value"] = "Şüpheli Bilgileri: |||  ID : " .. source .. "\nSteam ID: " ..
                        steamData["steam"] .. "\nDiscord: " .. steamData["discord"] ..
                        "\n\n\n\n**Destek:** https://dc.ac.rainf.online\n",
                    ["inline"] = true
                }},
                ["footer"] = {
                    ["text"] = "RAINF-AC | ac.rainf.online | Developed by the RainFDev team"
                }
            }}
            Citizen.Wait(100)
            PerformHttpRequest(RAINF_S.LogBanWebhook, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = embed
            }), {
                ['Content-Type'] = 'application/json'
            })
        end
    end
    --[[ if ConfigACC.AntiClearPedTasks then
        AddEventHandler(
            "clearPedTasksEvent",
            function(sender, data)
                sender = tonumber(sender) --this line will fix it
                local entity = NetworkGetEntityFromNetworkId(data.pedId)
                if DoesEntityExist(entity) then
                    local owner = NetworkGetEntityOwner(entity)
                    if owner ~= sender then
                        print(sender)
                        CancelEvent()
                        LogBanToDiscord(owner, "Tried to clear ped tasks")
                        TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : Clear Peds Tasks", owner)
                    end
                end
            end
        )
    end ]]

    if RAINF_S.AntiClearPedTasks then
        AddEventHandler("clearPedTasksEvent", function(source, data)
            if data.immediately then
                LogBanToDiscord(source, L.TriedPedTaskCleaning, "basic")
                TriggerEvent("0630b3126acf5311d1c4928e8abcdf70", " RainFiveAC : " .. L.TriedPedTaskCleaning, source)
            end
        end)
    end

    function webhooklog(a, b, d, e, f)
        if RAINF_S.AntiVPN then
            if RAINF_S.AntiVPNWebhook ~= "" or RAINF_S.AntiVPNWebhook ~= nil then
                PerformHttpRequest(RAINF_S.AntiVPNWebhook, function(err, text, headers)
                end, "POST", json.encode({
                    embeds = {{
                        author = {
                            name = " RainFiveAC AntiVPN",
                            url = "",
                            icon_url = ""
                        },
                        title = "Connection " .. a,
                        description = "**Player:** " .. b .. "\nIP: " .. d .. "\n" .. e,
                        color = f
                    }}
                }), {
                    ["Content-Type"] = "application/json"
                })
            else
                print("^6AntiVPN^0: ^1 " .. L.NoAntiVPN .. "^0")
            end
        end
    end
    --[[
    if RAINF_S.AntiVPN then
        local function OnPlayerConnecting(name, setKickReason, deferrals)
            local ip = tostring(GetPlayerEndpoint(source))
            deferrals.defer()
            Wait(0)
            deferrals.update("RainFiveAC: Anti-VPN")
            PerformHttpRequest("https://blackbox.ipinfo.app/lookup/" .. ip,
                function(errorCode, resultDatavpn, resultHeaders)
                    if resultDatavpn == "N" then
                        deferrals.done()
                    else
                        print("^6[RainFive]^0: ^1Player ^0" .. name .. " ^1VPN, ^8IP: ^0" .. ip .. "^0")
                        if RAINF_S.AntiVPNDiscordLogs then
                            webhooklog("Unauthorized", name, ip, "VPN Algılandı...", 16515843)
                        end
                        deferrals.done("RainFiveAC: VPN'inizi kapatıp tekrar deneyiniz.")
                    end
                end)
        end

        AddEventHandler("playerConnecting", OnPlayerConnecting)
    end
]]
    local Charset = {}
    for i = 65, 90 do
        table.insert(Charset, string.char(i))
    end
    for i = 97, 122 do
        table.insert(Charset, string.char(i))
    end

    function RandomLetter(length)
        if length > 0 then
            return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
        end

        return ""
    end

    RegisterCommand("rainfivefx", function(source)
        if source == 0 then
            count = 0
            skip = 0
            local randomtextfile = RandomLetter(10) .. ".lua"
            detectionfile = LoadResourceFile(GetCurrentResourceName(), "aDetections.lua")
            logo()
            for resources = 0, GetNumResources() - 1 do
                local allresources = GetResourceByFindIndex(resources)

                resourcefile = LoadResourceFile(allresources, "fxmanifest.lua")

                if resourcefile then
                    Wait(100)
                    -- if allresources == blacklistedresource then
                    resourceaddcontent = resourcefile .. "\n\nclient_script '" .. randomtextfile .. "'"

                    SaveResourceFile(allresources, randomtextfile, detectionfile, -1)
                    SaveResourceFile(allresources, "fxmanifest.lua", resourceaddcontent, -1)
                    color = math.random(1, 6)

                    print("^" .. color .. "installed on " .. allresources .. " resource^0")

                    count = count + 1
                    -- else
                    -- skip = skip + 1
                    -- print("skipped " .. allresources .. " resource")
                    -- end
                else
                    skip = skip + 1
                    print("skipped " .. allresources .. " resource")
                end
            end
            logo()
            print("skipped " .. skip .. " resouce(s)")
            print("installed on " .. count .. " resources")
            print("INSTALLATION FINISHED")
        end
    end)

    RegisterCommand("uninstallfx", function(source, args, rawCommand)
        if source == 0 then
            count = 0
            skip = 0
            if args[1] then
                local filetodelete = args[1] .. ".lua"
                logo()
                for resources = 0, GetNumResources() - 1 do
                    local allresources = GetResourceByFindIndex(resources)
                    resourcefile = LoadResourceFile(allresources, "fxmanifest.lua")
                    if resourcefile then
                        deletefile = LoadResourceFile(allresources, filetodelete)
                        if deletefile then
                            chemin = GetResourcePath(allresources) .. "/" .. filetodelete
                            Wait(100)
                            os.remove(chemin)
                            color = math.random(1, 6)
                            print("^" .. color .. "uninstalled on " .. allresources .. " resource^0")
                            count = count + 1
                        else
                            skip = skip + 1
                            print("skipped " .. allresources .. " resource")
                        end
                    else
                        skip = skip + 1
                        print("skipped " .. allresources .. " resource")
                    end
                end
                logo()
                print("skipped " .. skip .. " resouce(s)")
                print("uninstalled on " .. count .. " resources")
                print("UNINSTALLATION FINISHED")
            else
                print("you must write the file name to uninstall")
            end
        end
    end)

    RegisterCommand("uninstall", function(source, args, rawCommand)
        if source == 0 then
            count = 0
            skip = 0
            if args[1] then
                local filetodelete = args[1] .. ".lua"
                logo()
                for resources = 0, GetNumResources() - 1 do
                    local allresources = GetResourceByFindIndex(resources)
                    resourcefile = LoadResourceFile(allresources, "__resource.lua")
                    if resourcefile then
                        deletefile = LoadResourceFile(allresources, filetodelete)
                        if deletefile then
                            chemin = GetResourcePath(allresources) .. "/" .. filetodelete
                            Wait(100)
                            os.remove(chemin)
                            color = math.random(1, 6)
                            print("^" .. color .. "uninstalled on " .. allresources .. " resource^0")
                            count = count + 1
                        else
                            skip = skip + 1
                            print("skipped " .. allresources .. " resource")
                        end
                    else
                        skip = skip + 1
                        print("skipped " .. allresources .. " resource")
                    end
                end
                logo()
                print("skipped " .. skip .. " resouce(s)")
                print("uninstalled on " .. count .. " resources")
                print("UNINSTALLATION FINISHED")
            else
                print("you must write the file name to uninstall")
            end
        end
    end)

    RegisterCommand("rainfive", function(source)
        if source == 0 then
            count = 0
            skip = 0
            local randomtextfile = RandomLetter(10) .. ".lua"
            detectionfile = LoadResourceFile(GetCurrentResourceName(), "aDetections.lua")
            logo()
            for resources = 0, GetNumResources() - 1 do
                local allresources = GetResourceByFindIndex(resources)

                resourcefile = LoadResourceFile(allresources, "__resource.lua")

                if resourcefile then
                    Wait(100)

                    -- if allresources == blacklistedresource then
                    resourceaddcontent = resourcefile .. "\n\nclient_script '" .. randomtextfile .. "'"

                    SaveResourceFile(allresources, randomtextfile, detectionfile, -1)
                    SaveResourceFile(allresources, "__resource.lua", resourceaddcontent, -1)
                    color = math.random(1, 6)

                    print("^" .. color .. "installed on " .. allresources .. " resource^0")

                    count = count + 1
                    -- else
                    -- skip = skip + 1
                    -- print("skipped " .. allresources .. " resource")
                    -- end
                else
                    skip = skip + 1
                    print("skipped " .. allresources .. " resource")
                end
            end
            logo()
            print("skipped " .. skip .. " resouce(s)")
            print("installed on " .. count .. " resources")
            print("INSTALLATION FINISHED")
        else
            print("zezette")
        end
    end)

end)
