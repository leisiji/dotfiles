local fzf = require('fzf').fzf
local fn = vim.fn
local cur_file

-- example: {"_type": "tag", "pattern": "/^void thaw_secondary_cpus(void)$/", "line": 1412, "kind": "function"}
local function get_ctags(fzf_cb)
	local cmd = string.format("ctags --output-format=json -u --fields=nzP -f- %s", cur_file)
	local res = fn.systemlist(cmd)

	for _,val in pairs(res) do
		local tag_json_obj = fn.json_decode(val)
		if tag_json_obj["kind"] == "function" then
			local pattern = tag_json_obj["pattern"]
			local func_name = string.sub(pattern, 3, #pattern - 2)
			local ln = tag_json_obj["line"]
			local str = string.format("%s: %s", ln, func_name)
			fzf_cb(str, function () end)
		end
	end
	fzf_cb(nil, function () end)
end

return function()
	local utils = require('fzf_utils.utils')
	cur_file = fn.expand("%:p")
	coroutine.wrap(function ()
		local result = fzf(get_ctags, "--preview="..utils.get_preview_action(cur_file))
		if result ~= nil then
			vim.cmd(utils.get_leading_num(result[1]))
		end
	end)()
end
