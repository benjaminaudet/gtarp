resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page 'html_bank/ui.html'
files {
	'html_bank/ui.html',
	'html_bank/pricedown.ttf',
	'html_bank/bank-icon.png',
	'html_bank/logo.png',
	'html_bank/cursor.png',
	'html_bank/styles.css',
	'html_bank/scripts.js',
	'html_bank/debounce.min.js'
}

client_script "cl_bank.lua"
server_script "sv_bank.lua"
