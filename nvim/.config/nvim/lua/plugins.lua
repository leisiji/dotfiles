
require('packer').startup(function(use)
	use {'wbthomason/packer.nvim', opt = true}
	use { 'neoclide/coc.nvim', branch = 'release'}
	use 'neoclide/coc-sources'
	use 'kyazdani42/nvim-web-devicons'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use {
	    'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
	    requires = {'kyazdani42/nvim-web-devicons'}
  	}
	use { 'glepnir/zephyr-nvim' }
	use { 'voldikss/vim-floaterm', cmd = 'FloatermToggle' }
	use {
		'Yggdroot/LeaderF', run = './install.sh', cmd = {'Leaderf', 'LeaderfFile'}
	}
end)
