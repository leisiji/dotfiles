local M = {}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "query",
      "rust",
      "java",
      "cpp",
      "javascript",
      "cmake",
      "make",
      "bash",
      "markdown",
      "markdown_inline",
      "kotlin",
      "python",
      "typescript",
      "json",
      "json5",
      "jsonc",
      "vue",
      "devicetree",
      "go",
      "html",
      "gitcommit",
      "diff",
      "git_rebase",
      "toml",
      "yaml",
      "vimdoc",
      "mermaid",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = function(lang, buf)
        local max_filesize = 500 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_end = {
          ["]f"] = "@function.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
        },
      },
    },
  })
  vim.keymap.set({ "x", "o" }, "ik", function()
    require("nvim-treesitter.textobjects.select").select_textobject("@block.inner", "textobjects")
  end, { desc = "Treesitter: inside block" })

  vim.keymap.set("n", "[c", function()
    local shared = require("nvim-treesitter.textobjects.shared")
    local _, _, node = shared.textobject_at_point("@conditional.outer", "textobjects")
    if node then
      local start_row, start_col = node:start()
      vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
    end
  end, { desc = "Jump to current conditional start" })

  vim.keymap.set("n", "]c", function()
    local shared = require("nvim-treesitter.textobjects.shared")
    local _, _, node = shared.textobject_at_point("@conditional.outer", "textobjects")
    if node then
      local end_row, end_col = node:end_()
      vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
    end
  end, { desc = "Jump to current conditional end" })
end

return M
