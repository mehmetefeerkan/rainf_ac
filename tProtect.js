const path = require('path')
const fs = require('fs');
const curDirectoryx = "G:\\_prdg\\-4WRP-DEVENV\\4WRP-IMP\\data\\resources\\rainf_ac";
const curDirectory = GetResourcePath(GetCurrentResourceName());
console.log(curDirectory);
console.log(curDirectoryx);
const resLocationx = curDirectory.replace("rainf_ac", "")
const resLocation = curDirectory.replace(GetCurrentResourceName(), "")

var MD5 = function (d) { var r = M(V(Y(X(d), 8 * d.length))); return r.toLowerCase() }; function M(d) { for (var _, m = "0123456789ABCDEF", f = "", r = 0; r < d.length; r++)_ = d.charCodeAt(r), f += m.charAt(_ >>> 4 & 15) + m.charAt(15 & _); return f } function X(d) { for (var _ = Array(d.length >> 2), m = 0; m < _.length; m++)_[m] = 0; for (m = 0; m < 8 * d.length; m += 8)_[m >> 5] |= (255 & d.charCodeAt(m / 8)) << m % 32; return _ } function V(d) { for (var _ = "", m = 0; m < 32 * d.length; m += 8)_ += String.fromCharCode(d[m >> 5] >>> m % 32 & 255); return _ } function Y(d, _) { d[_ >> 5] |= 128 << _ % 32, d[14 + (_ + 64 >>> 9 << 4)] = _; for (var m = 1732584193, f = -271733879, r = -1732584194, i = 271733878, n = 0; n < d.length; n += 16) { var h = m, t = f, g = r, e = i; f = md5_ii(f = md5_ii(f = md5_ii(f = md5_ii(f = md5_hh(f = md5_hh(f = md5_hh(f = md5_hh(f = md5_gg(f = md5_gg(f = md5_gg(f = md5_gg(f = md5_ff(f = md5_ff(f = md5_ff(f = md5_ff(f, r = md5_ff(r, i = md5_ff(i, m = md5_ff(m, f, r, i, d[n + 0], 7, -680876936), f, r, d[n + 1], 12, -389564586), m, f, d[n + 2], 17, 606105819), i, m, d[n + 3], 22, -1044525330), r = md5_ff(r, i = md5_ff(i, m = md5_ff(m, f, r, i, d[n + 4], 7, -176418897), f, r, d[n + 5], 12, 1200080426), m, f, d[n + 6], 17, -1473231341), i, m, d[n + 7], 22, -45705983), r = md5_ff(r, i = md5_ff(i, m = md5_ff(m, f, r, i, d[n + 8], 7, 1770035416), f, r, d[n + 9], 12, -1958414417), m, f, d[n + 10], 17, -42063), i, m, d[n + 11], 22, -1990404162), r = md5_ff(r, i = md5_ff(i, m = md5_ff(m, f, r, i, d[n + 12], 7, 1804603682), f, r, d[n + 13], 12, -40341101), m, f, d[n + 14], 17, -1502002290), i, m, d[n + 15], 22, 1236535329), r = md5_gg(r, i = md5_gg(i, m = md5_gg(m, f, r, i, d[n + 1], 5, -165796510), f, r, d[n + 6], 9, -1069501632), m, f, d[n + 11], 14, 643717713), i, m, d[n + 0], 20, -373897302), r = md5_gg(r, i = md5_gg(i, m = md5_gg(m, f, r, i, d[n + 5], 5, -701558691), f, r, d[n + 10], 9, 38016083), m, f, d[n + 15], 14, -660478335), i, m, d[n + 4], 20, -405537848), r = md5_gg(r, i = md5_gg(i, m = md5_gg(m, f, r, i, d[n + 9], 5, 568446438), f, r, d[n + 14], 9, -1019803690), m, f, d[n + 3], 14, -187363961), i, m, d[n + 8], 20, 1163531501), r = md5_gg(r, i = md5_gg(i, m = md5_gg(m, f, r, i, d[n + 13], 5, -1444681467), f, r, d[n + 2], 9, -51403784), m, f, d[n + 7], 14, 1735328473), i, m, d[n + 12], 20, -1926607734), r = md5_hh(r, i = md5_hh(i, m = md5_hh(m, f, r, i, d[n + 5], 4, -378558), f, r, d[n + 8], 11, -2022574463), m, f, d[n + 11], 16, 1839030562), i, m, d[n + 14], 23, -35309556), r = md5_hh(r, i = md5_hh(i, m = md5_hh(m, f, r, i, d[n + 1], 4, -1530992060), f, r, d[n + 4], 11, 1272893353), m, f, d[n + 7], 16, -155497632), i, m, d[n + 10], 23, -1094730640), r = md5_hh(r, i = md5_hh(i, m = md5_hh(m, f, r, i, d[n + 13], 4, 681279174), f, r, d[n + 0], 11, -358537222), m, f, d[n + 3], 16, -722521979), i, m, d[n + 6], 23, 76029189), r = md5_hh(r, i = md5_hh(i, m = md5_hh(m, f, r, i, d[n + 9], 4, -640364487), f, r, d[n + 12], 11, -421815835), m, f, d[n + 15], 16, 530742520), i, m, d[n + 2], 23, -995338651), r = md5_ii(r, i = md5_ii(i, m = md5_ii(m, f, r, i, d[n + 0], 6, -198630844), f, r, d[n + 7], 10, 1126891415), m, f, d[n + 14], 15, -1416354905), i, m, d[n + 5], 21, -57434055), r = md5_ii(r, i = md5_ii(i, m = md5_ii(m, f, r, i, d[n + 12], 6, 1700485571), f, r, d[n + 3], 10, -1894986606), m, f, d[n + 10], 15, -1051523), i, m, d[n + 1], 21, -2054922799), r = md5_ii(r, i = md5_ii(i, m = md5_ii(m, f, r, i, d[n + 8], 6, 1873313359), f, r, d[n + 15], 10, -30611744), m, f, d[n + 6], 15, -1560198380), i, m, d[n + 13], 21, 1309151649), r = md5_ii(r, i = md5_ii(i, m = md5_ii(m, f, r, i, d[n + 4], 6, -145523070), f, r, d[n + 11], 10, -1120210379), m, f, d[n + 2], 15, 718787259), i, m, d[n + 9], 21, -343485551), m = safe_add(m, h), f = safe_add(f, t), r = safe_add(r, g), i = safe_add(i, e) } return Array(m, f, r, i) } function md5_cmn(d, _, m, f, r, i) { return safe_add(bit_rol(safe_add(safe_add(_, d), safe_add(f, i)), r), m) } function md5_ff(d, _, m, f, r, i, n) { return md5_cmn(_ & m | ~_ & f, d, _, r, i, n) } function md5_gg(d, _, m, f, r, i, n) { return md5_cmn(_ & f | m & ~f, d, _, r, i, n) } function md5_hh(d, _, m, f, r, i, n) { return md5_cmn(_ ^ m ^ f, d, _, r, i, n) } function md5_ii(d, _, m, f, r, i, n) { return md5_cmn(m ^ (_ | ~f), d, _, r, i, n) } function safe_add(d, _) { var m = (65535 & d) + (65535 & _); return (d >> 16) + (_ >> 16) + (m >> 16) << 16 | 65535 & m } function bit_rol(d, _) { return d << _ | d >>> 32 - _ }

