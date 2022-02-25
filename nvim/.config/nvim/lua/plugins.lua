PLUGS_CFG = require('plugins_config')


local packer = require('packer')
local use = packer.use

packer.startup(function()

  use { 'wbthomason/packer.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nathom/filetype.nvim', config = PLUGS_CFG.filetype }

  use { 'leisiji/fzf_utils', opt = true, cmd = 'FzfCommand', requires = { 'vijaymarupudi/nvim-fzf' } }

  -- colorscheme and statusline
  use { 'olimorris/onedarkpro.nvim', config = PLUGS_CFG.colorscheme }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = PLUGS_CFG.treesitter }

  -- lsp
  use { 'neovim/nvim-lspconfig', event = 'BufReadPre', opt = true, config = function () require('plugins.lspconfig').lsp_config() end }
  use { 'mfussenegger/nvim-jdtls', opt = true, ft = { 'java' }, config = function () require('plugins.java').config() end }
  use { 'simrat39/symbols-outline.nvim', opt = true, cmd = 'SymbolsOutline' }
  use { 'rmagatti/goto-preview', opt = true, cmd = 'GotoPreview', config = function () require('plugins.goto_preview').config() end }
  use { 'folke/lua-dev.nvim', opt = true, ft = { 'lua' }, config = function () require('plugins.lua_dev').config() end }
  use { 'simrat39/rust-tools.nvim', opt = true, ft = {'rust'}, config = function () require('plugins.rust-tools').config() end }

  use {
    'ldelossa/litee-calltree.nvim', opt = true,
    requires = {'ldelossa/litee.nvim'}, cmd = 'CallTreeI',
    wants = 'litee.nvim',
    config = function () require('plugins.calltree').config() end
  }

  use {
    'hrsh7th/nvim-cmp', opt = true, event = 'InsertEnter',
    requires = {
      'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets',
      'windwp/nvim-autopairs', 'tpope/vim-surround'
    },
    config = function () require('plugins.cmp').config() end
  }

  -- code format
  use { 'mhartington/formatter.nvim', opt = true, cmd = 'Format', config = function () require('plugins.formatter').config() end }

  -- Git
  use { 'lewis6991/gitsigns.nvim', opt = true, event = 'BufRead', config = PLUGS_CFG.gitsigns }
  use { 'sindrets/diffview.nvim', opt = true, cmd = {'DiffviewOpen', 'DiffviewFileHistory'}, config = function () require('plugins.diffview').config() end }

  use { 'leisiji/simple_indent', opt = true, event = 'BufRead' }
  use { 'leisiji/indent-o-matic', config = PLUGS_CFG.indent }
  use { 'AndrewRadev/inline_edit.vim', opt = true, cmd = 'InlineEdit' }
  use { 'numToStr/FTerm.nvim', opt = true, cmd = 'FTermToggle', config = function () require('plugins.fterm').config() end }
  use { 'leisiji/interestingwords.nvim', opt = true, cmd = 'Interestingwords' }
  use { 'npxbr/glow.nvim', opt = true, cmd = 'Glow' }
  use { 'junegunn/vim-easy-align', opt = true, cmd = 'EasyAlign' }
  use { 'norcalli/nvim-colorizer.lua', opt = true, ft = { 'html', 'css', 'help', 'lua', 'vim' }, config = function () require'colorizer'.setup() end }

  use { 'kyazdani42/nvim-tree.lua', opt = true, cmd = {'NvimTreeToggle', 'NvimTreeFindFile'}, config = function () require('plugins.nvim_tree').setup() end }

  if vim.fn.executable('fcitx5') == 1 then
    use { 'h-hg/fcitx.nvim', opt = true, event = 'InsertEnter' }
  end
end)
