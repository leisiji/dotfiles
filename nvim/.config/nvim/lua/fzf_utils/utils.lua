local M = {}
local fn = vim.fn
_G.PREVIEW_LINE_NUMS = 17

function M.get_leading_num(str)
	return string.match(str, "%d+")
end

local function preview_lines(path, line, max)
	local start_line = 0
	local end_line = max
	if line - PREVIEW_LINE_NUMS > 0 then
		start_line = line - PREVIEW_LINE_NUMS
	end
	if (line + PREVIEW_LINE_NUMS < end_line) then
		end_line = line + PREVIEW_LINE_NUMS
	end

	local cmd = string.format("bat --theme gruvbox-dark -H %i --color always --style numbers --pager never -r %i:%i %s",
				line, start_line, end_line, path, start_line)
	return fn.system(cmd)
end

function M.get_preview_action(path, max_line)
	local shell = require('fzf.actions').action(function(selections, _, _)
		if selections ~= nil then
			local line_nr = tonumber(M.get_leading_num(selections[1]))
			return preview_lines(path, line_nr, max_line)
		end
	end)
	return shell
end

function M.tabedit(path)
	local tabcmd = "keepj tab drop %s"
	vim.cmd(string.format(tabcmd, path))
	vim.wo.cul = true -- cursorline of terminal mode is default off
end

function M.vsplitedit(path)
	local tabcmd = "vsplit %s"
	vim.cmd(string.format(tabcmd, path))
end

return M
