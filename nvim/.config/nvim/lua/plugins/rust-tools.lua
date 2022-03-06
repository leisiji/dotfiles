local M = {}

function M.config()
  local opts = {
    tools = {
      autoSetHints = false,
      hover_with_actions = false,
      inlay_hints = {
        show_parameter_hints = false,
        parameter_hints_prefix = "",
        other_hints_prefix = "",
      },
    },
    server = {
      on_attach = require('plugins.lspconfig').cfg().on_attach,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
              command = "clippy"
          },
        }
      }
    },
  }
  require('rust-tools').setup(opts)
end

return M
