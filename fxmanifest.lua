fx_version 'cerulean'
game 'gta5'

-- Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- Resource Info
name 'Shower Script'
description 'Adds a shower functionality to your FiveM server.'
author 'Jeffrey'

server_scripts {
    '@es_extended/locale.lua',
    'server.lua',
    'config.lua',
}

client_scripts {
    '@es_extended/locale.lua',
    'client.lua',
    'config.lua',
}

-- Specify the files that should be included in the resource
files {
    'config.lua',
}

-- Client script should be loaded after ESX (if you're using it)
dependency 'es_extended'