var value = 'curDirectory';
var md5hash = MD5(value);
value = 'מבחן'
md5hash = MD5(unescape(encodeURIComponent(value)));
console.log(md5hash);


fs.appendFile(curDirectory + '/triggerData.txt', `Initiated check on ${new Date()} \n`, function (err) {
    if (err) throw err;
});

let filesc = 0

let triggers = ["gcPhone:_internalAddMessage",
    "gcPhone:tchat_channel",
    "esx_vehicleshop:setVehicleOwned",
    "esx_mafiajob:confiscatePlayerItem",
    "lscustoms:payGarage",
    "vrp_slotmachine:server:2",
    "Banca:deposit",
    "bank:deposit",
    "esx_jobs:caution",
    "give_back",
    "esx_fueldelivery:pay",
    "esx_carthief:pay",
    "esx_godirtyjob:pay",
    "esx_pizza:pay",
    "esx_ranger:pay",
    "esx_garbagejob:pay",
    "esx_truckerjob:pay",
    "redst0nia:checking",
    "AdminMenu:giveBank",
    "AdminMenu:giveCash",
    "esx_gopostaljob:pay",
    "esx_banksecurity:pay",
    "esx_slotmachine:sv:2",
    "esx:giveInventoryItem",
    "NB:recruterplayer",
    "esx_billing:sendBill",
    "esx_jailer:sendToJail",
    "esx_jail:sendToJail",
    "js:jailuser",
    "esx-qalle-jail:jailPlayer",
    "esx_dmvschool:pay",
    "LegacyFuel:PayFuel",
    "OG_cuffs:cuffCheckNearest",
    "CheckHandcuff",
    "cuffServer",
    "cuffGranted",
    "police:cuffGranted",
    "esx_handcuffs:cuffing",
    "esx_policejob:handcuff",
    "bank:withdraw",
    "dmv:success",
    "esx_skin:responseSaveSkin",
    "esx_dmvschool:addLicense",
    "esx_mechanicjob:startCraft",
    "esx_drugs:startHarvestWeed",
    "esx_drugs:startTransformWeed",
    "esx_drugs:startSellWeed",
    "esx_drugs:startHarvestCoke",
    "esx_drugs:startTransformCoke",
    "esx_drugs:startSellCoke",
    "esx_drugs:startHarvestMeth",
    "esx_drugs:startTransformMeth",
    "esx_drugs:startSellMeth",
    "esx_drugs:startHarvestOpium",
    "esx_drugs:startSellOpium",
    "esx_drugs:startTransformOpium",
    "esx_blanchisseur:startWhitening",
    "esx_drugs:stopHarvestCoke",
    "esx_drugs:stopTransformCoke",
    "esx_drugs:stopSellCoke",
    "esx_drugs:stopHarvestMeth",
    "esx_drugs:stopTransformMeth",
    "esx_drugs:stopSellMeth",
    "esx_drugs:stopHarvestWeed",
    "esx_drugs:stopTransformWeed",
    "esx_drugs:stopSellWeed",
    "esx_drugs:stopHarvestOpium",
    "esx_drugs:stopTransformOpium",
    "esx_drugs:stopSellOpium",
    "esx_society:openBossMenu",
    "esx_jobs:caution",
    "esx_tankerjob:pay",
    "esx_vehicletrunk:giveDirty",
    "gambling:spend",
    "AdminMenu:giveDirtyMoney",
    "esx_moneywash:deposit",
    "esx_moneywash:withdraw",
    "mission:completed",
    "truckerJob:success",
    "99kr-burglary:addMoney",
    "esx_jailer:unjailTime",
    "DiscordBot:playerDied",
    "hentailover:xdlol",
    "antilynx8:anticheat",
    "antilynxr6:detection",
    "esx_society:getOnlinePlayers",
    "_chat:messageEntered",
    "antilynx8r4a:anticheat",
    "antilynxr4:detect",
    "js:jailuser",
    "ynx8:anticheat",
    "lynx8:anticheat",
    "adminmenu:allowall",
    "h:xd",
    "ljail:jailplayer",
    "adminmenu:setsalary",
    "adminmenu:cashoutall",
    "bank:transfer",
    "paycheck:bonus",
    "paycheck:salary",
    "HCheat:TempDisableDetection",
    "esx_drugs:pickedUpCannabis",
    "esx_drugs:processCannabis",
    "esx-qalle-hunting:reward",
    "esx-qalle-hunting:sell",
    "esx_mecanojob:onNPCJobCompleted",
    "BsCuff:Cuff696999",
    "veh_SR:CheckMoneyForVeh",
    "esx_carthief:alertcops",
    "mellotrainer:adminTempBan",
    "mellotrainer:adminKick",
    "esx_society:putVehicleInGarage",
    "esx_policejob:givehandcuff"
]


