local M = {}

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local autocomplete

M.config = {
  highlight = {
    use_nvim_cmp_as_default = true,
  },
  nerd_font_variant = "normal",
  keymap = {
    ["<M-k>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<Tab>"] = {
      function(cmp)
        if autocomplete == nil then
          autocomplete = require("blink.cmp.windows.autocomplete")
        end
        if autocomplete.win:is_open() then
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
    completion = {
      enabled_providers = { "lsp", "path", "snippets", "buffer" },
    },
  },
  windows = {
    autocomplete = {
      selection = "auto_insert",
    },
  },
}

return M
