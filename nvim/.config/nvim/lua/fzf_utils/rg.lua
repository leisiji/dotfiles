local fzf = require('fzf').fzf
local fn = vim.fn
local M = {}
local utils = require('fzf_utils.utils')

-- filename:row:col:xxxx
local function parse_vimgrep(str)
	return {string.match(str, "(.-):(%d+):(%d+):.*")}
end

local shell = require('fzf.actions').action(function(selections, fzf_preview_lines, _)
	local parsed_content = parse_vimgrep(selections[1])
	return utils.preview_lines(parsed_content[1], parsed_content[2], fzf_preview_lines)
end)

local function rg_fzf(pattern, dir)
	coroutine.wrap(function ()
		local rgcmd = "rg -w --vimgrep --no-heading --color ansi " .. fn.shellescape(pattern)

		if type(dir) == "string" then
			rgcmd = rgcmd .. ' ' .. dir
		end

		local choices = fzf(rgcmd, "--preview="..shell)
		if not choices then return end

		local parsed_content = parse_vimgrep(choices[1])
		local filename = parsed_content[1]
		local row = parsed_content[2]
		local col = parsed_content[3]
		utils.tabedit(filename, tonumber(row), tonumber(col) - 1)
	end)()
end

function M.search_path(pattern, path)
	rg_fzf(pattern, path)
end

return M
