local M = {}

function M.config()
  local cb = require'diffview.config'.diffview_callback
  require'diffview'.setup {
  diff_binaries = false,
  enhanced_diff_hl = false,
  use_icons = false,
  file_panel = {
    position = "left",
    width = 35,
    height = 10,
    listing_style = "tree",
    tree_options = {
      flatten_dirs = true,
      folder_statuses = "only_folded",
    },
  },
  file_history_panel = {
    position = "bottom",
    width = 35,
    height = 16,
    log_options = {
      max_count = 256,
      follow = false,
      all = false,
      merges = false,
      no_merges = false,
      reverse = false,
    },
  },
  key_bindings = {
    disable_defaults = false,
    view = {
      ["<tab>"]     = cb("select_next_entry"),
      ["<s-tab>"]   = cb("select_prev_entry"),
      ["gf"]        = cb("goto_file"),
      ["<C-w>s"]    = cb("goto_file_split"),
      ["<C-w>t"]    = cb("goto_file_tab"),
      ["<leader>e"] = cb("focus_files"),
      ["<leader>b"] = cb("toggle_files"),
    },
    file_panel = {
      ["j"]         = cb("next_entry"),
      ["k"]         = cb("prev_entry"),
      ["<cr>"]      = cb("select_entry"),
      ["-"]         = cb("toggle_stage_entry"),
      ["S"]         = cb("stage_all"),
      ["U"]         = cb("unstage_all"),
      ["X"]         = cb("restore_entry"),
      ["R"]         = cb("refresh_files"),
      ["<tab>"]     = cb("select_next_entry"),
      ["<s-tab>"]   = cb("select_prev_entry"),
      ["gf"]        = cb("goto_file"),
      ["<C-w>s"]    = cb("goto_file_split"),
      ["<C-w>t"]    = cb("goto_file_tab"),
      ["i"]         = cb("listing_style"),
      ["f"]         = cb("toggle_flatten_dirs"),
      ["<leader>e"] = cb("focus_files"),
      ["<leader>b"] = cb("toggle_files"),
    },
    file_history_panel = {
      ["g!"]        = cb("options"),
      ["<C-A-d>"]   = cb("open_in_diffview"),
      ["y"]         = cb("copy_hash"),
      ["zR"]        = cb("open_all_folds"),
      ["zM"]        = cb("close_all_folds"),
      ["j"]         = cb("next_entry"),
      ["k"]         = cb("prev_entry"),
      ["<cr>"]      = cb("select_entry"),
      ["o"]         = cb("select_entry"),
      ["<tab>"]     = cb("select_next_entry"),
      ["<s-tab>"]   = cb("select_prev_entry"),
      ["gf"]        = cb("goto_file"),
      ["<C-w>s"]    = cb("goto_file_split"),
      ["<C-w>t"]    = cb("goto_file_tab"),
      ["<leader>e"] = cb("focus_files"),
      ["<leader>b"] = cb("toggle_files"),
    },
    option_panel = {
      ["<tab>"] = cb("select"),
      ["q"]     = cb("close"),
    },
  },
}
end

return M
