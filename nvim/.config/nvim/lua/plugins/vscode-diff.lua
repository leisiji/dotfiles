local M = {}

function M.config()
  require("vscode-diff").setup({
    keymaps = {
      view = {
        quit = "<leader>q",
        toggle_explorer = "<C-b>",
        next_hunk = "<leader><leader>n",
        prev_hunk = "<leader><leader>N",
        next_file = "<leader><leader>f",
        prev_file = "<leader><leader>F",
      },
      explorer = {
        select = "<CR>", -- Open diff for selected file
        hover = "K", -- Show file diff preview
        refresh = "R", -- Refresh git status
        toggle_view_mode = "i", -- Toggle between 'list' and 'tree' views
      },
    },
  })
end

return M
