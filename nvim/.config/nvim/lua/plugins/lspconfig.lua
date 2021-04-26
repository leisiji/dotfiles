local M = {}

local on_attach = function(client, _)

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec([[
			augroup lsp_document_highlight
				autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]], false)
	end
end

local function init_keymap()
	local mapkey = vim.api.nvim_set_keymap
	local opts = { noremap = true, silent = true }

	--mapkey('n', '<C-j>', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	--mapkey('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	--mapkey('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	mapkey('n', '<M-j>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	mapkey('n', '<M-k>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	mapkey('n', '<M-r>', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	mapkey('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	mapkey('n', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	mapkey('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	mapkey('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	mapkey('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	mapkey('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	mapkey('n', '<space>a', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

	mapkey("n", "<leader><space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	mapkey("v", "<leader><space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
end

local function lua_lsp()
	local lspconfig = require('lspconfig')

	lspconfig.sumneko_lua.setup {
		filetypes = { 'lua' };
		cmd = {
			'/usr/bin/lua-language-server',
			'-E', '-e', 'LANG=EN',
			'/usr/share/lua-language-server/main.lua'
		};
		settings = {
			Lua = {
				diagnostics = {
					enable = true,
					globals = { "vim", "packer_plugins" }
				},
				runtime = { version = "LuaJIT" },
				workspace = {
					library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true},{}),
				},
			},
		};
		on_attach = on_attach
	}

	lspconfig.ccls.setup {
		filetypes = { 'c', 'cpp' };
		root_dir = lspconfig.util.root_pattern('compile_commands.json');
	}
end

function M.init()
	--vim.g.completion_enable_snippet = 'snippets.nvim'
	vim.g.completion_trigger_keyword_length = 2
	vim.g.completion_timer_cycle = 500

	local guibg = COLORS.yellow
	local guifg = COLORS.bg
	local exec = vim.api.nvim_exec

	exec('hi LspReferenceRead guibg=' .. guibg .. ' guifg=' .. guifg)
	exec('hi LspReferenceWrite guibg=' .. guibg .. ' guifg=' .. guifg)
	exec('hi LspReferenceText guibg=' .. guibg .. ' guifg=' .. guifg)
	init_keymap()

	lua_lsp()
end

function M.completion_setup()
	vim.g.completion_enable_snippet = 'snippets.nvim'
	require('completion').on_attach()
	vim.api.nvim_exec([[
		augroup completion_setup
			autocmd!
			autocmd BufEnter * lua require'completion'.on_attach()
		augroup END
	]], false)
end

function M.completion_buffer()
	vim.g.completion_chain_complete_list = {
		default = {
			{ complete_items = { 'lsp', 'buffers' } },
			{ mode = { '<c-p>' } },
			{ mode = { '<c-n>' } }
		}
	}
end

function M.snippet()
	require'snippets'.use_suggested_mappings()
end

return M
