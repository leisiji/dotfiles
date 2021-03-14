
PLUGINS_CONFIG = require('plugins_config')

local packer = require('packer')
local use = packer.use
packer.startup(function()
	use { 'wbthomason/packer.nvim' }
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function() PLUGINS_CONFIG.treesitter() end
	}
	use {
		'nvim-lua/plenary.nvim'
	}

	-- coc.nvim
	use {
		'neoclide/coc.nvim', branch = 'release',
		requires = {
			{ 'neoclide/coc-sources', opt = true, after = 'coc.nvim' },
			{ 'honza/vim-snippets', opt = true, after = 'coc.nvim' }
		}
	}
	use { 'mattn/emmet-vim', opt = true, ft = {'html'} }
	use {
		'jackguo380/vim-lsp-cxx-highlight', opt = true, ft = {'c', 'cpp'}
	}

	use {
		'glepnir/zephyr-nvim',
		config = function() vim.cmd('colorscheme zephyr') end
	}
	use {
		'glepnir/galaxyline.nvim',
		branch = 'main',
		config = function() PLUGINS_CONFIG.statusline() end
	}

	use {
		'voldikss/vim-floaterm', opt = true,
		cmd = 'FloatermToggle'
	}
	use {
		'Yggdroot/LeaderF', run = './install.sh', opt = true,
		cmd = {'Leaderf', 'LeaderfFile'}
	}
	use {
		'APZelos/blamer.nvim', opt = true,
		cmd = 'BlamerToggle'
	}
	use {
		'AndrewRadev/inline_edit.vim', opt = true,
		cmd = 'InlineEdit'
	}
	use {
		'sbdchd/neoformat', opt = true,
		cmd = 'Neoformat'
	}
	use {
		'tpope/vim-surround', opt = true,
		event = 'BufRead'
	}
	use {
		'lewis6991/gitsigns.nvim',
		event = {'BufRead','BufNewFile'},
		opt = true,
		config = function() PLUGINS_CONFIG.gitsigns() end,
	}
	use {
		'glepnir/indent-guides.nvim',
		opt = true,
		event = 'BufRead'
	}
end)

