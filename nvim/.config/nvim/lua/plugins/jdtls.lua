local M = {}

function M.config()
  vim.api.nvim_exec([[
    augroup java
      au!
      au FileType java lua require('plugins.jdtls').start()
    augroup end
  ]], false)
end

function M.start()
  local fn = vim.fn
  local cache = fn.stdpath('cache') .. '/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  require('jdtls').start_or_attach(
    {
      cmd = { 'jdtls', cache },
      root_dir = require('jdtls.setup').find_root({'build.gradle'})
    }
  )
end

return M
