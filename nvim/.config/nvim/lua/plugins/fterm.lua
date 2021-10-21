local M = {}

function M.chdir()
  local dir = vim.fn.expand('%:p:h')
  require('FTerm').run('cd ' .. dir)
end

function M.config()
  vim.cmd[[command! -nargs=0 FTermToggle lua require("FTerm").toggle()]]

  require'FTerm'.setup({
    dimensions  = {
      height = 1,
      width = 1,
      x = 0,
      y = 0
    },
    border = 'single' -- or 'double'
  })

  vim.cmd[[
    augroup my_fterm
      au FileType FTerm tno <buffer> <C-x> <C-\><C-n>:FTermToggle<CR>
    augroup END
  ]]

  vim.api.nvim_set_keymap('n', '<leader>tc',
      [[<cmd>lua require('plugins.fterm').chdir()<cr>]], { noremap = true, silent = true })
end

return M
