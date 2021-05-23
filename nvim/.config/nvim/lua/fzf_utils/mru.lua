local M = {}
local fn = vim.fn
local a = require('plenary.async_lib')
local u = require('fzf_utils.utils')
local mru = string.format('%s/%s', fn.stdpath('cache'), 'fzf_mru')

local add_file = a.async_void(function (f)
	local data = await(u.readfile(mru))
	local items = vim.split(data, "\n")
end)

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
