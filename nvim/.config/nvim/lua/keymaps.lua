local mapkey = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local format = string.format
local fn = vim.fn
local exec = vim.cmd

local function cmd(lhs, rhs)
	mapkey('n', lhs, format('<cmd>%s<cr>', rhs), opts)
end

local function ino(lhs, rhs)
	mapkey('i', lhs, rhs, opts)
end

local function nn(lhs, rhs)
	mapkey('n', lhs, rhs, opts)
end

local function vn(lhs, rhs)
	mapkey('v', lhs, rhs, opts)
end

local function xcmd(lhs, rhs)
	mapkey('x', lhs, format('<cmd>%s<cr>', rhs), opts)
end

local function init_nvim_keys()
	nn('<M-a>', '<C-w>w')
	nn('H', '^')
	nn('L', '$')
	nn('<C-j>', '5j')
	nn('<C-k>', '5k')
	nn('<M-e>', '5e')
	nn('<M-b>', '5b')
	nn('<M-w>', '5w')
	nn('<M-y>', '<C-r>')
	nn('<leader>p', '"+p')

	vn('H', '^')
	vn('L', 'g_')
	vn('<C-j>', '5j')
	vn('<C-k>', '5k')
	vn('<leader>y', '"+y')

	for i = 1, 9, 1 do
		nn(format('<M-%d>', i), format('%dgt', i))
	end

	cmd('<leader>s', 'w')
	cmd('<M-l>', 'tabn')
	cmd('<M-h>', 'tabp')
	cmd('<leader><leader>q', 'qa')
	cmd('<leader>q', 'call v:lua.MyQuit()')
	cmd('K', 'call v:lua.MyshowDocument()')
	cmd('<leader>rt', '%retab!')
	cmd('<leader>z', 'call v:lua.MyWinZoomToggle()')

	ino('<C-j>', '<Down>')
	ino('<C-k>', '<Up>')
	-- insert mode like bash
	ino('<C-b>', '<Left>')
	ino('<C-f>', '<Right>')
	ino('<C-a>', '<Home>')
	ino('<C-e>', '<End>')
	ino('<C-d>', '<Delete>')
	ino('<C-h>', '<Backspace>')
	ino('<M-b>', '<C-Left>')
	ino('<M-f>', '<C-Right>')
	ino('<M-d>', '<C-o>diw')

	mapkey('t', '<M-e>', '<C-\\><C-n>', opts)
end

local function init_plugins_keymaps()
	-- terminal
	cmd('<leader>tt', 'ToggleTerminal')

	-- inline edit
	nn('<leader>e', '<C-u>InlineEdit')
	xcmd('<leader>e', 'InlineEdit')

	-- easy align
	xcmd('ga', 'EasyAlign')

	-- nvim tree
	cmd('<leader>tj', 'NvimTreeFindFile')
	cmd('<leader>tr', 'NvimTreeToggle')

	-- highlight group
	cmd('<leader>k', 'HighlightGroupsAddWord 4 0')
	cmd('<leader>K', 'HighlightGroupsClearGroup 4 0')

	-- nvim fzf
	cmd('<C-p>', 'FzfCommand --files')
	cmd('<C-f>', 'FzfCommand --lines')
	cmd('<C-r>', 'FzfCommand --ctags')
	cmd('<leader>b', 'FzfCommand --buffers')
	cmd('<leader><leader>m', 'FzfCommand --man')
	cmd('<leader><leader>h', 'FzfCommand --vim help')
	cmd('<leader>h', 'FzfCommand --vim cmdHists')
	cmd('<leader>ft', 'FzfCommand --vim filetypes')
	cmd('<leader>fd', [[exe('FzfCommand --gtags -d '.expand('<cword>'))]])
	cmd('<leader>fr', [[exe("FzfCommand --gtags -r ".expand("<cword>"))]])
	cmd('<leader>fa', [[exe("FzfCommand --rg ".expand("<cword>"))]])

	-- diffview.nvim
	cmd('<leader><leader>d', [[exe('DiffviewOpen -- '.v:lua.GetFileDir())]])
	cmd('<leader><leader>c', 'call v:lua.DiffViewFile()')
end

function _G.MyQuit()
	local bufnrs = fn.win_findbuf(fn.bufnr())

	if #bufnrs > 1 or fn.expand('%') == '' or fn.tabpagenr('$') == 1 then
		exec('q')
	else
		exec('bd')
	end
end

function _G.MyshowDocument()
	local filetype  = vim.bo.filetype
	local word = fn.expand('<cword>')

	if filetype == 'vim' or filetype == 'lua' or filetype == 'help' then
		exec('vertical h '..word)
	else
		exec('vertical Man '..word)
	end
end

function _G.MyWinZoomToggle()
	local zoom = vim.t.zoom
	if zoom ~= nil and zoom == 1 then
		exec(vim.t.zoom_winrestcmd)
		vim.t.zoom = 0
	else
		vim.t.zoom_winrestcmd = fn.winrestcmd()
		exec('resize | vertical resize')
		vim.t.zoom = 1
	end
end

function _G.GetFileDir()
	return fn.fnamemodify(fn.expand('%:p:h'), ':.')
end

function _G.DiffViewFile()
	exec('DiffviewOpen -- ' .. fn.expand('%'))
	exec('DiffviewToggleFiles')
end

init_nvim_keys()
init_plugins_keymaps()
