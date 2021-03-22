local M = {}

local fzf = require "fzf".fzf

FZF_CAHCE_DIR = "$HOME/.cache/nvim_fzf/"
FZF_CAHCE_FILES_DIR = FZF_CAHCE_DIR .. "files/"

local fn = vim.fn

function M.files()
	local cur_dir = fn.getcwd()
	local cache_files = FZF_CAHCE_FILES_DIR .. cur_dir
	local cache_comand = "tee " .. cache_files
	local command = "fd --color always -t f -L"
	local preview = "bat --line-range=:$(($FZF_PREVIEW_LINES - 5)) --color always -- {}"
	
	local modified_time = fn.getftime()

	coroutine.wrap(function ()
		local choices = fzf(command, ("--ansi --preview=%s --expect=ctrl-s,ctrl-t,ctrl-v --multi"):format(fn.shellescape(preview)))

		if not choices then return end

		local vimcmd
		if choices[1] == "ctrl-t" then
			vimcmd = "tabnew"
		elseif choices[1] == "ctrl-v" then
			vimcmd = "vnew"
		elseif choices[1] == "ctrl-s" then
			vimcmd = "new"
		else
			vimcmd = "e"
		end

		for i=2,#choices do
			vim.cmd(vimcmd .. " " .. fn.fnameescape(choices[i]))
		end
	end)()
end

return M
