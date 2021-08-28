local M = {}

function M.config()
  local luadev = require("lua-dev").setup()
  local lspconfig = require('lspconfig')
  luadev.cmd = {
    '/usr/bin/lua-language-server',
    '-E', '-e', 'LANG=EN',
    '/usr/share/lua-language-server/main.lua'
  }
  luadev.on_attach = require('plugins.lspconfig').cfg().on_attach
  lspconfig.sumneko_lua.setup(luadev)
end

return M
