local group = "user_plugin"
local a = vim.api
a.nvim_create_augroup(group, { clear = true })

vim.g.last_active = a.nvim_get_current_tabpage()

local autocmds = {
  TabLeave = function()
    if a.nvim_win_get_config(a.nvim_get_current_win()).relative == '' then
      vim.g.last_active = a.nvim_get_current_tabpage()
    end
  end,
  FocusGained = function()
    vim.cmd("checkt")
  end,
  WinEnter = function()
    if vim.wo.cursorline == false then
      vim.wo.cursorline = true
    end
  end,
  TextYankPost = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 700 })
  end,
}
for key, value in pairs(autocmds) do
  a.nvim_create_autocmd({ key }, { group = group, callback = value })
end
