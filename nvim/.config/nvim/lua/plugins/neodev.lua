local M = {}

function M.config()
  require("neodev").setup({})
  -- then setup your lsp server as usual
  local cfg = require("plugins.lspconfig").cfg()
  local lspconfig = require("lspconfig")
  local neodev_cfg = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  }
  lspconfig.sumneko_lua.setup(vim.tbl_extend("force", neodev_cfg, cfg))
end

return M
