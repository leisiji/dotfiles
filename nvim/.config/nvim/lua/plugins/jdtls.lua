local M = {}

function M.config()
	require('jdtls').start_or_attach({cmd = { 'jdtls' }})
end

return M
