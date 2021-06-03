local M = {}
vim.g.completion_confirm_key = ""

_G.completion_confirm = function()
  local npairs = require('nvim-autopairs')
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end
function M.config()
  require('nvim-autopairs').setup()
end

return M
