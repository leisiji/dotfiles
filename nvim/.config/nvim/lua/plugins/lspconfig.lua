local M = {}
local default_cfg
local group = "lsp_document_highlight"
local a = vim.api

local on_attach = function(client, bufnr)
  local caps = client.server_capabilities

  a.nvim_clear_autocmds({ group = group, buffer = bufnr })

  if caps.documentHighlightProvider then
    a.nvim_create_autocmd({ "CursorMoved" }, {
      group = group,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
      buffer = bufnr,
    })
    a.nvim_create_autocmd({ "CursorHold" }, {
      group = group,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
      buffer = bufnr,
    })
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
    cmd = { "clangd", "-j=4", "--header-insertion=never" },
    on_attach = on_attach,
    capabilities = cap,
    filetypes = { "c", "cpp" },
  })

  local servers = {
    "pyright",
    "cmake",
    "bashls",
    "vimls",
    "kotlin_language_server",
    "gopls",
    "rust_analyzer",
    "ts_ls",
    "jsonls",
    "vala_ls",
  }
  for _, server in pairs(servers) do
    lsp[server].setup(default_cfg)
  end
  vim.lsp.inlay_hint.enable(true)
end

function M.lsp_config()
  coroutine.wrap(function()
    local lsp = require("lspconfig")
    all_lsp_config(lsp)
  end)()
end

function M.cfg()
  return default_cfg
end

return M
