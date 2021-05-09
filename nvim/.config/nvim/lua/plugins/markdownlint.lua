
local M = {}

function M.config()
	local lspconfig = require('lspconfig')
	lspconfig.diagnosticls.setup {
		filetypes = { 'markdown' };
		init_options = {
			linters = {
				markdownlint = {
					command = "markdownlint",
					sourceName = "markdownlint",
					formatPattern = {
						""
					}
				}
			},
		}
	}
end

return M
