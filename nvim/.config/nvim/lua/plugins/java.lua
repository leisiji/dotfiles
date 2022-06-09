local M = {}
local android_sdk_env = "ANDROID_SDK_ROOT"
local cfg = require("plugins.lspconfig").cfg()

local function jls_setup()
  local android_sdk = vim.env[android_sdk_env] .. "/platforms/android-30/android.jar"

  require("lspconfig").java_language_server.setup(vim.tbl_extend("force", cfg, {
    cmd = { "java-language-server" },
    settings = {
      java = {
        classPath = { android_sdk },
        --externalDependencies = get_deps('settings.json')
      },
    },
  }))
end

local function find_file(path, pattern)
  local scan = require("plenary.scandir")
  local files = scan.scan_dir(path, { hidden = true, depth = 1 })
  for _, jar in ipairs(files) do
    if string.find(jar, pattern) then
      return jar
    end
  end
end

function M.config()
  --if vim.env[android_sdk_env] then
  --  jls_setup()
  --else
  local jar = find_file("/usr/share/java/jdtls/plugins", "org.eclipse.equinox.launcher_[%w%p]+.jar")
  local group = "user_java"
  vim.api.nvim_create_augroup(group, { clear = true })
  vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern = { "java" },
    group = group,
    callback = function()
      require("plugins.java").jdtls_start(jar)
    end,
  })
  --end
end

function M.jdtls_start(jar)
  coroutine.wrap(function ()
    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        jar,
        "-configuration",
        vim.fn.stdpath("cache") .. "/jdtls/config_linux",
        "-data",
        vim.fn.getcwd() .. "/jdtls_workspace",
      },
      root_dir = require("jdtls.setup").find_root({ "build.gradle", "mvnw", "gradlew" }),
    }
    vim.wait(10000, function()
      return vim.g.gradle_set_classpath
    end, 1000)
    vim.fn['classpath#generateClasspath']()

    require("jdtls").start_or_attach(vim.tbl_extend("force", config, cfg))
  end)()
end

return M
