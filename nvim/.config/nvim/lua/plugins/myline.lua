local M = {}

local colors = require("onedarkpro").get_colors("onedark")
local vi_modes = {
  n = { colors.orange, '  NORMAL ' },
  i = { colors.green, '  INSERT ' },
  v = { colors.blue, '  VISUAL ' },
  V = { colors.blue, '  V-LINE ' },
  [''] = { colors.blue, '  VISUAL ' },
  c = { colors.purple, '  COMMAND ' },
  t = { colors.yellow, '  TERMINAL ' },
}

function M.vi_mode()
  local mode = vi_modes[vim.fn.mode()]
  if mode ~= nil then
    vim.cmd('hi ViMode cterm=bold gui=bold guifg=' .. colors.black .. ' guibg='..mode[1])
    return mode[2]
  end
  return ''
end

function M.load()
  vim.b.current_func_name = ''
  local vi_mode = [[%#ViMode#%{luaeval('require("plugins.myline").vi_mode()')}]]
  local current_func = [[%#MyLspFunc#%{'  λ  '.b:current_func_name}]]
  local buffer_type = [[%#MyBufferTypeP#%{&filetype}]]
  local maxline = [[%#maxline#%{line('$')}]]
  vim.wo.statusline = vi_mode .. current_func .. '%=' .. ' | ' .. buffer_type .. ' | ' .. maxline .. ' '
end

return M
