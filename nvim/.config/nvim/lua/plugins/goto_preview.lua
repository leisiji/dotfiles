local M = {}

function M.config()
  vim.api.nvim_create_user_command("GotoPreview", require("goto-preview").goto_preview_definition, {})
  require("goto-preview").setup({
    height = 30,
  })
end

return M
