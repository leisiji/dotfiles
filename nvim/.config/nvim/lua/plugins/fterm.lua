local M = {}

function M.chdir()
  local dir = vim.fn.expand("%:p:h")
  require("FTerm").run("cd " .. dir)
end

function M.config()
  vim.cmd([[command! -nargs=0 FTermToggle lua require("FTerm").toggle()]])

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
  local a = vim.api
  local bufnr = a.nvim_get_current_buf()
  a.nvim_create_augroup(group, { clear = true })
  a.nvim_create_autocmd({ "Filetype" }, {
    pattern = { "FTerm" },
    callback = function()
      a.nvim_set_keymap("t", "<C-x>", [[<C-\><C-n>:FTermToggle<CR>]], { noremap = true, silent = true })
    end,
  })
end

return M
