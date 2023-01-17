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
      native_lsp = true,
      gitsigns = true,
      nvim_tree = true,
    },
    filetypes = {
      rust = false,
    },
    highlights = {
      PmenuSel = { fg = "${fg}", bg = "#303030" },
    },
    semantic_tokens = {
      default = {
        ["@macro"] = { fg = "${orange}" },
        ["@struct"] = { fg = "${yellow}" },
        ["@defaultLibrary"] = { fg = "" },
        ["@enum"] = { fg = "${cyan}" },
        ["@property"] = { fg = "${white}" },
      },
    },
  })
  vim.cmd("colorscheme onedark_dark")
end

return M
