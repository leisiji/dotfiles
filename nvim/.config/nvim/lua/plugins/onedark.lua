local M = {}

function M.config()
  local onedarkpro = require("onedarkpro")
  onedarkpro.setup({
    theme = "onedark_dark",
    options = {
      cursorline = true,
      bold = true,
      italic = true,
      highlight_inactive_windows = true,
    },
    plugins = {
      all = false,
      treesitter = true,
      nvim_cmp = true,
      gitsigns = true,
      nvim_tree = true,
      lsp_semantic_tokens = true,
      nvim_lsp = true,
      toggleterm = true,
    },
    filetypes = {
      rust = false,
    },
    highlights = {
      PmenuSel = { fg = "${fg}", bg = "#303030" },
      Macro = { fg = "${orange}" },
      Enum = { fg = "${cyan}" },
      ["@property"] = { fg = "${white}" },
    },
  })
  vim.cmd("colorscheme onedark_dark")
end

return M
