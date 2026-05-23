local M = {}

function M.config()
  require("tree-sitter-manager").setup({
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
      "python",
      "typescript",
      "json",
      "json5",
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
      "zsh",
      "fish",
    },
  })
  vim.keymap.set({ "x", "o" }, "ik", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects")
  end, { desc = "Treesitter: inside block" })

  vim.keymap.set({ "n", "x", "o" }, "[f", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
  end)

  vim.keymap.set({ "n", "x", "o" }, "]f", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
  end)
end

return M
