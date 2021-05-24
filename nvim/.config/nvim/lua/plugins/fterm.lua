local M = {}

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

  vim.api.nvim_set_keymap('t', '<esc>',
    [[(&ft == 'fzf') ? '<esc>' : '<C-\><C-n>:FTermToggle<CR>']],
    { silent = true, noremap = true, expr = true }
  )
end

return M
