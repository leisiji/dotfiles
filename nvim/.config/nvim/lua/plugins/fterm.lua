local M = {}

function M.chdir()
  local dir = vim.fn.expand("%:p:h")
  require("FTerm").run("cd " .. dir)
end

function M.config()
  local a = vim.api
  a.nvim_create_user_command("FTermToggle", require("FTerm").toggle, { nargs = 0 })

  require("FTerm").setup({
    dimensions = {
      height = 1,
      width = 1,
      x = 0,
      y = 0,
    },
    border = "single", -- or 'double'
  })

  local group = "my_fterm"
  a.nvim_create_augroup(group, { clear = true })
  a.nvim_create_autocmd({ "Filetype" }, {
    pattern = { "FTerm" },
    callback = function()
      a.nvim_set_keymap("t", "<C-x>", [[<C-\><C-n>:FTermToggle<CR>]], { noremap = true, silent = true })
    end,
  })
  vim.api.nvim_set_keymap('n', '<leader>tc',
      [[<cmd>lua require('plugins.fterm').chdir()<cr>]], { noremap = true, silent = true })
end

return M
