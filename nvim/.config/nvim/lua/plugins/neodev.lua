local M = {}

function M.config()
  require("neodev").setup({})
  local cfg = require("plugins.lspconfig").cfg()
  local lspconfig = require("lspconfig")
  local neodev_cfg = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        hint = {
          enable = true,
          setType = true,
        },
      },
    },
  }
  cfg = vim.tbl_extend("force", neodev_cfg, cfg)
  lspconfig.lua_ls.setup(cfg)
end

return M
