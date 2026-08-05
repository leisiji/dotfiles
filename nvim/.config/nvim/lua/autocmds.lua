local group = "user_plugin"
vim.api.nvim_create_augroup(group, { clear = true })

local autocmds = {
  WinEnter = function()
    if vim.wo.cursorline == false then
      vim.wo.cursorline = true
    end
  end,
  TextYankPost = function()
    local hl = vim.hl.hl_op or vim.highlight.on_yank
    hl({ higroup = "IncSearch", timeout = 500 })
  end,
  TermEnter = function()
    vim.cmd("setlocal mouse-=n")
  end,
  TermLeave = function()
    vim.cmd("setlocal mouse+=n")
    vim.cmd("checkt")
  end,
  FocusGained = function ()
    vim.cmd("checkt")
  end
}
for key, value in pairs(autocmds) do
  vim.api.nvim_create_autocmd({ key }, { group = group, callback = value })
end
