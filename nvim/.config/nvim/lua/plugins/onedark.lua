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
    colors = {
      my_new_red = "require('onedarkpro.helpers').darken('red', 15, 'onedark')"
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
      PmenuSel = { fg = "${fg}", bg = "#404040" },

      BufferCurrent = { fg = "${fg}", bg = "#404040" },
      BufferCurrentSign = { fg = "${fg}", bg = "#404040" },
      BufferCurrentMod = { fg = "#e5c07b", bg = "#404040" },
      BufferCurrentADDED = { fg = "#109868", bg = "#404040" },
      BufferCurrentCHANGED = { fg = "#948b60", bg = "#404040" },
      BufferCurrentDELETED = { fg = "#9a353d", bg = "#404040" },
      BufferCurrentERROR = { fg = "#ef596f", bg = "#404040" },
      BufferCurrentIndex = { fg = "#61afef", bg = "#404040" },

      -- Pmenu = { bg = "#202020" },
      Macro = { fg = "${orange}" },
      Enum = { fg = "${cyan}" },
      ["@property"] = { fg = "${white}" },
      ["@variable"] = { fg = "${red}" },
      ["@parameter"] = { fg = "${my_new_red}" },
      BlinkCmpMenuBorder = { fg = "${blue}" },
      BlinkCmpDocBorder = { fg = "${blue}" },
    },
  })
  vim.cmd("colorscheme onedark_dark")
end

return M
