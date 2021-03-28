local fzf = require('fzf').fzf
local action = require('fzf.actions').action
local fn = vim.fn
local api = vim.api
local M = {}

_G.PREVIEW_LINE_NUMS = 17

local function get_leading_num(s)
	return string.match(s, "%d+")
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

	local cmd = string.format("bat --theme gruvbox -H %i --color always --style numbers --pager never -r %i:%i %s",
				line, start_line, end_line, path, start_line)
	return fn.system(cmd)
end

function M.grep_lines()
	local max_line = fn.line('$')
	local path = fn.expand("%:p")

	coroutine.wrap(function()
		local shell = action(function(selections, _, _)
			local line_nr = tonumber(get_leading_num(selections[1]))
			if line_nr == nil then
				return ''
			end
			return preview_lines(path, line_nr, max_line)
		end)

		local choices = fzf("cat -n " .. path, "--reverse --tabstop=1 --nth=2.. --preview " .. shell)
		if not choices then return end

		vim.cmd(get_leading_num(choices[1]))
	end)()
end

function M.find_files()
	local FZF_CAHCE_FILES_DIR = fn.stdpath('cache') .. '/fzf_files/'
	local cur_dir = fn.getcwd()
	local format_cur_dir = fn.sha256(cur_dir)
	local cache_file = FZF_CAHCE_FILES_DIR .. format_cur_dir
	local command = ""
	local preview = "head {}"
	local modified_time = fn.getftime(cache_file)

	if (modified_time == -1) or (os.time() - modified_time > 604800) then -- refresh per week

		if fn.isdirectory(FZF_CAHCE_FILES_DIR) == 0  then
			fn.mkdir(FZF_CAHCE_FILES_DIR)
		end

		local file = io.open(cache_file, "a")
		io.close(file)
		command = "fd -t f -L | tee " .. cache_file
	else
		command = "cat " .. cache_file
	end

	coroutine.wrap(function ()
		local choices = fzf(command,
				("--ansi --preview=%s --expect=ctrl-s,ctrl-t,ctrl-v,ctrl-r --multi"):format(fn.shellescape(preview)))

		if not choices then return end

		local vimcmd
		if choices[1] == "ctrl-t" then
			vimcmd = "tabnew"
		elseif choices[1] == "ctrl-v" then
			vimcmd = "vnew"
		elseif choices[1] == "ctrl-r" then
			os.remove(cache_file)
		else
			vimcmd = "e"
		end

		if vimcmd ~= nil then
			for i=2,#choices do
				vim.cmd(vimcmd .. " " .. fn.fnameescape(choices[i]))
			end
		else
			vim.schedule(M.find_files)
		end
	end)()
end

function M.buffers()
	coroutine.wrap(function ()
		local items = {}
		for _, bufhandle in ipairs(api.nvim_list_bufs()) do
			if api.nvim_buf_is_loaded(bufhandle) then
				local name = fn.bufname(bufhandle)
				if #name ~= 0 then
					table.insert(items, name)
				end
			end
		end
		local choices = fzf(items, nil)
		if choices then
			vim.cmd("keepj tab drop "..choices[1])
		end
	end)()
end

function M.Man()
	coroutine.wrap(function ()
		local choices = fzf("man -k .", "--tiebreak begin --nth 1,2")
		if choices then
			local split_items = vim.split(choices[1], " ")
			local manpagename = split_items[1]
			local chapter = string.match(split_items[2], "%((.+)%)")
			local cmd = string.format("vertical Man %s %s", chapter, manpagename)
			vim.cmd(cmd)
		end
	end)()
end


return M
