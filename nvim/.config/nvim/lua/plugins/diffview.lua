local M = {}

function M.config()
  local act = require("diffview.actions")

  local quit = function()
    vim.cmd("DiffviewClose")
  end

  require("diffview").setup({
    diff_binaries = false,
    enhanced_diff_hl = false,
    use_icons = false,
    file_panel = {
      win_config = {
        position = "left",
        width = 35,
        height = 10,
      },
      listing_style = "tree",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
    },
    key_bindings = {
      disable_defaults = false,
      view = {
        ["<tab>"] = act.select_next_entry,
        ["<S-tab>"] = act.select_prev_entry,
        ["<leader>q"] = quit,
      },
      file_panel = {
        ["<leader>q"] = quit,
      },
      file_history_panel = {
        ["<leader>q"] = quit,
      },
    },
  })
end

return M
