vim.g.mapleader = " "

-- avoid loading inner plugins
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_fzf = 1
vim.g.loaded_gtags = 1
vim.g.loaded_gtags_cscope = 1

local mapkey = vim.api.nvim_set_keymap
local keymap_opts = { noremap = true, silent = true }
local format = string.format
local fn = vim.fn
local exec = vim.cmd

-------------------- Global Function ---------------------------------------
function _G.mytabline()
  local pagenum = fn.tabpagenr("$")
  local s = ""
  local i = 1
  while i <= pagenum do
    if i == fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end
    s = s .. " " .. tostring(i) .. "."
    local bufnr = fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
    local path = fn.bufname(bufnr)
    s = s .. fn.fnamemodify(path, ":t")
    if fn.getbufvar(bufnr, "&modified") == 1 then
      s = s .. "+"
    else
      s = s .. " "
    end
    s = s .. "%#TabLineFill#%T"
    i = i + 1
  end
  return s
end

local function zoom_toggle()
  local zoom = vim.t.zoom
  if zoom ~= nil and zoom == 1 then
    exec(vim.t.zoom_winrestcmd)
    vim.t.zoom = 0
  else
    vim.t.zoom_winrestcmd = fn.winrestcmd()
    exec("resize | vertical resize")
    vim.t.zoom = 1
  end
end

local function quit()
  local bufnrs = fn.win_findbuf(fn.bufnr())
  if #bufnrs > 1 or fn.expand("%") == "" or fn.tabpagenr("$") == 1 then
    exec("q")
  else
    exec("bd")
  end
end

local function show_documents()
  local filetype = vim.bo.filetype
  local word = fn.expand("<cword>")

  if filetype == "vim" or filetype == "lua" or filetype == "help" then
    exec("vertical h " .. word)
  else
    exec("vertical Man " .. word)
  end
end

-------------------- keymaps ---------------------------------------
local function cmd_gen(lhs, rhs)
  local gen_opts = { noremap = true }
  mapkey("n", lhs, format(":%s", rhs), gen_opts)
end
local function cmd(v)
  mapkey("n", v[1], format("<cmd>%s<cr>", v[2]), keymap_opts)
end
local function ino(v)
  mapkey("i", v[1], v[2], keymap_opts)
end
local function nn(v)
  mapkey("n", v[1], v[2], keymap_opts)
end
local function vn(v)
  mapkey("v", v[1], v[2], keymap_opts)
end
local function tn(v)
  mapkey("t", v[1], v[2], keymap_opts)
end
local function fmap(v)
  vim.keymap.set("n", v[1], v[2], keymap_opts)
end

local function init_nvim_keys()
  local nn_maps = {
    { "<M-a>", "<C-w>w" },
    { "H", "^" },
    { "L", "$" },
    { "<C-j>", "5j" },
    { "<C-k>", "5k" },
    { "<M-e>", "5e" },
    { "<M-b>", "5b" },
    { "<M-w>", "5w" },
    { "<M-y>", "<C-r>" },
    { "<leader>p", '"+p' },
  }
  local vn_maps = {
    { "H", "^" },
    { "L", "g_" },
    { "<C-j>", "5j" },
    { "<C-k>", "5k" },
    { "<M-e>", "5e" },
    { "<M-b>", "5b" },
    { "<leader>y", '"+y' },
  }
  local cmd_maps = {
    { "<leader>s", "w" },
    { "<M-l>", "tabn" },
    { "<M-h>", "tabp" },
    { "<leader><leader>q", "qa" },
    { "<leader>rt", "%retab!" },
    { "<M-s>", [[let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>]] }, -- remove trailing whitespace
    { "<leader>L", "20winc >" },
    { "<leader>H", "20winc <" },
    { "<leader>K", "10winc +" },
    { "<leader>J", "10winc -" },
  }
  local func_maps = {
    { "<leader>q", quit },
    { "K", show_documents },
    { "<leader>z", zoom_toggle },
    {
      "<M-q>",
      function()
        vim.cmd("tabn " .. vim.g.last_active_tab)
      end,
    },
    { "<M-k>", vim.lsp.buf.hover },
    { "<leader>rn", vim.lsp.buf.rename },
    { "<leader>ca", vim.lsp.buf.code_action },
    { "<leader>a", vim.diagnostic.goto_next },
    {
      "<M-o>",
      function()
        vim.diagnostic.open_float({ border = "single" })
      end,
    },
    {
      "<C-r>",
      function()
        local bufnr = vim.api.nvim_get_current_buf()
        local client = vim.lsp.get_active_clients({ bufnr = bufnr })
        if client ~= nil and #client ~= 0 then
          vim.cmd("FzfCommand --lsp document_symbol")
        else
          vim.cmd("FzfCommand --ctags")
        end
      end,
    },
  }
  local ino_maps = {
    { "<C-j>", "<Down>" },
    { "<C-k>", "<Up>" },
    -- insert mode like bash
    { "<C-b>", "<Left>" },
    { "<C-f>", "<Right>" },
    { "<C-a>", "<Home>" },
    { "<C-e>", "<End>" },
    { "<C-d>", "<Delete>" },
    { "<C-h>", "<Backspace>" },
    { "<M-b>", "<C-Left>" },
    { "<M-f>", "<C-Right>" },
    { "<M-d>", "<C-o>diw" },
  }
  local cno_maps = {
    { "<M-b>", "<C-Left>" },
    { "<M-f>", "<C-Right>" },
    { "<C-b>", "<Left>" },
    { "<C-f>", "<Right>" },
    { "<C-d>", "<Delete>" },
    { "<C-a>", "<Home>" },
    { "<C-e>", "<End>" },
  }

  for _, v in ipairs(nn_maps) do
    nn(v)
  end
  for i = 1, 9, 1 do
    nn({ format("<M-%d>", i), format("%dgt", i) })
  end
  for _, v in ipairs(vn_maps) do
    vn(v)
  end
  for _, v in ipairs(cmd_maps) do
    cmd(v)
  end
  for _, v in ipairs(ino_maps) do
    ino(v)
  end
  for _, v in ipairs(func_maps) do
    fmap(v)
  end
  for _, v in ipairs(cno_maps) do
    vim.keymap.set("c", v[1], v[2], { noremap = true })
  end

  tn({ "<M-e>", "<C-\\><C-n>" })
