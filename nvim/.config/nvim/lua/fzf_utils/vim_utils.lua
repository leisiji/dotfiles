local M = {}
local fzf = require('fzf').fzf

-- total with 2 types of coroutines (except the necessary one)
-- the first used to search; the second used to read file
local function readfilecb(path, read_tag_cb)
	local uv = vim.loop
	uv.fs_open(path, "r", 438, function(err, fd)
		if err then
			read_tag_cb(nil)
			return
		end
		uv.fs_fstat(fd, function(_, stat)
			uv.fs_read(fd, stat.size, 0, function(_, data)
				uv.fs_close(fd, function(_)
					return read_tag_cb(data)
				end)
			end)
		end)
	end)
end

local function deal_with_tags(tagfile, cb)
	local search_dir_co = coroutine.running()
	coroutine.wrap(function ()

		local read_tag_co = coroutine.running()
		readfilecb(tagfile, function (data)
			coroutine.resume(read_tag_co, data)
		end)
		local data = coroutine.yield()

		if data ~= nil then
			for _, line in ipairs(vim.split(data, "\n")) do
				local items = vim.split(line, "\t")
				local tag = string.format("%s\t\27[0;37m%s\27[0m", items[1], items[2])
				cb(tag, function ()
					coroutine.resume(read_tag_co)
				end)
				coroutine.yield()
			end
		end
		coroutine.resume(search_dir_co)
	end)()
	coroutine.yield()
end

local function get_help_tags(cb)
	local runtimepaths = vim.api.nvim_list_runtime_paths()
	local total_done = 0
	for _, rtp in ipairs(runtimepaths) do
		local tagfile = table.concat({rtp, "doc", "tags"}, "/")
		coroutine.wrap(function ()
			deal_with_tags(tagfile, cb)
			total_done = total_done + 1
			if total_done == #runtimepaths then
				cb(nil)
			end
		end)()
	end
end

function M.vim_help()
	coroutine.wrap(function ()
		local result = fzf(get_help_tags, "--nth 1 --expect=ctrl-t")
		if not result then
			return
		end

		local choice = vim.split(result[2], "\t")[1]
		local key = result[1]
		local windowcmd
		if key == "ctrl-t" then
			windowcmd = "tab"
		else
			windowcmd = "vertical"
		end

		vim.cmd(string.format("%s h %s", windowcmd, choice))
	end)()
end

function M.vim_cmd_history()
	local fn = vim.fn
	local search = "cmd"
	local nr = fn.histnr(search)
	local count = 0
	local cmd_hists = {}

	while nr >= 0 do
		local cmd = fn.histget(search, nr - count)
		nr = nr - 1
		if cmd ~= nil and #cmd > 0 then
			cmd_hists[count] = cmd
			count = count + 1
		end
	end

	coroutine.wrap(function ()
		local result = fzf(cmd_hists, "")
		vim.cmd(result[1])
	end)()
end

return M
