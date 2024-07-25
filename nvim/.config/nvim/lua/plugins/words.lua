local M = {}

function M.config()
  require("interestingwords").setup({
    colors = { "#8CCBEA", "#A4E57E", "#FFDB72", "#FF7272", "#FFB3FF", "#9999FF" },
    cancel_color_key = "<leader><leader>k",
    search_key = "<leader>n",
  })
end

return M
