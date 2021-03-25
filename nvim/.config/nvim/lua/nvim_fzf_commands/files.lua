local M = {}
local fzf = require('fzf').fzf
local fn = vim.fn

local FZF_CAHCE_FILES_DIR = fn.expand("~/.cache/nvim/fzf_files/")

function M.find_files()
	local cur_dir = fn.getcwd()
	local format_cur_dir, _ = cur_dir:gsub("/", "_")
	local cache_file = FZF_CAHCE_FILES_DIR .. format_cur_dir
	local command = ""
	local preview = "head {}"
	local modified_time = fn.getftime(cache_file)

	if (modified_time == -1) or (os.time() - modified_time > 604800) then -- refresh per week

		-- first make sure cache dir exists
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
		local choices = fzf(command, ("--ansi --preview=%s --expect=ctrl-s,ctrl-t,ctrl-v,ctrl-r --multi"):format(fn.shellescape(preview)))

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

return M
