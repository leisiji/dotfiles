local M = {}

function M.init()
	require('formatter').setup({
		logging = false,
		filetype = {
			lua = {
				function()
					return {
						exe = "luafmt",
						args = {"--indent-count", 4, "--stdin"},
						stdin = true
					}
				end
			}
		}
	})
end

return M
