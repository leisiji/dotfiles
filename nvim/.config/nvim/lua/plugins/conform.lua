local M = {}

function M.format()
  require("conform").format({ async = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    end
  end)
end

function M.config()
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt", lsp_format = "fallback" },
      json = { "jq" },
      c = { "clang-format" },
      cpp = { "clang-format" },
    },
  })
  require("conform").formatters["jq"] = {
    prepend_args = { "--indent", "4" },
  }
  require("conform").formatters["clang-format"] = {
    args = { "--style=file" },
  }
end

return M
