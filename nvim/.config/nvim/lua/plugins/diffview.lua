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
    keymaps = {
      disable_defaults = false,
      view = {
        { "n", "<tab>", act.select_next_entry, { desc = "next" } },
        { "n", "<S-tab>", act.select_prev_entry, { desc = "prev" } },
        { "n", "<leader>q", quit, { desc = "quit" } },
        { "n", "<C-b>", act.toggle_files, { desc = "Toggle" } },
      },
      file_panel = {
        { "n", "<leader>q", quit, { desc = "quit" } },
        { "n", "<C-b>", act.toggle_files, { desc = "Toggle" } },
      },
      file_history_panel = {
        { "n", "<leader>q", quit, { desc = "quit" } },
        { "n", "<M-k>", act.open_commit_log, { desc = "log" } },
      },
    },
    file_history_panel = {
      log_options = {
        git = {
          single_file = {
            no_merges = true,
          },
          multi_file = {
            no_merges = true,
          },
        },
      },
    },
  })
end

return M
