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

local default_cfg = { on_attach = on_attach }

local function init_keymap()
	local mapkey = vim.api.nvim_set_keymap
	local opts = { noremap = true, silent = true }

	mapkey('n', '<M-j>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)

	-- lspsaga
	mapkey('n', '<M-r>', '<cmd>Lspsaga lsp_finder<cr>', opts)
	mapkey('n', '<M-k>', "<cmd>Lspsaga hover_doc<cr>", opts)
	mapkey('n', '<leader>j', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", opts)
	mapkey('n', '<space>rn', '<cmd>Lspsaga rename<cr>', opts)
	mapkey('n', '<space>ca', '<cmd>Lspsaga code_action<cr>', opts)
	mapkey('n', '<C-h>', '<cmd>Lspsaga signature_help<cr>', opts)

	mapkey('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
	mapkey('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
	mapkey('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
	mapkey('n', '<space>a', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)

	mapkey("n", "<leader><space>f", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
	mapkey("v", "<leader><space>f", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", opts)
end

local function setup_lsp(lspconfig)
	lspconfig.sumneko_lua.setup {
		cmd = {
			'/usr/bin/lua-language-server',
			'-E', '-e', 'LANG=EN',
			'/usr/share/lua-language-server/main.lua'
		};
		settings = {
			Lua = {
				diagnostics = {
					enable = true,
					globals = { "vim" }
				},
				runtime = { version = "LuaJIT" },
				workspace = {
					library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true},{}),
				},
			},
		};
		on_attach = on_attach;
	}

	lspconfig.ccls.setup(default_cfg)
	lspconfig.pyright.setup(default_cfg)
	lspconfig.cmake.setup(default_cfg)
	lspconfig.bashls.setup(default_cfg)
end

local function setup_config(lspconfig)
	local global_capabilities = vim.lsp.protocol.make_client_capabilities()
	global_capabilities.textDocument.completion.completionItem.snippetSupport = true
	global_capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			'documentation',
			'detail',
			'additionalTextEdits',
		}
	}

	lspconfig.util.default_config = vim.tbl_extend(
		"force",
		lspconfig.util.default_config,
		{ capabilities = global_capabilities }
	)
end

function M.init_lsp()
	local guibg = COLORS.yellow
	local guifg = COLORS.bg
	local exec = vim.cmd
	local lspconfig = require('lspconfig')

	exec('hi LspReferenceRead guibg=' .. guibg .. ' guifg=' .. guifg)
	exec('hi LspReferenceWrite guibg=' .. guibg .. ' guifg=' .. guifg)
	exec('hi LspReferenceText guibg=' .. guibg .. ' guifg=' .. guifg)
	init_keymap()

	setup_config(lspconfig)
	setup_lsp(lspconfig)
end

function M.completion_setup()
	vim.g.completion_enable_snippet = 'snippets.nvim'
	vim.g.completion_matching_smart_case = 1
	vim.g.completion_trigger_keyword_length = 3
	vim.g.completion_timer_cycle = 500

	require('completion').on_attach()
	vim.api.nvim_exec([[
		augroup completion_setup
			autocmd!
			autocmd BufEnter * lua require'completion'.on_attach()
		augroup END
	]], false)

	vim.g.completion_chain_complete_list = {
		default = {
			{ complete_items = { 'lsp', 'buffers', 'snippet' } },
			{ mode = { '<c-p>' } },
			{ mode = { '<c-n>' } }
		}
	}
end

function M.snippet()
	require'snippets'.use_suggested_mappings()
end

return M
