local M = {}

function M.config()
	local lspconfig = require('lspconfig')
	lspconfig.diagnosticls.setup {
		filetypes = { 'markdown' };
		init_options = {
			linters = {
				markdownlint = {
						command = 'markdownlint',
						rootPatterns = { '.git' },
						isStderr = true,
						debounce = 100,
						args = { '--stdin' },
						offsetLine = 0,
						offsetColumn = 0,
						sourceName = 'markdownlint',
						securities = {
							undefined = 'hint'
						},
						formatLines = 1,
						formatPattern = {
							'^.*:(\\d+)\\s+(.*)$',
							{
								line = 1,
								column = -1,
								message = 2,
							}
						}
				}
			},
			filetypes = {
				markdown = 'markdownlint',
			}
		},
	}
end

return M
