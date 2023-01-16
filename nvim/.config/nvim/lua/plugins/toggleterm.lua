local M = {}

function M.config()
  require("toggleterm").setup({
    winbar = {
      enabled = true,
      name_formatter = function(term)
        return tostring(term.id)
      end,
    },
    direction = "vertical",
    size = function(term)
      if term.direction == "horizontal" then
        return 15
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

return M
