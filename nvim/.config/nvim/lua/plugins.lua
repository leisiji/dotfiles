PLUGINS_CONFIG = require('plugins_config')
LSP_CONFIG = require('plugins.lspconfig')
COMPLETION_CONFIG = require('plugins.completion')

local packer = require('packer')
local use = packer.use
packer.startup(function()
	use { 'wbthomason/packer.nvim' }
	use { 'nvim-lua/plenary.nvim' } -- needed by gitsigns
	use { 'vijaymarupudi/nvim-fzf' }

	-- colorscheme and statusline
	use { 'glepnir/zephyr-nvim', config = PLUGINS_CONFIG.colorscheme }
	use { 'glepnir/galaxyline.nvim', branch = 'main', config = PLUGINS_CONFIG.statusline }

	use {
		'nvim-treesitter/nvim-treesitter', opt = true,
		run = ':TSUpdate', event = 'BufRead',
		config = PLUGINS_CONFIG.treesitter
	}

	-- lsp
	use {
		'neovim/nvim-lspconfig', event = 'BufReadPre', opt = true,
		config = function () LSP_CONFIG.lsp_config() end,
	}
	use {
		'glepnir/lspsaga.nvim', opt = true, cmd = 'Lspsaga',
		config = function () LSP_CONFIG.lspsaga_config() end
	}

	-- completion
	use {
		'nvim-lua/completion-nvim', opt = true, event = 'InsertEnter',
		setup = COMPLETION_CONFIG.setup, config = COMPLETION_CONFIG.config
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
		'hrsh7th/vim-vsnip-integ', opt = true, event = 'InsertEnter',
		requires = { 'hrsh7th/vim-vsnip', 'rafamadriz/friendly-snippets' }
	}

	-- code format
	use {
		'mhartington/formatter.nvim', opt = true, cmd = 'Format',
		config = function () require'plugins.formatter'.init() end
	}
	use { 'tpope/vim-surround', opt = true, event = 'BufRead' }

	-- Git
	use {
		'lewis6991/gitsigns.nvim', opt = true, event = 'BufRead',
		config = PLUGINS_CONFIG.gitsigns
	}
	use {
		'sindrets/diffview.nvim', opt = true, cmd = 'DiffviewOpen',
		config = PLUGINS_CONFIG.diffview
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
	use {
		'AndrewRadev/inline_edit.vim', opt = true, cmd = 'InlineEdit',
		setup = function ()
			vim.g.inline_edit_new_buffer_command = "tabedit"
			vim.g.inline_edit_autowrite = 1
		end
	}

	use { 'caenrique/nvim-toggle-terminal', opt = true, cmd = 'ToggleTerminal' }
	use { 'junegunn/vim-easy-align', opt = true, cmd = 'EasyAlign' }
	use {
		'kyazdani42/nvim-tree.lua', opt = true, cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
		config = require('plugins.nvim_tree').config
	}
	use { 'antoinemadec/vim-highlight-groups', opt = true, cmd = 'HighlightGroupsAddWord' }
	use {
		'npxbr/glow.nvim', opt = true, cmd = 'Glow'
	}

	if vim.fn.executable('fcitx5') == 1 then
		use {
			'lilydjwg/fcitx.vim', opt = true, branch = 'fcitx5',
			event = 'InsertEnter'
		}
	end
end)