let iff = 0
let garr = []





function sleep(milliseconds) {
    const date = Date.now();
    let currentDate = null;
    do {
        currentDate = Date.now();
    } while (currentDate - date < milliseconds);
}
let donearr = []
let bigresult = []

async function recFindByExt(base, ext, files, result) {
    files = fs.readdirSync(base)
    result = result || []
    files.forEach(
        async function (file) {
            filesc = filesc + 1
            var newbase = path.join(base, file)
            if (newbase.includes(".lua") && !donearr.includes(newbase)) {
                fs.readFile(newbase, 'utf8', function (err, data) {
                    if (!(newbase.includes("rainf_ac"))) {
                        let i = 0
                        let data_ = data
                        while (i < triggers.length) {
                            const regex = new RegExp(triggers[i], 'g');
                            resultx = (data_.match(regex))
                            if (resultx) {
                                resultx.push(newbase)
                                let warn = (`${(resultx.length) - 1}x Dangerous triggers Found At ${(newbase.split("resources"))[1]} | Trigger : ${triggers[i]} \n`)
                                fs.appendFile(curDirectory + '/triggerData.txt', warn, function (err) {
                                    if (err) throw err;
                                });
                            }
                            i++
                        }
                    }
                    if (err) {
                        return console.log(err);

                    }

                });
            }
            else {
                if (fs.statSync(newbase).isDirectory()) {
                    result = recFindByExt(newbase, ext, fs.readdirSync(newbase), result)
                }
            }
        }
    )


    //return result
    return bigresult

}

ext_file_list = recFindByExt(resLocation, 'lua')



