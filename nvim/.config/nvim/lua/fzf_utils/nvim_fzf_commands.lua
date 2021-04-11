local fzf = require('fzf').fzf
local utils = require('fzf_utils.utils')
local fn = vim.fn
local api = vim.api
local M = {}

function M.grep_lines()
	coroutine.wrap(function()
		local path = fn.expand("%:p")
		local col = fn.getcurpos()[3]
		local choices = fzf("cat -n " .. path, "--tabstop=1 --nth=2.. --expect=ctrl-v --preview=" .. utils.get_preview_action(path))
		local row = utils.get_leading_num(choices[2])

		if choices[1] == "ctrl-v" then
			utils.vsplitedit(path, row, col)
		else
			api.nvim_win_set_cursor(0, {row, col})
			vim.cmd("normal! zz")
		end
	end)()
end

function M.find_files()
	local FZF_CAHCE_FILES_DIR = fn.stdpath('cache') .. '/fzf_files/'
	local cache_file = FZF_CAHCE_FILES_DIR .. fn.sha256(fn.getcwd())
	local command = "cat " .. cache_file

	if fn.filereadable(cache_file) == 0 then

		if fn.isdirectory(FZF_CAHCE_FILES_DIR) == 0  then
			fn.mkdir(FZF_CAHCE_FILES_DIR)
		end

		local file = io.open(cache_file, "a")
		io.close(file)
		command = "fd -t f -L | tee " .. cache_file
	end

	coroutine.wrap(function ()
		local choices = fzf(command, "--expect=ctrl-v,ctrl-r,ctrl-t")

		if not choices then return end

		local file = fn.fnameescape(choices[2])

		if choices[1] == "ctrl-v" then
			utils.vsplitedit(file)
		elseif choices[1] == "ctrl-r" then
			os.remove(cache_file)
			vim.schedule(M.find_files)
		else
			utils.tabedit(file, nil, nil)
		end
	end)()
end

function M.buffers()
	coroutine.wrap(function ()
		local items = {}
		for _, bufhandle in ipairs(api.nvim_list_bufs()) do
			if api.nvim_buf_is_loaded(bufhandle) and fn.buflisted(bufhandle) == 1 then
				local name = fn.bufname(bufhandle)
				if #name ~= 0 then
					table.insert(items, name)
				end
			end
		end
		local choices = fzf(items, nil)
		if choices ~= nil then
			utils.tabedit(choices[1], nil, nil)
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
			vim.cmd(string.format("vertical Man %s %s", chapter, manpagename))
		end
	end)()
end

return M
