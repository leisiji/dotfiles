local M = {}

function M.get_leading_num(s)
	return string.match(s, "%d+")
end

return M
