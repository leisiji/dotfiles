local fzf = require('fzf').fzf
local fn = vim.fn

-- example: {"_type": "tag", "pattern": "/^void thaw_secondary_cpus(void)$/", "line": 1412, "kind": "function"}
local function get_ctags(file)
	local cmd = string.format("ctags --output-format=json -u --fields=nzP -f- %s", file)
	local res = fn.systemlist(cmd)
	local funcs = {}
	local count = 1

	for _,val in pairs(res) do
		local tag_json_obj = fn.json_decode(val)
		if tag_json_obj["kind"] == "function" then
			local pattern = tag_json_obj["pattern"]
			local func_name = string.sub(pattern, 3, #pattern - 2)
			local ln = tag_json_obj["line"]
			local str = string.format("%s: %s", ln, func_name)
			funcs[count] = str
			count = count + 1
		end
	end

	return funcs
end

return function()
	local utils = require('fzf_utils.utils')
	local cur_file = fn.expand("%:p")
	local col = fn.getcurpos()[3]
	local res = get_ctags(cur_file)
	coroutine.wrap(function ()
		local result = fzf(res, "--expect=ctrl-v --preview="..utils.get_preview_action(cur_file))

		local row = utils.get_leading_num(result[2])
		if result[1] == "ctrl-v" then
			require('fzf_utils.utils').vsplitedit(cur_file, row, col)
		else
			vim.api.nvim_win_set_cursor(0, {row, col})
		end
	end)()
end
