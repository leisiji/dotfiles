local M = {}

function M.config()
  require("neo-tree").setup({
    enable_git_status = false,
    enable_diagnostics = false,
    window = {
      mappings = {
        ["l"] = {
          "toggle_node",
          nowait = false,
        },
        ["<enter>"] = "open",
        ["<cr>"] = "open",
        ["<esc>"] = "cancel",
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["<C-t>"] = "open_tab_drop",
        ["h"] = "close_node",
        ["a"] = {
          "add",
          config = {
            show_path = "none",
          },
        },
        ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
        ["D"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["<M-k>"] = "show_file_details",
      },
    },
  })
end

return M
