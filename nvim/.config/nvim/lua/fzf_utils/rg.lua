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

local function get_rg_cmd(pattern, dir)
	local rgcmd = "rg -w --vimgrep --no-heading --color ansi " .. fn.shellescape(pattern)

	if type(dir) == "string" then
		rgcmd = rgcmd .. ' ' .. dir
	elseif type(dir) == "table" then
		for _,val in ipairs(dir) do
			rgcmd = rgcmd .. ' ' .. val
		end
	end

	return rgcmd
end

local function deal_with_rg_results(result)
	local parsed_content = parse_vimgrep(result)
	local filename = parsed_content[1]
	local row = parsed_content[2]
	local col = parsed_content[3]
	utils.tabedit(filename, tonumber(row), tonumber(col) - 1)
end

local function get_all_buffers(pattern)
	local api = vim.api
	local buffers = {}
	local count = 1
	for _, bufhandle in ipairs(api.nvim_list_bufs()) do
		if api.nvim_buf_is_loaded(bufhandle) and fn.buflisted(bufhandle) == 1 then
			local name = fn.bufname(bufhandle)
			buffers[count] = name
			count = count + 1
		end
	end
	return get_rg_cmd(pattern, buffers)
end

function M.search_path(pattern, path)
	coroutine.wrap(function ()
		local choices = fzf(get_rg_cmd(pattern, path), "--preview="..shell)
		if not choices then return end
		deal_with_rg_results(choices[1])
	end)()
end

function M.search_all_buffers(pattern)
	coroutine.wrap(function ()
		local choices = fzf(get_all_buffers(pattern), "--preview="..shell)
		if choices ~= nil then
			deal_with_rg_results(choices[1])
		end
	end)()
end

return M
