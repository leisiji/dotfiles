PLUGINS_CONFIG = require('plugins_config')
LSP_CONFIG = require('plugins.lspconfig')

local packer = require('packer')
local use = packer.use
packer.startup(function()
	use { 'wbthomason/packer.nvim' }
	use { 'nvim-lua/plenary.nvim' } -- needed by gitsigns
	use { 'vijaymarupudi/nvim-fzf' }

	use {
		'nvim-treesitter/nvim-treesitter', opt = true,
		run = ':TSUpdate', event = 'BufRead',
		config = PLUGINS_CONFIG.treesitter
	}

	use { 'mattn/emmet-vim', opt = true, ft = {'html'} }

	-- lsp and completion
	use {
		'neovim/nvim-lspconfig', event = 'BufReadPre', opt = true,
		config = function () LSP_CONFIG.init_lsp() end,
	}
	use {
		'glepnir/lspsaga.nvim', opt = true, cmd = 'Lspsaga',
		config = function () require 'lspsaga'.init_lsp_saga() end
	}
	use {
		'nvim-lua/completion-nvim', opt = true, event = 'InsertEnter',
		config = function () LSP_CONFIG.completion_setup() end
	}
	use {
		'steelsojka/completion-buffers', opt = true, event = 'InsertEnter',
		after = 'completion-nvim'
	}
	use {
		'windwp/nvim-autopairs', opt = true, event = 'BufRead',
		config = function () require('nvim-autopairs').setup() end
	}
	use {
		'norcalli/snippets.nvim', opt = true, event = 'InsertEnter',
		config = function () LSP_CONFIG.snippet() end
	}
	use {
		'lewis6991/gitsigns.nvim', opt = true, event = 'BufRead',
		config = PLUGINS_CONFIG.gitsigns
	}
	use {
		'glepnir/indent-guides.nvim', opt = true, event = 'BufRead',
		config = PLUGINS_CONFIG.indent_guide
	}
	use {
		'norcalli/nvim-colorizer.lua', opt = true,
		ft = { 'html', 'css', 'help', 'lua', 'vim' },
		config = function () require'colorizer'.setup() end
	}
	use { 'glepnir/zephyr-nvim', config = PLUGINS_CONFIG.colorscheme }
	use { 'glepnir/galaxyline.nvim', branch = 'main', config = PLUGINS_CONFIG.statusline }

	use { 'caenrique/nvim-toggle-terminal', opt = true, cmd = 'ToggleTerminal' }
	use { 'AndrewRadev/inline_edit.vim', opt = true, cmd = 'InlineEdit' }
	use { 'mhartington/formatter.nvim', opt = true, cmd = 'Format' }
	use { 'tpope/vim-surround', opt = true, event = 'BufRead' }
	use { 'junegunn/vim-easy-align', opt = true, cmd = 'EasyAlign' }
	use { 'lambdalisue/fern.vim', opt = true, cmd = 'Fern' }
	use { 'antoinemadec/vim-highlight-groups', opt = true, cmd = 'HighlightGroupsAddWord' }

	if vim.fn.executable('fcitx5') == 1 then
		use {
			'lilydjwg/fcitx.vim', opt = true, branch = 'fcitx5',
			event = 'InsertEnter'
		}
	end
end)

