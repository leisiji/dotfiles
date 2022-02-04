local M = {}

function M.config()
  local null_ls = require('null-ls')
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.json_tool,
      --null_ls.builtins.formatting.clang_format,
      --null_ls.builtins.formatting.google_java_format,
      null_ls.builtins.diagnostics.markdownlint
    }
  })
end

return M
