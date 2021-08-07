local M = {}

function M.config()
  vim.cmd[[command! GotoPreview lua require('goto-preview').goto_preview_definition()]]
  require('goto-preview').setup {
    height = 30,
  }
end

return M
