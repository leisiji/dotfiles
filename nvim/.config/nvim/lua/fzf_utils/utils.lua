local M = {}
local fn = vim.fn

function M.get_leading_num(str)
	return string.match(str, "%d+")
end

function M.preview_lines(path, line, fzf_preview_lines)
	local half_preview_lines = fzf_preview_lines / 2
	local start_line = line - half_preview_lines
	local end_line = line + half_preview_lines

	if start_line < 0 then
		start_line = 0
	end

	local cmd = string.format("bat --theme gruvbox-dark -H %i --color always --style numbers --pager never -r %i:%i %s",
				line, start_line, end_line, path)
	return fn.system(cmd)
end

-- get preview action that has result starting with line number
function M.get_preview_action(path)
	local shell = require('fzf.actions').action(function(selections, fzf_preview_lines, _)
		if selections ~= nil then
			local line_nr = tonumber(M.get_leading_num(selections[1]))
			return M.preview_lines(path, line_nr, fzf_preview_lines)
		end
	end)
	return shell
end

function M.tabedit(path, row, col)
	local tabcmd = "keepj tab drop %s"
	vim.cmd(string.format(tabcmd, path))
	if col ~= nil and row ~= nil then
		vim.api.nvim_win_set_cursor(0, {row, col})
		vim.cmd("normal! zz")
	end
	vim.wo.cul = true
end

function M.vsplitedit(path)
	local tabcmd = "vsplit %s"
	vim.cmd(string.format(tabcmd, path))
end

return M
