local M = {}

local on_attach = function(client, _)
  -- cursor hightlight and hint function name in statusline
  if client.resolved_capabilities.document_highlight then
    vim.cmd([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        au CursorHold <buffer> lua require('plugins.current_function').update()
        au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end
end

local cap = vim.lsp.protocol.make_client_capabilities()
local completion = cap.textDocument.completion.completionItem
completion.snippetSupport = true
completion.resolveSupport = { properties = { 'documentation', 'detail', 'additionalTextEdits' } }
local default_cfg = { on_attach = on_attach, capabilities = cap }

local diagnosticls = {
  filetypes = { 'markdown' };
  init_options = {
    linters = {
      markdownlint = {
        command = 'markdownlint', rootPatterns = { '.git' },
        isStderr = true, debounce = 1000, offsetLine = 0, offsetColumn = 0,
        args = { '--stdin' }, sourceName = 'markdownlint', securities = { undefined = 'hint' }, formatLines = 1,
        formatPattern = {
          [[^.*?:\s?(\d+)(:(\d+)?)?\s(MD\d{3}\/[A-Za-z0-9-/]+)\s(.*)$]],
          { line = 1, column = 3, message = { 4 } }
        },
      }
    },
    filetypes = { markdown = 'markdownlint' }
  },
}

local function all_lsp_config(lsp)
  lsp.diagnosticls.setup(diagnosticls)
  lsp.clangd.setup({
    cmd = { 'clangd', '--background-index', '--clang-tidy', '--clang-tidy-checks=performance-*,bugprone-*',
      '--all-scopes-completion', '--completion-style=detailed', '--header-insertion=iwyu' },
    on_attach = on_attach, capabilities = cap
  })
  lsp.pyright.setup(default_cfg)
  lsp.cmake.setup(default_cfg)
  lsp.bashls.setup(default_cfg)
  lsp.vimls.setup(default_cfg)
  lsp.kotlin_language_server.setup(default_cfg)
  lsp.gopls.setup(default_cfg)
end

local function lsp_basic()
  local bg = COLORS.yellow
  local fg = COLORS.bg
  local exec = vim.cmd
  local lsp = vim.lsp

  exec('hi LspReferenceRead guibg=' .. bg .. ' guifg=' .. fg)
  exec('hi LspReferenceWrite guibg=' .. bg .. ' guifg=' .. fg)
  exec('hi LspReferenceText guibg=' .. bg .. ' guifg=' .. fg)

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

M.cfg = default_cfg

return M
