local fzf = require('fzf').fzf
local utils = require('fzf_utils.utils')
local fn = vim.fn
local api = vim.api
local M = {}

function M.grep_lines()
	local max_line = fn.line('$')
	local path = fn.expand("%:p")

	coroutine.wrap(function()
		local choices = fzf("cat -n " .. path, "--reverse --tabstop=1 --nth=2.. --preview "
						.. utils.get_preview_action(path, max_line))
		if choices ~= nil then
			vim.cmd(utils.get_leading_num(choices[1]))
		end

	end)()
end

function M.find_files()
	local FZF_CAHCE_FILES_DIR = fn.stdpath('cache') .. '/fzf_files/'
	local cache_file = FZF_CAHCE_FILES_DIR .. fn.sha256(fn.getcwd())
	local command = "cat " .. cache_file
	local preview = "head {}"
	local modified_time = fn.getftime(cache_file)

	if (modified_time == -1) or (os.time() - modified_time > 604800) then -- refresh per week

		if fn.isdirectory(FZF_CAHCE_FILES_DIR) == 0  then
			fn.mkdir(FZF_CAHCE_FILES_DIR)
		end

		local file = io.open(cache_file, "a")
		io.close(file)
		command = "fd -t f -L | tee " .. cache_file
	end

	coroutine.wrap(function ()
		local choices = fzf(command,
				("--preview=%s --expect=ctrl-s,ctrl-t,ctrl-v,ctrl-r"):format(fn.shellescape(preview)))

		if not choices then return end

		local file = fn.fnameescape(choices[2])

		if choices[1] == "ctrl-t" then
			utils.tabedit(file)
		elseif choices[1] == "ctrl-v" then
			utils.vsplitedit(file)
		elseif choices[1] == "ctrl-r" then
			os.remove(cache_file)
			vim.schedule(M.find_files)
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
			utils.tabedit(choices[1])
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