end

local function init_plugins_keymaps()
  local cmds = {
    -- terminal
    { "<C-x>", "FTermToggle" },

    { "<leader>e", "FeMaco" },

    -- nvim tree
    { "<leader>tj", "NvimTreeFindFile" },
    { "<leader>tr", "NvimTreeToggle" },

    -- interestingwords
    { "<leader>k", "Interestingwords --toggle" },
    { "<leader><leader>k", "Interestingwords --remove_all" },
    { "<leader>n", "Interestingwords --navigate" },
    { "<leader>N", "Interestingwords --navigate b" },

    -- fzf_utils
    { "<C-p>", "FzfCommand --files" },
    { "<C-f>", "FzfCommand --lines" },
    { "<leader>b", "FzfCommand --buffers" },
    { "<leader><leader>m", "FzfCommand --man" },
    { "<leader><leader>h", "FzfCommand --vim help" },
    { "<leader>h", "FzfCommand --vim cmdHists" },
    { "<leader>ft", "FzfCommand --vim filetypes" },
    { "<leader>fu", "FzfCommand --gtags --update" },
    { "<leader>fb", "FzfCommand --gtags --update-buffer" },
    { "<leader>fr", [[exe("FzfCommand --gtags -r ".expand("<cword>"))]] },
    { "<leader>fd", [[exe('FzfCommand --gtags -d '.expand('<cword>'))]] },
    { "<M-f>", [[exe('FzfCommand --rg --all-buffers '.expand('<cword>'))]] },
    { "<leader>ff", [[exe('FzfCommand --rg '.expand('<cword>')." ".expand('%'))]] },
    { "<leader>ws", "FzfCommand --lsp workspace_symbol" },
    { "<leader>m", "FzfCommand --mru" },
    { "<leader>gc", "FzfCommand --commit" },
    { "<leader><leader>z", "FzfCommand --zoxide" },

    { "<leader>gr", "Glance references" },
    { "<M-r>", "FzfCommand --lsp ref tab drop" },
    { "<M-j>", "FzfCommand --lsp jump_def edit" },
    { "<M-t>", "FzfCommand --lsp jump_def tab drop" },
    { "<M-v>", "FzfCommand --lsp jump_def vsplit" },

    -- others
    { "<leader><leader>p", "GotoPreview" },
    { "<leader>v", "SymbolsOutline" },
    { "<leader><leader>d", "DiffviewOpen --untracked-files=true -- %" },
  }

  for _, v in pairs(cmds) do
    cmd(v)
  end

  cmd_gen("<leader>gl", [[<C-U><C-R>=printf('FzfCommand --live_grep %s', fnamemodify(expand("%:p:h"), ":."))<CR>]])

  -- easy align
  mapkey("x", "ga", ":EasyAlign<cr>", {})

  cmd_gen(
    "<leader>d",
    [[<C-U><C-R>=printf('FzfCommand --rg %s %s', expand('<cword>'), fnamemodify(expand("%:p:h"), ":."))<CR>]]
  )
  cmd_gen("<leader>fa", [[<C-U><C-R>='FzfCommand --rg '.expand('<cword>')<CR>]])

  -- lsp
  vim.keymap.set("i", "<M-k>", vim.lsp.buf.signature_help, keymap_opts)

  vim.keymap.set("c", "<C-k>", "<S-Tab>", { noremap = true })
end

init_nvim_keys()

-- options
if vim.g.vscode then
  return
end

local global_cfg = {
  hidden = true,
  backup = false,
  writebackup = false,
  autoread = true,
  autowrite = true,
  smarttab = true,
  smartindent = true,
  scrolloff = 10,
  undofile = true,
  incsearch = true,
  ignorecase = true,
  smartcase = true,
  termguicolors = true,
  laststatus = 2,
  showtabline = 2,
  updatetime = 500,
  shortmess = "aoOTIcF",
  completeopt = "menu,menuone,noselect",
  tabline = "%!v:lua.mytabline()",
  expandtab = true,
  cmdheight = 0,
  -- foldmethod = "expr",
  -- foldexpr = "nvim_treesitter#foldexpr()",
}
local win_cfg = {
  signcolumn = "yes",
  number = true,
  cul = true,
}
local buf_cfg = {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
  swapfile = false,
  undofile = true,
  mouse = "",
  expandtab = true,
}
for k, v in pairs(global_cfg) do
  vim.o[k] = v
end
for k, v in pairs(win_cfg) do
  vim.wo[k] = v
end
for k, v in pairs(buf_cfg) do
  vim.opt[k] = v
end

require("plugins")
require("autocmds")

init_plugins_keymaps()

vim.cmd([[
  set list lcs=tab:→\ ,trail:·
]])

vim.g.clipboard = {
  name = "tmuxClipboard",
  copy = { ["+"] = { "tmux", "load-buffer", "-" }, ["*"] = { "tmux", "load-buffer", "-" } },
  paste = { ["+"] = { "tmux", "save-buffer", "-" }, ["*"] = { "tmux", "save-buffer", "-" } },
}

vim.g.unception_open_buffer_in_new_tab = true
