local M = {}

function M.colorscheme()
  local onedarkpro = require('onedarkpro')
  onedarkpro.setup({
    colors = {
      cursorline = '#4B4B4B',
        onedark = {
          bg = "#1e1e1e",
        },
    },
    hlgroups = {
      TabLineSel = { fg = "${bg}", bg = "${blue}" }
    },
    options = {
      cursorline = true,
    },
  })
  onedarkpro.load()

  vim.cmd('hi link FocusedSymbol LspReferenceText')
end

-- treesitter
function M.treesitter()
  require('nvim-treesitter.configs').setup {
    ensure_installed = "maintained", highlight = { enable = true },
  }
end

-- gitsigns
function M.gitsigns()
  require('gitsigns').setup {
    watch_index = { interval = 5000 },
    keymaps = {
      noremap = true, buffer = true,
      ['n <leader><leader>n'] = '<cmd>lua require"gitsigns".next_hunk()<CR>',
      ['n <leader><leader>N'] = '<cmd>lua require"gitsigns".prev_hunk()<CR>',
      ['n <leader><leader>b'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
    }
  }
end

function M.filetype()
  require("filetype").setup({
    overrides = {
      extensions = {
        bp = "javascript",
        rc = "rc",
        hal = "hal"
      },
    },
})
end

function M.indent()
  require('indent-o-matic').setup({
    max_lines = 2048,
    filetype_rust = { standard_widths = { 4 } },
    filetype_python = { standard_widths = { 4 } },
    filetype_markdown = { standard_widths = { 4 } },
  })
end

-- inline edit
vim.g.inline_edit_new_buffer_command = "tabedit"
vim.g.inline_edit_autowrite = 1

vim.g.symbols_outline = {
  auto_preview = false,
  width = 25,
}

return M
