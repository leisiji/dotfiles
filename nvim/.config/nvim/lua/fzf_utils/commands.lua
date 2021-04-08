local M = {}
local rg = require('fzf_utils.rg')

function M.load_command(arg1, arg2)
	if arg1 == nil then
		return
	elseif arg1 == "--all-buffers" then
		rg.search_all_buffers(arg2)
		return
	end

	rg.search_path(arg1, arg2)
end

return M
