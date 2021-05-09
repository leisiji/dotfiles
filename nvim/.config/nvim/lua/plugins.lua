PLUGS_CFG = require('plugins_config')
LSP_CONFIG = require('plugins.lspconfig')

local packer = require('packer')
local use = packer.use

local function plugin_config(name)
	return require('plugins.'..name).config
end

packer.startup(function()
	use { 'wbthomason/packer.nvim' }
	use { 'nvim-lua/plenary.nvim' } -- gitsigns
	use { 'vijaymarupudi/nvim-fzf' }

	-- colorscheme and statusline
	use { 'glepnir/zephyr-nvim', config = PLUGS_CFG.colorscheme }
	use { 'glepnir/galaxyline.nvim', branch = 'main', config = PLUGS_CFG.statusline }
	use { 'nvim-treesitter/nvim-treesitter', opt = true, run = ':TSUpdate', event = 'BufRead', config = PLUGS_CFG.treesitter }

	-- lsp
	use { 'neovim/nvim-lspconfig', event = 'BufReadPre', opt = true, config = function () LSP_CONFIG.lsp_config() end }
	use { 'glepnir/lspsaga.nvim', opt = true, cmd = 'Lspsaga', config = LSP_CONFIG.lspsaga_config }

	use { 'hrsh7th/nvim-compe', opt = true, event = 'InsertEnter', requires = { 'Raimondi/delimitMate' }, config = plugin_config('compe') }
	use { 'hrsh7th/vim-vsnip-integ', opt = true, event = 'InsertEnter', requires = { 'hrsh7th/vim-vsnip', 'rafamadriz/friendly-snippets' } }

	-- code format
	use { 'mhartington/formatter.nvim', opt = true, cmd = 'Format', config = plugin_config('formatter') }
	use { 'blackCauldron7/surround.nvim', opt = true, event = 'InsertEnter', config = function () require"surround".setup{} end }

	-- Git
	use { 'lewis6991/gitsigns.nvim', opt = true, event = 'BufRead', config = PLUGS_CFG.gitsigns }
	use { 'sindrets/diffview.nvim', opt = true, cmd = 'DiffviewOpen', config = PLUGS_CFG.diffview }

	use { 'glepnir/indent-guides.nvim', opt = true, event = 'BufRead', config = PLUGS_CFG.indent_guide }
	use { 'AndrewRadev/inline_edit.vim', opt = true, cmd = 'InlineEdit', setup = PLUGS_CFG.inline_edit }
	use { 'numToStr/FTerm.nvim', opt = true, cmd = 'FTermToggle', config = plugin_config('fterm') }
	use { 'kyazdani42/nvim-tree.lua', opt = true, cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' }, config = plugin_config('nvim_tree') }
	use { 'antoinemadec/vim-highlight-groups', opt = true, cmd = 'HighlightGroupsAddWord' }
	use { 'npxbr/glow.nvim', opt = true, cmd = 'Glow' }
	use { 'junegunn/vim-easy-align', opt = true, cmd = 'LiveEasyAlign' }
	use { 'norcalli/nvim-colorizer.lua', opt = true, ft = { 'html', 'css', 'help', 'lua', 'vim' }, config = function () require'colorizer'.setup() end }

	if vim.fn.executable('fcitx5') == 1 then
		use { 'lilydjwg/fcitx.vim', opt = true, branch = 'fcitx5', event = 'InsertEnter' }
	end
end)

