local M = {}

local colors = require("onedarkpro").get_colors("onedark")
local vi_modes = {
  n = { "#FFA066", "  NORMAL " },
  i = { "#98BB6C", "  INSERT " },
  v = { "#7E9CD8", "  VISUAL " },
  V = { "#7E9CD8", "  V-LINE " },
  [""] = { "#7E9CD8", "  VISUAL " },
  c = { "#957FB8", "  COMMAND " },
  t = { "#DCA561", "  TERMINAL " },
}

function M.vi_mode()
  local mode = vi_modes[vim.fn.mode()]
  if mode ~= nil then
    vim.api.nvim_set_hl(0, "ViMode", { fg = colors.black, bg = mode[1] })
    return mode[2]
  end
  return ""
end

function M.load()
  vim.b.current_func_name = ""
  local vi_mode = [[%#ViMode#%{luaeval('require("plugins.myline").vi_mode()')}]]
  local current_func = [[%#MyLspFunc#%{'  λ  '.b:current_func_name}]]
  local buffer_type = [[%#MyBufferTypeP#%{&filetype}]]
  local maxline = [[%#maxline#%{line('$')}]]
  vim.wo.statusline = vi_mode .. current_func .. "%=" .. " | " .. buffer_type .. " | " .. maxline .. " "
end

return M
