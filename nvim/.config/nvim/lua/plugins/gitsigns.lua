local M = {}

function M.blame_line()
  require("gitsigns").blame_line({ full = true }, function()
    local bufnr = vim.api.nvim_get_current_buf()

    vim.keymap.set("n", "<leader><leader>s", function()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      for _, win in ipairs(wins) do
        if vim.w[win].gitsigns_preview == "blame" then
          local buffer = vim.api.nvim_win_get_buf(win)
          local line = vim.api.nvim_buf_get_lines(buffer, 0, 1, false)
          local commit = string.sub(line[1], 1, 8)
          vim.cmd(string.format("CodeDiff %s %s~1", commit, commit))
          break
        end
      end
    end, { buffer = bufnr })
  end)
end

function M.config()
  require("gitsigns").setup({
    watch_gitdir = {
      interval = 5000,
      follow_files = true,
    },
    signs_staged_enable = false,
    sign_priority = 9,
    diff_opts = {
      vertical = true,
    },
    preview_config = {
      border = "rounded",
    },
  })
end

return M
