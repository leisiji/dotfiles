local group = "user_plugin"
local a = vim.api
a.nvim_create_augroup(group, { clear = true })
local autocmds = {
  TabLeave = function()
    vim.g.last_active_tab = a.nvim_tabpage_get_number(0)
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
