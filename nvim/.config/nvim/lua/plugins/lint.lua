local M = {}

function M.config()
  local lint = require("lint")
  local linters = {
    markdown = { "markdownlint" },
  }
  lint.linters_by_ft = linters

  local md = require("lint.linters.markdownlint")
  md.args = {
    "-c",
    vim.fn.stdpath("config") .. "/.markdownlint.jsonc",
  }

  local group = "nvim_lint"
  local a = vim.api
  a.nvim_create_augroup(group, { clear = true })
  a.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
    group = group,
    pattern = { "*.md" },
    callback = function()
      lint.try_lint()
    end,
  })
  vim.diagnostic.config({ virtual_text = false, underline=false })
end

return M
