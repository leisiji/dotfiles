local M = {}

function M.config()
  require("grug-far").setup({
    startInInsertMode = false,
    debounceMs = 1000,
  })
  vim.keymap.set("n", "<leader>d", function()
    require("grug-far").open({
      prefills = { search = vim.fn.expand("<cword>"), paths = vim.fn.fnamemodify(vim.fn.expand("%:p:h"), ":.") },
    })
  end, { noremap = true, silent = true })
end

return M
