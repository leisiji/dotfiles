local M = {}

local function open(paths, search)
  require("grug-far").open({
    windowCreationCommand = "tabe",
    prefills = {
      flags = "-w",
      paths = paths,
      search = search,
    },
  })
  vim.api.nvim_set_option_value("number", true, { win = 0 })
end

function M.git_dir(cwd)
  return vim.system({ "git", "rev-parse", "--show-toplevel" }, { cwd = cwd, text = true }):wait().stdout
end

function M.find_refs()
  local dir = M.git_dir(vim.fn.expand("%:p:h"))
  local word = vim.fn.expand("<cword>")
  local filetype = vim.bo.filetype

  -- Map filetype to rule file
  local rule_map = {
    c = "find-references-c.yml",
    cpp = "find-references-c.yml",
    lua = "find-references-lua.yml",
  }

  local rule_file = rule_map[filetype] or "find-references-c.yml"
  local rule_path = vim.fn.stdpath("config") .. "/ast-grep/" .. rule_file

  local rules = vim.fn.readfile(vim.fn.expand(rule_path))
  local rule_text = table.concat(rules, "\n")
  local rules_word = rule_text:gsub("FUNC_NAME", word)

  require("grug-far").open({
    engine = "astgrep-rules",
    windowCreationCommand = "tabe",
    prefills = {
      -- paths = dir,
      rules = rules_word,
    },
  })
end

function M.search_cur_dir()
  require("grug-far").open({
    prefills = {
      flags = "-w",
      search = vim.fn.expand("<cword>"),
      paths = vim.fn.fnamemodify(vim.fn.expand("%:p:h"), ":."),
    },
  })
end

function M.config()
  require("grug-far").setup({
    startInInsertMode = false,
    debounceMs = 1000,
    resultLocation = {
      showNumberLabel = false,
    },
    history = {
      autoSave = {
        enabled = false,
      },
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("grug-far-keybindings", { clear = true }),
    pattern = { "grug-far" },
    callback = function()
      vim.keymap.set("n", "<C-o>", function()
        local grug = require("grug-far")
        local instance = grug.get_instance(0)
        instance:goto_location()
        instance:close()
      end, { buffer = true })
    end,
  })

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
