local M = {}

function M.config()
  require('litee.lib').setup({
    panel = { orientation = "left", panel_size  = 80 },
  })
  require('litee.calltree').setup({
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
      focus = "f"
    },
  })
  vim.cmd[[
    command! CallTreeI lua vim.lsp.buf.incoming_calls()
    command! CallTreeO lua vim.lsp.buf.outgoing_calls()
  ]]
end

return M
