local M = {}
local cfg = require("plugins.lspconfig").cfg()

function M.config()
  local group = "user_java"
  local jar = vim.fn.glob("/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
  vim.api.nvim_create_augroup(group, { clear = true })
  vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern = { "java" },
    group = group,
    callback = function()
      require("plugins.java").jdtls_start(jar)
    end,
  })
end

function M.jdtls_start(jar)
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local root_dir
  local config = vim.fn.stdpath("cache") .. "/jdtls/config_linux"
  local data = vim.fn.stdpath("cache") .. "/jdtls_workspace/" .. project_name
  local android = (vim.env["ANDROID_SDK_ROOT"] ~= nil)
  local java_home = "/usr/lib/jvm/java-18-openjdk"

  local cmd = {
    java_home .. "/bin/java",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Djava.import.generatesMetadataFilesAtProjectRoot=false",
    "-Dfile.encoding=utf8",
    "-Dlog.protocol=true",
    "-XX:+UseParallelGC",
    "-XX:GCTimeRatio=4",
    "-XX:AdaptiveSizePolicyWeight=90",
    "-Dsun.zip.disableMemoryMapping=true",
    "-Xmx1G",
    "-Xms100m",
    "-Xlog:disable",
    "-jar",
    jar,
    "-configuration",
    config,
    "-data",
    data,
  }

  if android then
    root_dir = require("jdtls.setup").find_root({ "gradlew", ".git" })
  else
    root_dir = require("jdtls.setup").find_root({ "build.gradle", "mvnw" })
  end

  local lsp_config = {
    cmd = cmd,
    root_dir = root_dir,
  }

  if android then
    lsp_config.settings = {
      java = {
        --autobuild = { enabled = true },
        signatureHelp = { enabled = true },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        home = java_home,
        jdt = {
          ls = {
            androidSupport = {
              enabled = true,
            },
            protobufSupport = {
              enabled = true,
            },
          },
        },
        import = {
          gradle = {
            enabled = true,
            wrapper = {
              enabled = true,
            },
            java = {
              home = "/usr/lib/jvm/java-11-openjdk",
            },
          },
        },
      },
    }

    -- There is a bug in jdtls, it should set GRADLE_HOME to newer version for the first time,
    -- and then set the correct version that android declared
    local sha = vim.fn.system("sha256sum gradle/wrapper/gradle-wrapper.jar")
    if sha ~= nil then
      sha = string.sub(sha, 0, string.find(sha, " "))
      lsp_config.settings.java.imports = {
        gradle = {
          wrapper = {
            checksums = {
              { sha256 = sha, allowed = true },
            },
          },
        },
      }
    end
  end

  require("jdtls").start_or_attach(vim.tbl_extend("force", lsp_config, cfg))
end

return M
