local M = {}

function M.config()
	require('formatter').setup({
		logging = false,
		filetype = {
			c = {
				function ()
					return {
						exe =  'clang-format',
						args = { '--style=file' },
						stdin = true
					}
				end
			}
		}
	})
end

return M
