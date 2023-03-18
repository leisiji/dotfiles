local M = {}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "help",
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
      "diff",
      "go",
      "html",
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
