
local fzf = require('fzf').fzf
local action = require('fzf.actions').action
local utils = require('nvim_fzf_commands.utils')

local M = {}

function M.grep_lines()

	coroutine.wrap(function()
		-- items is a table of selected or hovered fzf items
		--local shell = action(function(items, fzf_lines, fzf_cols)
		--	local line_nr = tonumber(items[1])

		--	-- you can return either a string or a table to show in the preview
		--	-- window
		--	return vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		--end)

		local choices = fzf("cat -n "..vim.fn.expand("%:p"), "--nth=2 ")
		if not choices then return end

		print(utils.get_leading_num(choices[1]))
	end)()
end

function M.grep_dir()
end


return M
