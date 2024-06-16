local M = {}

function M.config()
  require("gitsigns").setup({
    watch_gitdir = {
      interval = 5000,
      follow_files = true,
    },
    signs_staged_enable = false,
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
    end,
  })
end

return M
