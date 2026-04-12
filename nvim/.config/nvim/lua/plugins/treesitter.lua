local M = {}

function M.config()
  require("nvim-treesitter").setup({
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
      disable = function(_, buf)
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
