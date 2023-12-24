local M = {}

function M.config()
  require("toggleterm").setup({
    winbar = {
      enabled = true,
      name_formatter = function(term)
        return tostring(term.id)
      end,
    },
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

function M.toggle()
  local c = vim.v.count1
  vim.cmd.ToggleTerm(c, "direction=float")
end

function M.exec()
  local dir = vim.fn.expand("%:p:h")
  local cmd = string.format("TermExec cmd='cd %s' go_back=0 ", dir)
  cmd = cmd .. "direction=float"
  vim.cmd(cmd)
end

return M
