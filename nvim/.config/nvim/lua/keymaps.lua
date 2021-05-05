local mapkey = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local format = string.format

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

function _G.MyQuit()
	local fn = vim.fn
	local exec = vim.cmd
	local bufnrs = fn.win_findbuf(fn.bufnr())

	if #bufnrs > 1 or fn.expand('%') == '' or fn.tabpagenr('$') == 1 then
		exec('q')
	else
		exec('bd')
	end
end

function _G.MyshowDocument()
	local filetype  = vim.bo.filetype
	local exec = vim.cmd
	local word = vim.fn.expand('<cword>')

	if filetype == 'vim' or filetype == 'lua' or filetype == 'help' then
		exec('vertical h '..word)
	else
		exec('vertical Man '..word)
	end
end

init_nvim_keys()
