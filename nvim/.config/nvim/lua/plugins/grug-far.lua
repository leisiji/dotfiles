local M = {}

function M.config()
  require("grug-far").setup({
    startInInsertMode = false,
    debounceMs = 1000,
    resultLocation = {
      showNumberLabel = false,
    },
    prefills = {
      flags = "-w",
    },
  })
  vim.keymap.set("n", "<leader>d", function()
    require("grug-far").open({
      prefills = { search = vim.fn.expand("<cword>"), paths = vim.fn.fnamemodify(vim.fn.expand("%:p:h"), ":.") },
    })
  end, { noremap = true, silent = true })

  vim.api.nvim_create_user_command("MyGrugFar", function(param)
    require("grug-far").open({
      windowCreationCommand = "tabe",
      prefills = {
        search = param.fargs[1],
      },
    })
    vim.api.nvim_set_option_value("number", true, { win = 0 })
  end, {
    nargs = 1,
    range = true,
  })
end

return M
