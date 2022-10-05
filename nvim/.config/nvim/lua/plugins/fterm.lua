local M = {}

function M.config()
  local a = vim.api
  a.nvim_create_user_command("FTermToggle", require("FTerm").toggle, { nargs = 0 })
  local opts = { noremap = true, silent = true }

  require("FTerm").setup({
    dimensions = {
      height = 1,
      width = 1,
      x = 0,
      y = 0,
    },
    border = "single", -- or 'double'
  })

  vim.keymap.set("t", "<C-x>", function ()
    if vim.bo.filetype == "FTerm" then
      require("FTerm").toggle()
    end
  end, opts)
  vim.keymap.set("n", "<leader>tc", function ()
    local dir = vim.fn.expand("%:p:h")
    require("FTerm").run("cd " .. dir)
  end, opts)
end

return M
