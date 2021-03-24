local M = {}

function M.get_leading_num(s)
	return tonumber(string.match(s, "%d+"))
end

return M
