local M = {}

function M.keymaps()
  local keymaps = {
    {lhs = 'h', rhs = ':CTExpand<cr>'},
    {lhs = 'l', rhs = ':CTCollapse<cr>'},
    {lhs = '<cr>', rhs = ':CTJump<cr>'},
  }

  for _, v in ipairs(keymaps) do
    vim.api.nvim_buf_set_keymap(0, 'n', v.lhs, v.rhs, { noremap = true, silent = true })
  end
end

function M.config()
  require('calltree').setup({})
  vim.cmd[[
    command! CallTreeI lua vim.lsp.buf.incoming_calls()
    command! CallTreeO lua vim.lsp.buf.outgoing_calls()
  ]]
end

return M
