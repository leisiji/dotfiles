local M = {}

function M.config()
  require("gitsigns").setup({
    watch_gitdir = {
      interval = 5000,
      follow_files = true,
    },
    signs_staged_enable = false,
    diff_opts = {
      vertical = true,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "<leader><leader>n", function()
        if vim.wo.diff then
          return "<leader><leader>n"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "<leader><leader>N", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })
      map("n", "<leader><leader>b", function()
        gs.blame_line({ full = true })
      end)

      map("n", "<leader><leader>s", function()
        local wins = vim.api.nvim_tabpage_list_wins(0)
        for _, win in ipairs(wins) do
          if vim.w[win].gitsigns_preview == "blame" then
            local buffer = vim.api.nvim_win_get_buf(win)
            local line = vim.api.nvim_buf_get_lines(buffer, 0, 1, false)
            local commit = string.sub(line[1], 1, 8)
            vim.cmd(string.format("DiffviewOpen %s^!", commit))
            break
          end
        end
      end)
    end,
  })
end

return M
