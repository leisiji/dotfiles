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
    local _, i = string.find(args, "--nogit=")
    if i ~= nil then
      open(nil, string.sub(args, i + 1))
    else
      local paths = vim.fn.getcwd(0, 0)
      local is_file = vim.fn.filereadable(vim.fn.expand("%:p")) == 1
      if is_file then
        local dir = vim.fn.expand("%:p:h")
        local ret = vim.system({ "git", "rev-parse", "--show-toplevel" }, { cwd = dir, text = true }):wait()
        local git_dir = ret.stdout
        if git_dir ~= nil and paths ~= git_dir then
          paths = git_dir
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
