local mapkey = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local format = string.format
local fn = vim.fn
local exec = vim.cmd

local function cmd(lhs, rhs)
	mapkey('n', lhs, format('<cmd>%s<cr>', rhs), opts)
end

local function cmd_gen(lhs, rhs)
	local gen_opts = { noremap = true }
	mapkey('n', lhs, format(':%s', rhs), gen_opts)
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

local function tn(lhs, rhs)
	mapkey('t', lhs, rhs, opts)
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
	vn('<M-e>', '5e')
	vn('<M-b>', '5b')
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
	cmd('<M-q>', [[exe('tabn '.g:last_active_tab)]])

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

	tn('<M-e>', '<C-\\><C-n>')
end

local function init_plugins_keymaps()
	-- terminal
	cmd('<leader>tt', 'FTermToggle')

	-- inline edit
	cmd('<leader>e', 'InlineEdit')

	-- easy align
	xcmd('ga', 'LiveEasyAlign')

	-- nvim tree
	cmd('<leader>tj', 'Fern . -reveal=% -drawer')
	cmd('<leader>tr', 'Fern . -drawer')

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
	cmd('<leader>fu', 'FzfCommand --gtags --update')
	cmd('<leader>fb', 'FzfCommand --gtags --update-buffer')
	cmd('<M-f>', [[exe('FzfCommand --rg --all-buffers '.expand('<cword>'))]])
	cmd('<leader>ff', [[exe('FzfCommand --rg '.expand('<cword>')." ".expand('%'))]])

	cmd_gen('<leader>d', [[<C-U><C-R>=printf('FzfCommand --rg %s %s', expand('<cword>'), v:lua.GetFileDir())<CR>]])
	cmd_gen('<leader>fa', [[<C-U><C-R>='FzfCommand --rg '.expand('<cword>')<CR>]])

	-- diffview.nvim
	cmd('<leader><leader>d', [[exe('DiffviewOpen -- '.v:lua.GetFileDir())]])
	cmd('<leader><leader>c', 'call v:lua.DiffViewFile()')

	-- compe
	local expr_opts = { expr = true }
	mapkey('i', '<Tab>', 'v:lua.tab_complete()', expr_opts)
	mapkey('i', '<S-Tab>', 'v:lua.s_tab_complete()', expr_opts)
	mapkey('i', '<CR>', [[compe#confirm({'keys': "\<Plug>delimitMateCR", 'mode': ''})]],
		{ expr = true, noremap = true }
	)

	-- lspsaga
	cmd('<M-r>', 'Lspsaga lsp_finder')
	cmd('<M-k>', "Lspsaga hover_doc")
	cmd('<leader>rn', 'Lspsaga rename')
	cmd('<leader>j', "lua require('lspsaga.action').smart_scroll_with_saga(1)")
	cmd('<leader>ca', 'Lspsaga code_action')
	cmd('<leader><leader>p', 'Lspsaga preview_definition')
	cmd('<M-o>', 'Lspsaga show_line_diagnostics')
	ino('<M-k>', '<cmd>Lspsaga signature_help<CR>')

	-- lsp
	cmd('<M-j>', 'lua vim.lsp.buf.definition()')
	cmd('<space>wa', 'lua vim.lsp.buf.add_workspace_folder()')
	cmd('<space>wr', 'lua vim.lsp.buf.remove_workspace_folder()')
	cmd('<space>wl', 'lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))')
	cmd('<space>a', 'lua vim.lsp.diagnostic.show_line_diagnostics()')
	cmd("<leader><space>f", "lua vim.lsp.buf.formatting()")
	vn("<leader><space>f", "<cmd>lua vim.lsp.buf.range_formatting()<cr>")
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

-- Rg search
--xn <leader>fa :<C-U><C-R>=printf("FzfCommand --rg %s", RgVisual())<CR>
-- function! RgVisual()
-- 	try
-- 		let x_save = getreg("x", 1)
-- 		let type = getregtype("x")
-- 		norm! gv"xy
-- 		return '"' . escape(@x, '"') . '"'
-- 	finally
-- 		call setreg("x", x_save, type)
-- 	endtry
-- endfunction

