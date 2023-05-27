local M = {}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "c", "lua", "vim", "query", "rust", "java",
      "cpp", "javascript", "cmake", "make", "bash", "markdown",
      "markdown_inline", "kotlin", "python", "typescript", "json",
      "json5", "jsonc", "vue", "devicetree", "go", "html", "gitcommit",
      "diff", "git_rebase", "toml", "yaml",
    },
    highlight = {
      enable = true,
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
    },
  })
end

return M
