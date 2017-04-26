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
