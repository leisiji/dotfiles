local M = {}
local android_sdk_env = 'ANDROID_SDK_ROOT'
local cfg = require('plugins.lspconfig').cfg

local function get_deps(path)
  local deps = {}

  if vim.fn.filereadable(path) == 1 then
    local f = io.open(path, 'r')
    local data = f.read(f, '*a')
    deps = vim.fn.json_decode(data)['java.externalDependencies']
    io.close(f)
  end

  return deps
end

local function jls_setup()
  local android_sdk = vim.env[android_sdk_env] .. '/platforms/android-30/android.jar'

  require('lspconfig').java_language_server.setup(
    vim.tbl_extend("force", cfg, {
      cmd = { 'java-language-server' },
      settings = {
        java = {
          classPath = { android_sdk },
          --externalDependencies = get_deps('settings.json')
        }
      }
    })
  )
end

function M.config()
  if vim.env[android_sdk_env] then
    jls_setup()
  else
    vim.api.nvim_exec([[
      augroup java
        au!
        au FileType java lua require('plugins.java').jdtls_start()
      augroup end
    ]], false)
  end
end

function M.jdtls_start()
  local jdtls_cfg = {
      cmd = { 'jdtls' },
      root_dir = require('jdtls.setup').find_root({'build.gradle', 'pom.xml'}),
      flags = { allow_incremental_sync = true },
      settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = 'fernflower' }
        }
      }
  }
  require('jdtls').start_or_attach(vim.tbl_extend("force", jdtls_cfg, cfg))
end

return M
