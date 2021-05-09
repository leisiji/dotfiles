local M = {}

local function gen_format_cfg(args)
	return {
		function ()
			return args
		end
	}
end

function M.config()
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
			},
			c = gen_format_cfg({
				exe = { "clang-format" },
				stdin = false
			}),
		}
	})
end

return M
