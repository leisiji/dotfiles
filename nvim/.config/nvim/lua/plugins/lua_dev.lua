local M = {}
local initialized = false

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

function M.config()
  if initialized then
    return
  end
  initialized = true

  local lspconfig = require('lspconfig')
  local lua_conf = {
    cmd = {
      '/usr/bin/lua-language-server',
      '-E', '-e', 'LANG=EN',
      '/usr/share/lua-language-server/main.lua'
    },
    on_attach = require('plugins.lspconfig').cfg().on_attach,
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT', path = runtime_path },
        diagnostics = { globals = {'vim'} },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        telemetry = { enable = false },
      },
    },
  }
  lspconfig.sumneko_lua.setup(lua_conf)
end

return M
