local M = {}

function M.colorscheme()
  local onedarkpro = require('onedarkpro')
  onedarkpro.setup({
    colors = { cursorline = '#4B4B4B' },
    hlgroups = {
      LspReferenceRead = { fg = "${bg}", bg = "${yellow}" },
      LspReferenceWrite = { fg = "${bg}", bg = "${yellow}" },
      LspReferenceText = { fg = "${bg}", bg = "${yellow}" },
      TabLineSel = { fg = "${bg}", bg = "${blue}" }
    },
    options = {
      cursorline = true,
    },
  })
  onedarkpro.load()
end

-- galaxyline
function M.statusline()
  local colors = require("onedarkpro").get_colors("onedark")
  local vi_modes = {
    n = { colors.orange,   '  NORMAL ' }, i = { colors.green, '  INSERT ' },
    v = { colors.blue,  '  VISUAL ' }, V = { colors.blue,  '  V-LINE ' },
    [''] = { colors.blue, '  VISUAL ' }, c = { colors.purple, '  COMMAND ' },
    t = { colors.yellow, '  TERMINAL ' },
  }

  local galaxyline = require('galaxyline')
  local sec = galaxyline.section

  sec.left[1] = {
    ViMode = {
      provider = function()
        local mode = vi_modes[vim.fn.mode()]
        if mode ~= nil then
          vim.cmd('hi GalaxyViMode guibg='..mode[1])
          return mode[2]
        end
      end,
      highlight = {colors.bg, colors.bg, 'bold'}
    }
  }
  sec.left[2] = { func = { provider = { function() return vim.b.current_func_name end }, icon = '  λ ' } }
  sec.right[1] = { BufferType = { provider = 'FileTypeName', separator = ' | ', } }
  sec.right[2] = { MaxLine = { provider = function () return vim.fn.line('$') end, separator = ' | ', } }
  galaxyline.load_galaxyline()
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
  vim.cmd[[
    hi DiffAdd    guibg=#26332c guifg=NONE
    hi DiffChange guibg=#273842 guifg=NONE
    hi DiffDelete guibg=#572E33 guifg=NONE
    hi DiffText   guibg=#314753 guifg=NONE
  ]]
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

-- inline edit
vim.g.inline_edit_new_buffer_command = "tabedit"
vim.g.inline_edit_autowrite = 1

return M
