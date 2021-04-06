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
	local res = get_ctags(cur_file)
	coroutine.wrap(function ()
		local result = fzf(res, "--preview="..utils.get_preview_action(cur_file))
		if result ~= nil then
			vim.cmd(utils.get_leading_num(result[1]))
		end
	end)()
end
