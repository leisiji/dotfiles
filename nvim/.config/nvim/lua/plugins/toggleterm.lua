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
      vim.keymap.set("t", "<M-1>", [[<cmd>lua require("toggleterm").cycle(-1)<cr>]], opts)
      vim.keymap.set("t", "<M-2>", [[<cmd>lua require("toggleterm").cycle(1)<cr>]], opts)
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
  local a = vim.api
  local c = vim.v.count1
  if a.nvim_win_get_width(a.nvim_get_current_win()) <= 100 then
    vim.cmd.ToggleTerm(c, "direction=float")
  else
    vim.cmd.ToggleTerm(c, "direction=vertical")
  end
end

return M
