local M = {}

local clang_format = function()
  return {
    exe = "clang-format",
    args = { "--style=file" },
    stdin = true,
  }
end

function M.config()
  require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
      c = {
        clang_format,
      },
      cpp = {
        clang_format,
      },
      java = {
        function()
          return {
            exe = "google-java-format",
            args = { "-a", "-" },
            stdin = true,
          }
        end,
      },
      json = {
        function ()
          return {
            exe = "jq",
            args = { "--indent 4", "." },
            stdin = true,
          }
        end
      },
      rust = {
        require("formatter.filetypes.rust").rustfmt
      },
      python = {
        function()
          return {
            exe = "black",
            args = { "-" },
            stdin = true,
          }
        end,
      },
      lua = {
        function()
          local util = require("formatter.util")
          return {
            exe = "stylua",
            args = {
              "--search-parent-directories",
              "--stdin-filepath",
              util.escape_path(util.get_current_buffer_file_path()),
              "--",
              "-",
            },
            stdin = true,
          }
        end,
      },
    },
  })
end

return M
