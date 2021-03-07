local bind = require('bind')
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd
local map_cu = bind.map_cu
local plug_map = {
	["n|<M-l>"] = map_cr('tabnext'):with_noremap():with_silent(),
	["n|<M-h>"] = map_cr('tabprev'):with_noremap():with_silent(),
	["n|<Leader>s"] = map_cr('w'):with_silent(),
	["n|<Leader><Leader>q"] = map_cr('qa'):with_silent(),
	["n|<Leader>rt"] = map_cu('%retab!'):with_noremap():with_silent(),
	["n|<C-j>"] = map_cmd('5j'),
	["n|<C-k>"] = map_cmd('5k'),
	["n|<M-e>"] = map_cmd('5e'),
	["n|<M-w>"] = map_cmd('5w'),
	["n|<M-b>"] = map_cmd('5b'),
	["n|L"] = map_cmd('$'):with_noremap():with_silent(),
	["n|H"] = map_cmd('^'):with_noremap():with_silent(),
	["i|<C-j>"] = map_cmd('<Down>'):with_noremap(),
	["i|<C-k>"] = map_cmd('<Up>'):with_noremap(),
	["i|<C-b>"] = map_cmd('<Left>'):with_noremap(),
	["i|<C-f>"] = map_cmd('<Right>'):with_noremap(),
	["i|<C-a>"] = map_cmd('<Home>'):with_noremap(),
	["i|<C-e>"] = map_cmd('<End>'):with_noremap(),
	["i|<C-d>"] = map_cmd('<Delete>'):with_noremap(),
	["i|<M-b>"] = map_cmd('<C-left>'):with_noremap(),
	["i|<M-f>"] = map_cmd('<C-right>'):with_noremap(),
	["i|<M-d>"] = map_cmd('<C-o>diw'):with_silent(),
	["v|L"] = map_cmd('g_'):with_noremap(),
	["v|<C-j>"] = map_cmd('5j'):with_noremap(),
	["v|<C-k>"] = map_cmd('5k'):with_noremap(),
	["v|<Leader>y"] = map_cmd('"+y"'),

	-- coc.nvim
	["i|<Tab>"] = map_cmd('pumvisible() ? "\\<C-n>" : "\\<Tab>"'):with_expr():with_noremap(),
	["i|<S-Tab>"] = map_cmd('pumvisible() ? "\\<C-p>" : "\\<Tab>"'):with_expr():with_noremap(),
	["i|<cr>"] = map_cmd('pumvisible() ? "\\<C-y>" : "\\<C-g>u<CR>"'):with_expr():with_noremap(),

	["n|<Leader>p"] = map_cmd('LeaderfFile'):with_expr():with_noremap(),
	["n|<Leader>ff"] = map_cmd('LeaderfFile'):with_expr():with_noremap(),
	["n|<C-r>"] = map_cmd('Leaderf --fuzzy function'):with_expr():with_noremap(),
	["n|<C-f>"] = map_cmd('Leaderf rg --current-buffer'):with_expr():with_noremap(),
	["n|<M-f>"] = map_cmd('Leaderf rg --current-buffer'):with_expr():with_noremap(),
}
bind.nvim_load_mapping(plug_map)
