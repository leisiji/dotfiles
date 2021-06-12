local M = {}

-- galaxyline
COLORS = require('zephyr')
VI_MODES = {
  n = { COLORS.orange,   '  NORMAL ' }, i = { COLORS.green, '  INSERT ' },
  v = { COLORS.blue,  '  VISUAL ' }, V = { COLORS.blue,  '  V-LINE ' },
  [''] = { COLORS.blue, '  VISUAL ' }, c = { COLORS.violet, '  COMMAND ' },
  t = { COLORS.yellow, '  TERMINAL ' },
}

function M.statusline()
  local galaxyline = require('galaxyline')
  local sec = galaxyline.section

  sec.left[1] = {
    ViMode = {
      provider = function()
        local mode = VI_MODES[vim.fn.mode()]
        if mode ~= nil then
          vim.cmd('hi GalaxyViMode guibg='..mode[1])
          return mode[2]
        end
      end,
      highlight = {COLORS.bg, COLORS.bg, 'bold'}
    }
  }
  sec.left[2] = { func = { provider = { function() return vim.b.current_func_name end }, icon = '  λ ' } }
  sec.right[1] = { BufferType = { provider = 'FileTypeName', separator = ' | ', } }
  sec.right[2] = { MaxLine = { provider = function () return vim.fn.line('$') end, separator = ' | ', } }
  galaxyline.load_galaxyline()
end

-- treesitter
function M.treesitter()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", highlight = { enable = true },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['ic'] = '@conditional.inner', ['ac'] = '@conditional.outer',
          ['ip'] = '@parameter.inner', ['ap'] = '@parameter.outer'
        },
      },
    },
  }
end

-- gitsigns
function M.gitsigns()
  require'gitsigns'.setup {
    signs = {
      add = {hl = 'GitGutterAdd', text = '+'},
      change = {hl = 'GitGutterChange', text = '~'},
      delete = { hl = 'GitGutterDelete', text = '_'},
      topdelete = { hl = 'GitGutterDelete', text = '‾'},
      changedelete = { hl = 'GitGutterChange', text = '~' }
    },
    watch_index = { interval = 5000 },
    keymaps = {
      noremap = true, buffer = true,
      ['n <leader><leader>n'] = '<cmd>lua require"gitsigns".next_hunk()<CR>',
      ['n <leader><leader>N'] = '<cmd>lua require"gitsigns".prev_hunk()<CR>',
      ['n <leader><leader>b'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
    }
  }
end

function M.colorscheme()
  local exec = vim.cmd
  exec('colorscheme zephyr')
  exec('hi TabLineSel gui=bold guibg='..COLORS.blue..' guifg='..COLORS.bg)
  exec('hi TabLine gui=NONE guibg='..COLORS.fg..' guifg='..COLORS.bg)
end

function M.indent_guide()
  local c = { fg = COLORS.yellow, bg = '#2a3834' }
  require('indent_guides').setup({ even_colors = c, odd_colors = c })
end

function M.diffview()
  vim.cmd([[
    hi DiffAdd    guibg=#26332c guifg=NONE
    hi DiffChange guibg=#273842 guifg=NONE
    hi DiffDelete guibg=#572E33 guifg=NONE
    hi DiffText   guibg=#314753 guifg=NONE
  ]])
  require'diffview'.setup { file_panel = { use_icons = false } }
end

function M.inline_edit()
  vim.g.inline_edit_new_buffer_command = "tabedit"
  vim.g.inline_edit_autowrite = 1
end

function M.lspsaga()
  require 'lspsaga'.init_lsp_saga {
    max_preview_lines = 25,
    finder_action_keys = { open = '<cr>', vsplit = 'v', split = 's', quit = { 'q', '<ESC>' } }
  }
end

return M
