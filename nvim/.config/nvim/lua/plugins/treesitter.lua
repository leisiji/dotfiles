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
  })
end

return M
