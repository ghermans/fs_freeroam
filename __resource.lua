resource_type 'gametype' { name = 'fs_freeroam'}

description 'FiveM fs_freeroam'

-- Manifest
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Requiring essentialmode
dependency 'essentialmode'

-- General
client_scripts {
  'lib/Translator.lua',
  'lib/Drawing.lua',
  'lib/GameIO.lua',
  'config.lua',
  'locales/fr.lua',
  'locales/en.lua',
  'locales/pt.lua',
  'lib/i18nMenu.lua',
  'client.lua',
  'events/airport.lua',
  'jobs/fleecaJob.lua',
  'events/train.lua',
  'player/map.lua',
  'player/scoreboard.lua',
  'player/apartments.lua',
  'stores/stripclub.lua',
  'stores/vehshop.lua',
  'stores/smoke.lua',
  'jobs/towjob.lua',
  'minigames/moneytruck.lua',
  'bin/System.Xml.net.dll',
  'bin/NativeUI.net.dll',
  'bin/ShopMenu.net.dll',
  'stores/weapons.lua',
  'stores/general.lua',
}


server_scripts {
  'config.lua',
  'database_config.lua',
  'db/CouchDB/couch.lua',
  'server.lua',
  'player/commands.lua',
  'stores/vehshop_s.lua',
}

files('bin/Resources/weapons.xml')
weaponfile('bin/Resources/weapons.xml')
