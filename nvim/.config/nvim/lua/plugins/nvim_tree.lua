local M = {}

function M.setup()
  vim.g.nvim_tree_gitignore = 0
  vim.g.nvim_tree_git_hl = 0
  vim.g.nvim_tree_show_icons = { git = 0, folders = 1, folder_arrows = 1, }
  local tree_cb = require'nvim-tree.config'.nvim_tree_callback
  vim.g.nvim_tree_bindings = {
    { key = "l",     cb = tree_cb("edit") },
    { key = "h",     cb = tree_cb("close_node") },
    { key = "<C-]>", cb = tree_cb("cd") },
    { key = "<C-[>", cb = tree_cb("dir_up") },
    { key = "<C-v>", cb = tree_cb("vsplit") },
    { key = "<C-x>", cb = tree_cb("split") },
    { key = "<C-t>", cb = tree_cb("tabnew") },
    { key = ".",     cb = tree_cb("toggle_dotfiles") },
    { key = "R",     cb = tree_cb("refresh") },
    { key = "a",     cb = tree_cb("create") },
    { key = "D",     cb = tree_cb("remove") },
    { key = "r",     cb = tree_cb("rename") },
    { key = "x",     cb = tree_cb("cut") },
    { key = "c",     cb = tree_cb("copy") },
    { key = "p",     cb = tree_cb("paste") },
    { key = "y",     cb = tree_cb("copy_name") },
    { key = "Y",     cb = tree_cb("copy_path") },
    { key = "gy",    cb = tree_cb("copy_absolute_path") },
    { key = "q",     cb = tree_cb("close") },
  }
end

return M
