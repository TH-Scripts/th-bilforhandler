fx_version 'cerulean'

game 'gta5'

author 'TH-Development'
version '1.0'

lua54 'yes'

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua',
    '@oxmysql/lib/MySQL.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

dependencies {
    'ox_lib'
}