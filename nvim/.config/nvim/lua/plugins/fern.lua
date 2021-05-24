local M = {}

function _G.MyInitFern()
  local o = { silent = true }
  local map = vim.api.nvim_buf_set_keymap

  local nn = function (lhs, rhs)
    map(0, 'n', lhs, rhs, o)
  end

  nn('t', '<Plug>(fern-action-open:tabedit)')
  nn('v', '<Plug>(fern-action-open:vsplit)')
  nn('R', 'gg<Plug>(fern-action-reload)<C-o>')
  nn('l', '<Plug>(fern-action-expand)')
  nn('h', '<Plug>(fern-action-collapse)')
  nn('A', '<Plug>(fern-action-new-dir)')
  nn('a', '<Plug>(fern-action-new-file)')
  nn('D', '<Plug>(fern-action-remove)')
  nn('r', '<Plug>(fern-action-rename)')
  nn('q', ':<C-u>quit<CR>')
  nn('z', '<Plug>(fern-action-zoom:half)')
  nn('Z', '<Plug>(fern-action-zoom:reset)')
  nn('.', '<Plug>(fern-action-hidden:toggle)')
end

function M.config()
  vim.g['fern#disable_default_mappings'] = 1

  vim.cmd[[
    augroup fern
      autocmd!
      au FileType fern call v:lua.MyInitFern()
    augroup END
  ]]
end

return M
