fx_version 'cerulean'

game 'gta5'

author 'DRC Scripts'
description 'DRC BODYCAM'

version '1.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua',
}
client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
    '@oxmysql/lib/MySQL.lua',
}

files {
    "html/**.**",
    'locales/*.json'
}

ui_page "html/ui.html"

escrow_ignore {
    'shared/*.lua',
    'client/cl_Utils.lua',
    'server/sv_Utils.lua',
}
