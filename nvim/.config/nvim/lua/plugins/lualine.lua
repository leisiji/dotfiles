require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "onedark",
    refresh = {
      tabline = 2000,
    },
  },
  sections = {
    lualine_c = { "navic" },
  },
})
