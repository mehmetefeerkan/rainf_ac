--
RAINF_S = nil
TriggerEvent('rainf:getServerConfig', function(obj)
    RAINF_S = obj
end)
local L = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

local localechoice = RAINF_S.Locale or "tr"
-- local localesAddress = "https://raw.githubusercontent.com/mehmetefeerkan/rainf-ac-locales/main/" .. localechoice .. "/main.lua"
local localesAddress =
    "https://raw.githubusercontent.com/mehmetefeerkan/rainf-ac-locales/811bcdbb09e07ddc52618950f97081b6eb745692/tr/main.lua"

Citizen.CreateThread(function()
    local data = nil
    local statc = nil
    PerformHttpRequest(localesAddress, function(errorCode, resultData, resultHeaders)
        data = resultData
        statc = errorCode
    end)
    Citizen.Wait(1000)
    if (statc < 201) and (statc ~= nil) then
        load(data)()
        print(data)
    else
        print("Locales Loaded.")

        local L = {}

        RegisterServerEvent('rainf:getlocales')
        AddEventHandler('rainf:getlocales', function(obj)
            obj(L)
        end)
        local lala = L
        RegisterServerEvent('rainf:gimmeLocales')
        AddEventHandler('rainf:gimmeLocales', function()
            local src = source
            TriggerClientEvent('rainf:recieveLocales', src, lala)
        end)
        L.NoLogBanWebhook = "LogBanWebhook config ayarı bulunamadı. "
        L.NoServerName = "ServerName config ayarı bulunamadı. "
        L.NoModelsLogWebhook = "ModelsLogWebhook config ayarı bulunamadı. "
        L.NoExplosionLogWebhook = "ExplosionLogWebhook config ayarı bulunamadı. "
        L.NoAntiVPN = "AntiVPN config ayarı bulunamadı. "
        L.NoAntiVPNDiscordLogs = "AntiVPNDiscordLogs config ayarı bulunamadı. "
        L.NoAntiSpectate = "AntiSpectate config ayarı bulunamadı. "
        L.NoAntiResourceStart = "AntiResourceStart config ayarı bulunamadı. "
        L.NoAntiResourceStop = "AntiResourceStop config ayarı bulunamadı. "
        L.NoAntiResourceRestart = "AntiResourceRestart config ayarı bulunamadı. "
        L.NoResourceCount = "ResourceCount config ayarı bulunamadı. "
        L.NoAntiInjection = "AntiInjection config ayarı bulunamadı. "
        L.NoWeaponProtection = "WeaponProtection config ayarı bulunamadı. "
        L.NoTriggersProtection = "TriggersProtection config ayarı bulunamadı. "
        L.NoGiveWeaponsProtection = "GiveWeaponsProtection config ayarı bulunamadı. "
        L.NoExplosionProtection = "ExplosionProtection config ayarı bulunamadı. "
        L.NoAntiClearPedTask = "AntiClearPedTask config ayarı bulunamadı. "
        L.NoBanBlacklistedWeapon = "BanBlacklistedWeapon config ayarı bulunamadı. "
        L.NoBlacklistedCommands = "BlacklistedCommands config ayarı bulunamadı. "
        L.NoBlockedExplosions = "BlockedExplosions config ayarı bulunamadı. "
        L.NoBlacklistedWords = "BlacklistedWords config ayarı bulunamadı. "
        L.NoBlacklistedWeapons = "BlacklistedWeapons config ayarı bulunamadı. "
        L.NoBlacklistedModels = "BlacklistedModels config ayarı bulunamadı. "
        L.NoWhitelistedProps = "WhitelistedProps config ayarı bulunamadı. "
        L.NoBlacklistedEvents = "BlacklistedEvents config ayarı bulunamadı. "
        L.BanReason_Speedhack = "Hız hilesi - noclip? "
        L.BanReason_Invisibility = "Abi görüntün yok"
        L.BanReason_CheatEngine = "Cheat Engine"
        L.BanReason_HealthHack = "Sağlık hilesi? "
        L.PlayerConnecting = "ID'li oyuncu bağlanıyor. "
        L.UnBanned = "Oyuncunun banı kaldırıldı. "
        L.PlayerWasBanned = "Bir oyuncu banlandı. "
        L.TriedPedTaskCleaning = "BlacklistedEvents config ayarı bulunamadı. "
        L.TriedToSpawn = "Spawnlamaya çalıştı  : "
        L.PreventedBlacklistProp = "Blacklist prop spawnlamaya çalıştı : "
        L.PreventedThatTrigger = "Bu triggerın çalıştırılmasına engel oldum : "
        L.CensoredThat = "Söylemeye çalıştı : "
        L.DevelopedBy = "RAINF Gelistirici Ekibi tarafindan gelistirilmistir. "
        L.VerificationPassed = "Anticheat Lisansı Onaylandı. "
        L.Integrity = "RAINF-AC'ye ait tüm sistemler aktif - başlatma başarılı. "
        L.BanlistActive = "Global Banlist Aktif. "
        L.TriggerScan = "Trigger Kontrolü Gerçekleştiriliyor... "
        L.ACWebsite = "https://ac.rainf.online"
        L.NormalExplosionAttempt = "Karalistedeki bir patlamayı tetikledi. Tip : "
        L.BannedByRainFive = "Bu sunucudan hile yaptığınız için uzaklaştırılmış bulunmaktasınız. "
        L.MassExplosionAttempt = "Bir sürü patlamayı tetikledi. Tip : "
        L.GasPumpMishap = "Gaz pompası patlaması tetikledi. "
        L.SilentExplosionAttempt = "Sessiz patlatma tetikledi. Tip : "
        L.HiddenExplosionAttempt = "Görünmez patlatma tetikledi. Tip : "
        L.WhatTheFuckExplosion = "Oneshot patlama yapmaya çalıştı. Tip : "
        L.AttemptedWeaponGive = "Birine silah vermeyi denedi. "
        L.AttemptedWeaponRemove = "Silah kaldırmayı denedi. "
        L.AttemptedWeaponRemoveAll = "Birinden tüm silahları kaldırmayı denedi. "
        L.InsufficientPermsForTrigger = "Yetersiz perm veya meslek yetkisiyle bir trigger çalıştırmayı denedi : "
        L.EndingECS = "İzinsiz kamu servisi triggerı çalıştırıldı. Herkesin kamu servisi bitiriliyor."
        L.DelayedLaunch = "Konfigürasyonda birkaç sorun tespit edildi.\nBu sorunları çözmediğiniz takdirde AC stabil çalışmayabilir. AC 10 Saniye içinde devreye girecektir."
        L.CallbackLimitExceeded = "Özel callback/trigger spam limiti aşıldı. Son kullanılan callback/event: "
        L.Phrase_BlacklistedVehicle = "Yasaklı Araç"
        L.Phrase_BlacklistedObject = "Yasaklı Obje"
        L.Phrase_Player = "Oyuncu"
        L.Phrase_Object = "Obje"
        L.Phrase_Model = "Model"
        L.Phrase_Car = "Araba"
    end

end)
