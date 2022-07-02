local M = {}

function M.config()
  require("nvim-surround").setup({
    keymaps = {
      insert = "ys",
      visual = "S",
      delete = "ds",
      change = "cs",
    },
  })
end

return M
