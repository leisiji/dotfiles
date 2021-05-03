local M = {}

local on_attach = function(client, _)

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec([[
			augroup lsp_document_highlight
				autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorHold <buffer> lua require('plugins.current_function').update()
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
	mapkey('i', '<M-k>', '<cmd>Lspsaga signature_help<CR>', opts)
	mapkey('n', '<leader>j', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", opts)
	mapkey('n', '<leader>rn', '<cmd>Lspsaga rename<cr>', opts)
	mapkey('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', opts)
	mapkey('n', '<leader><leader>p', '<cmd>Lspsaga preview_definition<cr>', opts)

	mapkey('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
	mapkey('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
	mapkey('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
	mapkey('n', '<space>a', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)

	mapkey("n", "<leader><space>f", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
	mapkey("v", "<leader><space>f", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", opts)
end

local function setup_lsp(lsp)
	lsp.sumneko_lua.setup {
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

	lsp.ccls.setup {
		init_options = {
			cache = { directory = '/tmp/ccls' }
		}
	}
	lsp.pyright.setup(default_cfg)
	lsp.cmake.setup(default_cfg)
	lsp.bashls.setup(default_cfg)
	lsp.vimls.setup(default_cfg)
end

local function setup_config(lsp)
	local global_cap = vim.lsp.protocol.make_client_capabilities()
	global_cap.textDocument.completion.completionItem.snippetSupport = true
	global_cap.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			'documentation',
			'detail',
			'additionalTextEdits',
		}
	}

	lsp.util.default_config = vim.tbl_extend(
		"force",
		lsp.util.default_config,
		{ capabilities = global_cap }
	)
end

function M.init_lsp()
	local guibg = COLORS.yellow
	local guifg = COLORS.bg
	local exec = vim.cmd
	local lsp = require('lspconfig')

	exec('hi LspReferenceRead guibg=' .. guibg .. ' guifg=' .. guifg)
	exec('hi LspReferenceWrite guibg=' .. guibg .. ' guifg=' .. guifg)
	exec('hi LspReferenceText guibg=' .. guibg .. ' guifg=' .. guifg)
	init_keymap()

	setup_config(lsp)
	setup_lsp(lsp)
end

function M.completion_setup()
	vim.g.completion_enable_snippet = 'snippets.nvim'
	vim.g.completion_matching_smart_case = 1
	vim.g.completion_trigger_keyword_length = 3
	vim.g.completion_timer_cycle = 500
	vim.g.completion_matching_strategy_list = { 'fuzzy' }

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

function M.setup_lspsaga()
	require 'lspsaga'.init_lsp_saga {
		max_preview_lines = 25,
		finder_action_keys = {
			open = '<cr>', vsplit = 'v', split = 's', quit = '<ESC>'
		},
	}
end

return M
