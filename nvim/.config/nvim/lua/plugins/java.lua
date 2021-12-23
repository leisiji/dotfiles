local M = {}
local android_sdk_env = 'ANDROID_SDK_ROOT'
local cfg = require('plugins.lspconfig').cfg()

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
  local config = {
    cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xms1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
      '-configuration', vim.fn.stdpath('cache') .. '/jdtls/config_linux',
      '-data', vim.fn.getcwd() .. '/jdtls_workspace'
    },
    root_dir = require('jdtls.setup').find_root({'build.gradle', 'mvnw', 'gradlew'}),
  }
  require('jdtls').start_or_attach(config)
end

return M
