local M = {}
local default_cfg
local group = "lsp_document_highlight"
local a = vim.api

local on_attach = function(client, bufnr)
  local caps = client.server_capabilities
  local navic = require("nvim-navic")

  local highlight = caps.documentHighlightProvider

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  a.nvim_clear_autocmds({ group = group, buffer = bufnr })
  a.nvim_create_autocmd({ "CursorMoved" }, {
    group = group,
    callback = function()
      if highlight then
        vim.lsp.buf.clear_references()
      end
    end,
    buffer = bufnr,
  })

  a.nvim_create_autocmd({ "CursorHold" }, {
    group = group,
    callback = function()
      if highlight then
        vim.lsp.buf.document_highlight()
      end
      vim.b.current_func_name = navic.get_location()
    end,
    buffer = bufnr,
  })
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
    on_attach = on_attach,
    capabilities = cap,
    filetypes = { 'c', 'cpp' },
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
    "jsonls",
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
