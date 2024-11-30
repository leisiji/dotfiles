local M = {}

local function open(paths, search)
  require("grug-far").open({
    windowCreationCommand = "tabe",
    prefills = {
      paths = paths,
      search = search,
    },
  })
  vim.api.nvim_set_option_value("number", true, { win = 0 })
end

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
    local args = param.fargs[1]
    if args == "--zoxide" then
      coroutine.wrap(function()
        local choices = require("fzf").fzf("zoxide query --list", "--preview='eza -l --color=always {1}'")
        if choices == nil then
          return
        end
        open(choices[1], nil)
      end)()
    else
      local paths = nil
      local is_file = vim.fn.filereadable(vim.fn.expand("%:p")) == 1
      if is_file then
        local cwd = vim.fn.getcwd(0)
        local dir = vim.fn.expand("%:p:h")
        if string.sub(dir, 0, #cwd) ~= cwd then
          paths = vim.fn.system("cd " .. dir .. " && git rev-parse --show-toplevel")
          print(paths)
        end
      end
      open(paths, args)
    end
  end, {
    nargs = 1,
    range = true,
  })
end

return M
