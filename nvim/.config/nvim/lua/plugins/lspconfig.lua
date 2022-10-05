local M = {}
local default_cfg
local group = "lsp_document_highlight"
local a = vim.api

local on_attach = function(client, bufnr)
  local caps = client.server_capabilities
  if caps.documentHighlightProvider then
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
  if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.semantic_tokens_full()
      end,
    })
    vim.lsp.buf.semantic_tokens_full()
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

local function highlight()
  -- reference: coc.nvim
  local hl_map = {
    LspNamespace = { "TSNamespace", "Include" },
    LspType = { "TSType", "Type" },
    LspClass = { "TSConstructor", "Special" },
    LspEnum = { "TSEnum", "Type" },
    LspInterface = { "TSInterface", "Type" },
    LspStruct = { "TSStruct", "Identifier" },
    LspTypeParameter = { "TSParameter", "Identifier" },
    LspParameter = { "TSParameter", "Identifier" },
    LspVariable = { "TSSymbol", "Identifier" },
    LspProperty = { "TSProperty", "Identifier" },
    LspEnumMember = { "TSEnumMember", "Constant" },
    LspEvent = { "TSEvent", "Keyword" },
    LspFunction = { "TSFunction", "Function" },
    LspMethod = { "TSMethod", "Function" },
    LspMacro = { "TSConstMacro", "Define" },
    LspKeyword = { "TSKeyword", "Keyword" },
    LspModifier = { "TSModifier", "StorageClass" },
    LspComment = { "TSComment", "Comment" },
    LspString = { "TSString", "String" },
    LspNumber = { "TSNumber", "Number" },
    LspRegexp = { "TSStringRegex", "String" },
    LspOperator = { "TSOperator", "Operator" },
    LspDecorator = { "TSSymbol", "Identifier" },
    LspDeprecated = { "TSStrike", "Error" },
  }

  for key, value in pairs(hl_map) do
    local hi
    if vim.fn.hlexists(value[1]) then
      hi = value[1]
    else
      hi = value[2]
    end
    vim.cmd("hi default link " .. key .. " " .. hi)
  end
end

function M.lsp_config()
  coroutine.wrap(function()
    local lsp = require("lspconfig")
    lsp_basic()
    all_lsp_config(lsp)
    highlight()
  end)()
end

function M.cfg()
  return default_cfg
end

return M
