local M = {}

function M.mapkeys()
  local opts = { noremap = true, silent = true }
  local keymaps = {
    {'l', 'expand_calltree()'},
    {'h', 'collapse_calltree()'},
    {'<cr>', 'jump_calltree()'},
    {'<C-t>', "jump_calltree('tab')"},
    {'<M-k>', 'hover_calltree()'},
  }
  for _, v in ipairs(keymaps) do
    local rhs = [[:lua require('litee.calltree').]] .. v[2] .. '<cr>'
    vim.api.nvim_buf_set_keymap(0, 'n', v[1], rhs, opts)
  end
end

function M.config()
  require('litee.lib').setup({
    panel = { orientation = "left", panel_size  = 80 }
  })
  require('litee.calltree').setup({})
  vim.cmd[[
    command! CallTreeI lua vim.lsp.buf.incoming_calls()
    command! CallTreeO lua vim.lsp.buf.outgoing_calls()
  ]]
  vim.cmd[[
    augroup my_calltree
      autocmd!
      au Filetype calltree lua require('plugins.calltree').mapkeys()
    augroup END
  ]]
end

return M
