local M = {}

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.config = {
  keymap = {
    preset = "none",
    ["<M-k>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<Tab>"] = {
      function(cmp)
        if cmp.is_menu_visible() then
          return cmp.select_next()
        elseif has_words_before() then
          return cmp.show()
        end
      end,
      "fallback",
    },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  signature = { enabled = true },
  completion = {
    accept = { auto_brackets = { enabled = true } },
    list = { selection = { preselect = false, auto_insert = true } },
    keyword = { range = "full" },
    menu = { border = "rounded" },
    documentation = { window = { border = "rounded" } },
  },
  fuzzy = {
    prebuilt_binaries = {
      ignore_version_mismatch = true,
    },
  },
  cmdline = {
    keymap = {
      preset = "none",
      ["<Tab>"] = {
        function(cmp)
          if cmp.is_menu_visible() then
            return cmp.select_next()
          elseif has_words_before() then
            return cmp.show()
          end
        end,
        "show_and_insert",
      },
      ["<S-Tab>"] = { "show_and_insert", "select_prev" },
      ["<C-j>"] = { "select_next" },
      ["<C-k>"] = { "select_prev" },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      menu = {
        auto_show = function(_)
          return vim.fn.getcmdtype() == ":"
        end,
      },
    },
  },
}

return M
