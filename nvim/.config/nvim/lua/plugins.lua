
PLUGINS_CONFIG = require('plugins_config')

local packer = require('packer')
local use = packer.use
packer.startup(function()
	use { 'wbthomason/packer.nvim' }
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = PLUGINS_CONFIG.treesitter
	}
	use {
		'nvim-lua/plenary.nvim' -- needed by gitsigns
	}

	-- coc.nvim
	use {
		'neoclide/coc.nvim', branch = 'release', opt = true,
		event = 'BufRead',
		requires = {
			{ 'neoclide/coc-sources' },
			{ 'honza/vim-snippets' }
		},
		config = PLUGINS_CONFIG.cocnvim
	}
	use { 'mattn/emmet-vim', opt = true, ft = {'html'} }

	use {
		'glepnir/zephyr-nvim',
		config = PLUGINS_CONFIG.colorscheme
	}
	use {
		'glepnir/galaxyline.nvim',
		branch = 'main',
		config = PLUGINS_CONFIG.statusline
	}

	use {
		'voldikss/vim-floaterm', opt = true,
		cmd = 'FloatermToggle'
	}
	use {
		'Yggdroot/LeaderF', run = './install.sh', opt = true,
		cmd = {'Leaderf'}
	}
	use {
		'AndrewRadev/inline_edit.vim', opt = true,
		cmd = 'InlineEdit'
	}
	use {
		'mhartington/formatter.nvim', opt = true,
		cmd = 'Format'
	}
	use {
		'tpope/vim-surround', opt = true, event = 'BufRead'
	}
	use {
		'lewis6991/gitsigns.nvim', opt = true, event = { 'BufRead' },
		config = PLUGINS_CONFIG.gitsigns
	}
	use {
		'glepnir/indent-guides.nvim', opt = true, event = 'BufRead'
	}
	use {
		'junegunn/vim-easy-align', opt = true,
		cmd = 'EasyAlign'
	}
	use {
		'lambdalisue/fern.vim', opt = true, cmd = 'Fern'
	}
	if vim.fn.executable('fcitx5') == 1 then
		use {
			'lilydjwg/fcitx.vim', opt = true, branch = 'fcitx5',
			event = 'InsertEnter'
		}
	end
	use {
		'norcalli/nvim-colorizer.lua', opt = true,
		ft = { 'html', 'css', 'help', 'lua', 'vim' },
		config = function () require'colorizer'.setup() end
	}
	use {
		'vijaymarupudi/nvim-fzf'
	}
end)

