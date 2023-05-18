require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "onedark",
    refresh = {
      tabline = 500,
    },
  },
  sections = {
    lualine_c = { "navic" },
  },
})
