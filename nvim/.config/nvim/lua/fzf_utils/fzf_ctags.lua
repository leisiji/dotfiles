local fzf = require('fzf').fzf
local fn = vim.fn
local path

-- get function from emacs-like output of ctags
local function get_ctags(cb)
	local cmd = string.format("ctags -e -f- %s", path)
	local res = fn.systemlist(cmd)
	if res == nil then
		cb(nil)
		return
	end

	local i = 3
	local func_name = nil
	local ln_start = 0
	while i <= #res  do
		local line = res[i]
		local j = 0
		while j < #line  do
			--print(string.byte(line, j))
			local char = string.byte(line, j)
			if char  == 0x7f then
				func_name = string.sub(line, 1, j - 1)
			elseif char == 0x01 then
				ln_start = j + 1
			elseif char == 0x2c then
				cb(string.sub(line, ln_start, j - 1) .. '  ' .. func_name)
			end
			j = j + 1
		end
		i = i + 1
	end
	cb(nil)
end

return function()
	path = fn.expand("%:p")
	coroutine.wrap(function ()
		local choices = fzf(get_ctags, "--nth 1 --ansi --expect=ctrl-t")
	end)()
end
