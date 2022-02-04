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
    logging = false,
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
            args = { "-i", "-a" },
            stdin = false,
          }
        end,
      },
      json = {
        function()
          return {
            exe = "python",
            args = { "-m", "json.tool" },
            stdin = true,
          }
        end,
      },
      rust = {
        function()
          return {
            exe = "rustfmt",
            args = { "--emit=stdout" },
            stdin = true,
          }
        end,
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
          return {
            exe = "stylua",
            args = {
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
