local M = {}
local fzf_commands = require('fzf_utils.nvim_fzf_commands')

local function gtags_command(arg2, arg3)
	local gtags = require('fzf_utils.gtags')

	if arg2 == "-d" then
		gtags.find_definition(arg3)
	elseif arg2 == "-r" then
		gtags.find_references(arg3)
	elseif arg2 == "--update" then
		gtags.generate_gtags()
	elseif arg2 == "--update-buffer" then
		gtags.gtags_update_buffer()
	end
end

local function rg_command(arg2, arg3)
	local rg = require('fzf_utils.rg')

	if arg2 == "--all-buffers" then
		rg.search_all_buffers(arg2)
	else
		rg.search_path(arg2, arg3)
	end
end

local function ctags_command()
	local ctags = require('fzf_utils.ctags')
	ctags.get_cur_buf_func()
end

local function vim_command(arg2)
	local vim_utils = require('fzf_utils.vim_utils')
	if arg2 == 'help' then
		vim_utils.vim_help()
	elseif arg2 == "cmdHists" then
		vim_utils.vim_cmd_history()
	end
end

local subcommand = {
	files = fzf_commands.find_files,
	lines = fzf_commands.grep_lines,
	rg = rg_command,
	ctags = ctags_command,
	buffers = fzf_commands.buffers,
	man = fzf_commands.Man,
	vim = vim_command,
	gtags = gtags_command,
}

function M.load_command(arg1, arg2, arg3)
	if arg1 == nil then
		return
	end

	local sub = string.sub(arg1, 3)
	for idx,val in pairs(subcommand) do
		if sub == idx then
			val(arg2, arg3)
			break
		end
	end
end

return M
