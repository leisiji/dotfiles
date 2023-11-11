local M = {}

function M.config()
  require("litee.lib").setup({
    panel = { orientation = "left", panel_size = 60 },
  })
  require("litee.calltree").setup({
    keymaps = {
      expand = "l",
      collapse = "h",
      collapse_all = "zM",
      jump = "<CR>",
      jump_split = "<C-s>",
      jump_vsplit = "<C-v>",
      jump_tab = "<C-t>",
      hover = "<M-k>",
      details = "d",
      close = "q",
      close_panel_pop_out = "<Esc>",
      hide = "H",
      switch = "S",
      focus = "f",
    },
    auto_highlight = false,
    no_hls = true,
  })
  local cmd = vim.api.nvim_create_user_command
  cmd("CallTreeI", vim.lsp.buf.incoming_calls, {})
  cmd("CallTreeO", vim.lsp.buf.outgoing_calls, {})
end

return M
