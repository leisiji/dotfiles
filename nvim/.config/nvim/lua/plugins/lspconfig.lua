local M = {}
local default_cfg
local group = "lsp_document_highlight"
local a = vim.api

local on_attach = function(client, _)
  -- cursor hightlight and hint function name in statusline
  if client.server_capabilities.documentHighlightProvider then
    local bufnr = a.nvim_get_current_buf()
    a.nvim_clear_autocmds({ group = group, buffer = bufnr })
    local autocmds = {
      CursorHold = function()
        vim.lsp.buf.document_highlight()
        require("plugins.current_function").update()
      end,
      CursorMoved = vim.lsp.buf.clear_references,
    }
    for key, value in pairs(autocmds) do
      a.nvim_create_autocmd({ key }, { group = group, callback = value, buffer = bufnr })
    end
  end
end

local function all_lsp_config(lsp)
  a.nvim_create_augroup(group, { clear = true })
  local cap = vim.lsp.protocol.make_client_capabilities()
  local compe = cap.textDocument.completion.completionItem
  compe.snippetSupport = true
  compe.preselectSupport = true
  compe.insertReplaceSupport = true
  compe.labelDetailsSupport = true
  compe.deprecatedSupport = true
  compe.commitCharactersSupport = true
  compe.resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } }
  default_cfg = {
    on_attach = on_attach,
    capabilities = cap,
    flags = {
      debounce_text_changes = 500,
    },
  }

  lsp.clangd.setup({
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--clang-tidy-checks=performance-*,bugprone-*",
      "--all-scopes-completion",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
    },
    on_attach = on_attach,
    capabilities = cap,
  })

  local servers = {
    "pyright",
    "cmake",
    "bashls",
    "vimls",
    "kotlin_language_server",
    "gopls",
    "rust_analyzer",
    "tsserver",
  }
  for _, server in pairs(servers) do
    lsp[server].setup(default_cfg)
  end
end

local function lsp_basic()
  local lsp = vim.lsp
  lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "single" })
  lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = "single" })
end

function M.lsp_config()
  coroutine.wrap(function()
    local lsp = require("lspconfig")
    lsp_basic()
    all_lsp_config(lsp)
  end)()
end

function M.cfg()
  return default_cfg
end

return M
