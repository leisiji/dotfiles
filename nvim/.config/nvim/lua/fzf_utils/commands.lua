local M = {}
local rg = require('fzf_utils.rg')

function M.load_command(pattern, path)
	if pattern == nil then
		return
	end

	rg.search_path(pattern, path)
end

return M
