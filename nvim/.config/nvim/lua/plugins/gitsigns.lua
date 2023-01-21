local M = {}

function M.config()
  require("gitsigns").setup({
    watch_gitdir = {
      interval = 5000,
      follow_files = true,
    },
    keymaps = {
      noremap = true,
      buffer = true,
      ["n <leader><leader>n"] = '<cmd>lua require"gitsigns".next_hunk()<CR>',
      ["n <leader><leader>N"] = '<cmd>lua require"gitsigns".prev_hunk()<CR>',
      ["n <leader><leader>b"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
    },
  })
end

return M
