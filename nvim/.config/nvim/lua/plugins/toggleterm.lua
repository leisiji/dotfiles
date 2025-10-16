local M = {}

-- 全局变量来跟踪最后活动的终端
local last_active_terminal = nil

function toggle_direction()
  local terminals = require("toggleterm.terminal").get_all()
  for _, term in ipairs(terminals) do
    if term:is_open() then
      local new_direction = term.direction == "vertical" and "float" or "vertical"
      term:close()
      term.direction = new_direction
      term:open()
      return
    end
  end

  -- 如果没有打开的终端，打开一个默认方向的终端
  local c = vim.v.count1
  vim.cmd.ToggleTerm(c, "direction=vertical")
end

function M.config()
  require("toggleterm").setup({
    direction = "vertical",
    winbar = {
      enabled = true,
      name_formatter = function(term)
        return tostring(term.id)
      end,
    },
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
  })

  local group = "user_term"
  vim.api.nvim_create_augroup(group, { clear = true })

  vim.api.nvim_create_autocmd({ "TermEnter" }, {
    group = group,
    callback = function()
      local opts = { noremap = true, silent = true, buffer = true }
      vim.keymap.set("t", "<C-x>", function()
        vim.cmd("ToggleTermToggleAll")
      end, opts)

      vim.keymap.set("t", "<M-k>", function()
        M.next_terminal()
      end, opts)

      vim.keymap.set("t", "<M-a>", "<C-\\><C-n><C-w>w", opts)
      vim.keymap.set("t", "<M-t>", toggle_direction, opts)

      local term = require("toggleterm.terminal").get(vim.b.toggle_number)
      if term then
        last_active_terminal = term
      end
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "UnceptionEditRequestReceived",
    callback = function()
      vim.cmd("ToggleTermToggleAll")
    end,
  })
end

function M.toggle()
  local terminals = require("toggleterm.terminal").get_all()
  for _, term in ipairs(terminals) do
    if term:is_open() then
      vim.cmd("ToggleTermToggleAll")
      return
    end
  end

  if last_active_terminal == nil then
    local c = vim.v.count1
    vim.cmd.ToggleTerm(c, "direction=float")
  else
    last_active_terminal:open()
  end
end

function M.next_terminal()
  local terminals = require("toggleterm.terminal").get_all()
  if #terminals <= 1 then
    return
  end
  local current_idx = nil
  for i, term in ipairs(terminals) do
    if term:is_open() then
      current_idx = i
      break
    end
  end
  if not current_idx then
    terminals[1]:open()
    return
  end
  local next_idx = (current_idx % #terminals) + 1
  terminals[current_idx]:close()
  terminals[next_idx]:open()
end

function M.cd()
  local dir = vim.fn.expand("%:p:h")
  local cmd = string.format("TermExec cmd='cd %s' go_back=0 ", dir)
  cmd = cmd .. "direction=float"
  vim.cmd(cmd)
end

return M
