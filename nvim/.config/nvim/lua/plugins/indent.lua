local M = {}

function M.config()
  require("indent-o-matic").setup({
    max_lines = 2048,
    filetype_rust = { standard_widths = { 4 } },
    filetype_python = { standard_widths = { 4 } },
    filetype_markdown = { standard_widths = { 4 } },
  })
end

return M
