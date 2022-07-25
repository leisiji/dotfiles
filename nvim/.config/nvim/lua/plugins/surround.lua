local M = {}

function M.config()
  require("nvim-surround").setup({
    keymaps = {
      insert = "<C-g>s",
      visual = "S",
      delete = "ds",
      change = "cs",
    },
  })
end

return M
