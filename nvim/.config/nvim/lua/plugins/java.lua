local M = {}
local android_sdk_env = "ANDROID_SDK_ROOT"
local cfg = require("plugins.lspconfig").cfg()

local function jls_setup()
  require("lspconfig").java_language_server.setup(vim.tbl_extend("force", cfg, {
    cmd = { "java-language-server" }, root_dir = require("lspconfig.util").root_pattern("gradlew")
  }))
end

function M.config()
  if vim.env[android_sdk_env] ~= nil then
    if vim.env["JAVA_HOME"] ~= nil then
      jls_setup()
    else
      vim.notify("Please set JAVA_HOME")
    end
  else
    local group = "user_java"
    vim.api.nvim_create_augroup(group, { clear = true })
    vim.api.nvim_create_autocmd({ "Filetype" }, {
      pattern = { "java" },
      group = group,
      callback = function()
        require("plugins.java").jdtls_start()
      end,
    })
  end
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

    require("jdtls").start_or_attach(vim.tbl_extend("force", config, cfg))
  end)()
end

return M
