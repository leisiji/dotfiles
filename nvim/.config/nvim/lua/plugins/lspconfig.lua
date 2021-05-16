local M = {}

local on_attach = function(client, _)
	-- cursor hightlight and hint function name in statusline
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

local cap = vim.lsp.protocol.make_client_capabilities()
cap.textDocument.completion.completionItem.snippetSupport = true
cap.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	}
}
local default_cfg = { on_attach = on_attach, capabilities = cap }

local lua_cfg = {
	cmd = {
		'/usr/bin/lua-language-server',
		'-E', '-e', 'LANG=EN',
		'/usr/share/lua-language-server/main.lua'
	};
	settings = {
		Lua = {
			diagnostics = { enable = true, globals = { "vim" } },
			runtime = { version = "LuaJIT" },
			workspace = { library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true},{}), },
		},
	};
	on_attach = on_attach;
}

local diagnosticls = {
	filetypes = { 'markdown' };
	init_options = {
		linters = {
			markdownlint = {
				command = 'markdownlint',
				rootPatterns = { '.git' },
				isStderr = true, debounce = 1000,
				offsetLine = 0, offsetColumn = 0,
				args = { '--stdin' },
				sourceName = 'markdownlint',
				securities = { undefined = 'hint' },
				formatLines = 1,
				formatPattern = {
					[[^[^:]+:(\d+):*(\d*)(.*)$]],
					{ line = 1, column = -1, message = 3 }
				}
			}
		},
		filetypes = { markdown = 'markdownlint' }
	},
}

local function all_lsp_config(lsp)
	lsp.sumneko_lua.setup(lua_cfg)
	lsp.diagnosticls.setup(diagnosticls)

	local ccls_opts = {
		init_options = { cache = { directory = '/tmp/ccls' } },
		on_attach = on_attach, capabilities = cap
	}
	lsp.ccls.setup(ccls_opts)
	lsp.pyright.setup(default_cfg)
	lsp.cmake.setup(default_cfg)
	lsp.bashls.setup(default_cfg)
	lsp.vimls.setup(default_cfg)
	lsp.kotlin_language_server.setup(default_cfg)
end

local function lsp_basic()
	local guibg = COLORS.yellow
	local guifg = COLORS.bg
	local exec = vim.cmd
	local lsp = vim.lsp

	exec('hi LspReferenceRead guibg=' .. guibg .. ' guifg=' .. guifg)
	exec('hi LspReferenceWrite guibg=' .. guibg .. ' guifg=' .. guifg)
	exec('hi LspReferenceText guibg=' .. guibg .. ' guifg=' .. guifg)

	lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false, underline = true, signs = true,
			update_in_insert = false
		})
end

function M.lsp_config()
	coroutine.wrap(function ()
		local lsp = require('lspconfig')
		lsp_basic()
		all_lsp_config(lsp)
	end)();
end

function M.lspsaga_config()
	require 'lspsaga'.init_lsp_saga {
		max_preview_lines = 25,
		finder_action_keys = {
			open = '<cr>', vsplit = 'v', split = 's', quit = { 'q', '<ESC>' },
		},
	}
end

return M
