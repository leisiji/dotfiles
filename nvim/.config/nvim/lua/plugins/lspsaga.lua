local M = {}

function M.config()
  require("lspsaga").setup({
    finder = {
      max_height = 1.1,
      keys = {
        vsplit = "<C-v>",
        tabe = "<enter>",
        tabnew = "<C-t>",
      },
    },
    outline = {
      auto_preview = false,
    },
  })
end

return M
