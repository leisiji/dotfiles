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
      "vala",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
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
        lookahead = true,
        keymaps = {
          ["ap"] = "@parameter.outer",
          ["ip"] = "@parameter.inner",
        },
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_end = {
          ["]f"] = "@function.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
        },
      },
    },
  })
end

return M
