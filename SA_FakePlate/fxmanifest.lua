fx_version 'adamant'

author 'SAIINITI#8638'

version '1.0'

game 'gta5'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua"
}


shared_scripts {
    'config/config.lua',
}

server_scripts {
    '@es_extended/locale.lua',
    'server/sv_fakeplate.lua'
    
}

client_scripts {
    '@es_extended/locale.lua',
    'client/cl_fakeplate.lua'
    
}