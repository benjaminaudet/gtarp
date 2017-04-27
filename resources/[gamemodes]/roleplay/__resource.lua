resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Bank

ui_page 'bank/html_bank/ui.html'
files {
	'bank/html_bank/ui.html',
	'bank/html_bank/pricedown.ttf',
	'bank/html_bank/bank-icon.png',
	'bank/html_bank/logo.png',
	'bank/html_bank/cursor.png',
	'bank/html_bank/styles.css',
	'bank/html_bank/scripts.js',
	'bank/html_bank/debounce.min.js'
}

client_script "bank/cl_bank.lua"
server_script "bank/sv_bank.lua"

-- Position Saver

server_script 'position_saver/sv_position_saver.lua'
client_script 'position_saver/cl_position_saver.lua'

-- Never Wanted

client_script 'never_wanted/nowanted.lua'

-- es_admin

dependency 'essentialmode'

client_script 'es_admin/cl_admin.lua'
server_script 'es_admin/sv_admin.lua'

-- Hands up

client_script 'hands_up/cl_hands_up.lua'

-- Garages

client_script 'garages/cl_garage.lua'
server_script 'garages/sv_garage.lua'

-- Voip

client_script 'voip/cl_voip.lua'
server_script 'voip/sv_voip.lua'

-- Car HUD

client_script 'carhud/carhud.lua'