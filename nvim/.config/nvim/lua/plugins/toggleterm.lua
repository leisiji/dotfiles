local M = {}

function M.config()
  require("toggleterm").setup({
    winbar = {
      enabled = true,
      name_formatter = function(term)
        return tostring(term.id)
      end,
    },
    size = function(term)
      if term.direction == "horizontal" then
        return 10
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      else
        return 20
      end
    end,
  })
  local group = "user_term"
  vim.api.nvim_create_augroup(group, { clear = true })
  vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern = { "toggleterm" },
    group = group,
    callback = function()
      local opts = { noremap = true, silent = true, buffer = true }
      vim.keymap.set("t", "<C-x>", function()
        vim.cmd("ToggleTermToggleAll")
      end, opts)
      vim.keymap.set("t", "<M-a>", "<C-\\><C-n><C-w>w", opts)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "UnceptionEditRequestReceived",
    callback = function()
      vim.cmd("ToggleTermToggleAll")
    end,
  })
end

local function term_dir()
  local a = vim.api
  local floating = a.nvim_win_get_config(a.nvim_get_current_win()).relative ~= ''
  local wins = a.nvim_tabpage_list_wins(0)
  if floating or #wins > 1 then
    return "direction=float"
  end
  return "direction=vertical"
end

function M.toggle()
  local c = vim.v.count1
  vim.cmd.ToggleTerm(c, term_dir())
end

function M.exec()
  local dir = vim.fn.expand("%:p:h")
  local cmd = string.format("TermExec cmd='cd %s' go_back=0 ", dir)
  cmd = cmd .. term_dir()
  vim.cmd(cmd)
end

return M
