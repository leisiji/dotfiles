local M = {}

function M.lsp_config()
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
    "clangd",
    "lua_ls",
  }
  for _, server in pairs(servers) do
    vim.lsp.enable(server, true)
  end

  vim.lsp.config("clangd", {
    cmd = { "clangd", "--header-insertion=never" },
  })

  vim.lsp.inlay_hint.enable(true)
  local group = vim.api.nvim_create_augroup("my.lsp", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      if client:supports_method("textDocument/documentHighlight") then
        vim.api.nvim_create_autocmd({ "CursorMoved" }, {
          group = group,
          callback = function()
            vim.lsp.buf.clear_references()
          end,
          buffer = args.buf,
        })
        vim.api.nvim_create_autocmd({ "CursorHold" }, {
          group = group,
          callback = function()
            vim.lsp.buf.document_highlight()
          end,
          buffer = args.buf,
        })
      end
    end,
  })
end

return M
