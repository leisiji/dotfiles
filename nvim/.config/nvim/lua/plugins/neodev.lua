local M = {}

function M.config()
  require("neodev").setup({})
  -- then setup your lsp server as usual
  local lspconfig = require("lspconfig")
  lspconfig.sumneko_lua.setup({
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
end

return M
