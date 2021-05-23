local M = {}
local fn = vim.fn
local u = require('fzf_utils.utils')
local mru = string.format('%s/%s', fn.stdpath('cache'), 'fzf_mru')

local function add_file(f)
	coroutine.wrap(function ()
		local data = u.readfile(mru)
		local items = vim.split(data, "\n")
	end)()
end

function _G.refresh_mru()
	if fn.filereadable(mru) == 0 then
		local file = io.open(mru, "a")
		io.close(file)
	end

	local f = fn.expand('%:p')
	if fn.filereadable(f) then
		add_file(f)
	end
end

return M
