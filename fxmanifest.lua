fx_version 'bodacious'
game 'gta5'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "configs/config_sv.lua",
    'locales/server.lua',
    "configs/config_cl.lua",
    "server.lua",
    "tProtect.js"
}

client_scripts {
    "configs/config_cl.lua",
    "aDetections.lua",
    "client.lua",
}
