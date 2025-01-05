local M = {}

function M.parse()
  local compile = require("compile-mode")
  compile._parse_errors(vim.api.nvim_win_get_buf(0))
  vim.cmd("QuickfixErrors")
end

return M
