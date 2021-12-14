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

-- %#GalaxyViMode#%{luaeval('require("galaxyline").component_decorator')("ViMode")}%#Galaxyfunc#%{luaeval('require("galaxyline").component_decorator')("func")}%=%#BufferTypeSeparator# | %#GalaxyBufferType#%{luaeval('require("galaxyline").component_decorator')("BufferType")}%#MaxLineSeparator# | %#GalaxyMaxLine#%{luaeval('require("galaxyline").component_decorator')("MaxLine")}

function M.vi_mode()
  local mode = vi_modes[vim.fn.mode()]
  vim.cmd('hi ViMode guifg='..mode[1])
  return mode[2]
end

function M.lsp_func()
  return 'λ '..vim.b.current_func_name
end

function M.config()
  local vi_mode = [[%#ViMode#%{luaeval('require("plugins.myline").vi_mode()')}]]
  local current_func = [[%#MyLspFunc#%{luaeval('require("plugins.myline").lsp_func()')}]]
  vim.wo.statusline = vi_mode .. current_func
end

return M
