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

function M.git_dir(cwd)
  return vim.system({ "git", "rev-parse", "--show-toplevel" }, { cwd = cwd, text = true }):wait().stdout
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
    history = {
      autoSave = {
        enabled = false,
      },
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
        local git_dir = M.git_dir(dir)
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
  -- if treesitter off, as grug-far will destroy treesitter highlighter and trigger syntax.vim's syntaxset group event to `set syntax=`
  vim.api.nvim_create_augroup("syntaxset", {
    clear = true,
  })
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = "syntaxset",
    command = "set syntax=on",
  })
end

return M
