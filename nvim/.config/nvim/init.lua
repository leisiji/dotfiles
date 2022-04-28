vim.g.mapleader = " "
vim.g.did_load_filetypes = 1

-- avoid loading inner plugins
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_fzf = 1

local mapkey = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local format = string.format
local fn = vim.fn
local exec = vim.cmd

-------------------- Global Function ---------------------------------------
function _G.mytabline()
  local pagenum = fn.tabpagenr('$')
  local s = ''
  local i = 1
  while i <= pagenum  do
    if i == fn.tabpagenr() then
      s = s..'%#TabLineSel#'
    else
      s = s..'%#TabLine#'
    end
    s = s .. ' ' .. tostring(i) .. '.'
    local bufnr = fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
    local path = fn.bufname(bufnr)
    s = s .. fn.fnamemodify(path, ":t")
    if fn.getbufvar(bufnr, '&modified') == 1 then
      s = s .. '+'
    else
      s = s .. ' '
    end
    s = s .. '%#TabLineFill#%T'
    i = i + 1
  end
  return s
end

function _G.MyWinZoomToggle()
  local zoom = vim.t.zoom
  if zoom ~= nil and zoom == 1 then
    exec(vim.t.zoom_winrestcmd)
    vim.t.zoom = 0
  else
    vim.t.zoom_winrestcmd = fn.winrestcmd()
    exec('resize | vertical resize')
    vim.t.zoom = 1
  end
end

function _G.GetFileDir()
  return fn.fnamemodify(fn.expand('%:p:h'), ':.')
end

function _G.MyQuit()
  local bufnrs = fn.win_findbuf(fn.bufnr())
  if #bufnrs > 1 or fn.expand('%') == '' or fn.tabpagenr('$') == 1 then
    exec('q')
  else
    exec('bd')
  end
end

function _G.MyshowDocument()
  local filetype  = vim.bo.filetype
  local word = fn.expand('<cword>')

  if filetype == 'vim' or filetype == 'lua' or filetype == 'help' then
    exec('vertical h '..word)
  else
    exec('vertical Man '..word)
  end
end

-------------------- keymaps ---------------------------------------
local function cmd_gen(lhs, rhs)
  local gen_opts = { noremap = true }
  mapkey('n', lhs, format(':%s', rhs), gen_opts)
end

local function cmd(lhs, rhs) mapkey('n', lhs, format('<cmd>%s<cr>', rhs), opts) end
local function ino(lhs, rhs) mapkey('i', lhs, rhs, opts) end
local function nn(lhs, rhs) mapkey('n', lhs, rhs, opts) end
local function vn(lhs, rhs) mapkey('v', lhs, rhs, opts) end
local function tn(lhs, rhs) mapkey('t', lhs, rhs, opts) end
local function xcmd(lhs, rhs) mapkey('x', lhs, format(':%s<cr>', rhs), {}) end

local function init_nvim_keys()
  local nn_maps = {
    {'<M-a>', '<C-w>w'},
    {'H', '^'},
    {'L', '$'},
    {'<C-j>', '5j'},
    {'<C-k>', '5k'},
    {'<M-e>', '5e'},
    {'<M-b>', '5b'},
    {'<M-w>', '5w'},
    {'<M-y>', '<C-r>'},
    {'<leader>p', '"+p'},
  }
  local vn_maps = {
    {'H', '^'},
    {'L', 'g_'},
    {'<C-j>', '5j'},
    {'<C-k>', '5k'},
    {'<M-e>', '5e'},
    {'<M-b>', '5b'},
    {'<leader>y', '"+y'},
  }
  local cmd_maps = {
    {'<leader>s', 'w'},
    {'<M-l>', 'tabn'},
    {'<M-h>', 'tabp'},
    {'<leader><leader>q', 'qa'},
    {'<leader>q', 'call v:lua.MyQuit()'},
    {'K', 'call v:lua.MyshowDocument()'},
    {'<leader>rt', '%retab!'},
    {'<leader>z', 'call v:lua.MyWinZoomToggle()'},
    {'<M-q>', [[exe('tabn '.g:last_active_tab)]]},
    {'<M-s>', [[let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>]]}, -- remove trailing whitespace
    {'<leader>L', '20winc >'},
    {'<leader>H', '20winc <'},
    {'<leader>K', '10winc +'},
    {'<leader>J', '10winc -'},
  }
  local ino_maps = {
    {'<C-j>', '<Down>'},
    {'<C-k>', '<Up>'},
    -- insert mode like bash
    {'<C-b>', '<Left>'},
    {'<C-f>', '<Right>'},
    {'<C-a>', '<Home>'},
    {'<C-e>', '<End>'},
    {'<C-d>', '<Delete>'},
    {'<C-h>', '<Backspace>'},
    {'<M-b>', '<C-Left>'},
    {'<M-f>', '<C-Right>'},
    {'<M-d>', '<C-o>diw'},
  }

  for _, v in ipairs(nn_maps) do
    nn(v[1], v[2])
  end
  for i = 1, 9, 1 do
    nn(format('<M-%d>', i), format('%dgt', i))
  end
  for _, v in ipairs(vn_maps) do
    vn(v[1], v[2])
  end
  for _, v in ipairs(cmd_maps) do
    cmd(v[1], v[2])
  end
  for _, v in ipairs(ino_maps) do
    ino(v[1], v[2])
  end

  tn('<M-e>', '<C-\\><C-n>')
end

local function init_plugins_keymaps()
  -- terminal
  cmd('<C-x>', 'FTermToggle')

  -- inline edit
  cmd('<leader>e', 'InlineEdit')

  -- easy align
  xcmd('ga', 'EasyAlign')

  -- nvim tree
  cmd('<leader>tj', 'NvimTreeFindFile')
  cmd('<leader>tr', 'NvimTreeToggle')

  -- highlight group
  cmd('<leader>k', 'Interestingwords --toggle')
  cmd('<leader><leader>k', 'Interestingwords --remove_all')
  cmd('<leader>n', 'Interestingwords --navigate')
  cmd('<leader>N', 'Interestingwords --navigate b')

  -- fzf_utils
  cmd('<C-p>', 'FzfCommand --files')
  cmd('<C-f>', 'FzfCommand --lines')
  cmd('<C-r>', 'FzfCommand --ctags')
  cmd('<leader>b', 'FzfCommand --buffers')
  cmd('<leader><leader>m', 'FzfCommand --man')
  cmd('<leader><leader>h', 'FzfCommand --vim help')
  cmd('<leader>h', 'FzfCommand --vim cmdHists')
  cmd('<leader>ft', 'FzfCommand --vim filetypes')
  cmd('<leader>fd', [[exe('FzfCommand --gtags -d '.expand('<cword>'))]])
  cmd('<leader>fr', [[exe("FzfCommand --gtags -r ".expand("<cword>"))]])
  cmd('<leader>fu', 'FzfCommand --gtags --update')
  cmd('<leader>fb', 'FzfCommand --gtags --update-buffer')
  cmd('<M-f>', [[exe('FzfCommand --rg --all-buffers '.expand('<cword>'))]])
  cmd('<leader>ff', [[exe('FzfCommand --rg '.expand('<cword>')." ".expand('%'))]])
  cmd('<M-j>', 'FzfCommand --lsp jump_def edit')
  cmd('<M-t>', 'FzfCommand --lsp jump_def tab drop')
  cmd('<M-v>', 'FzfCommand --lsp jump_def vsplit')
  cmd('<M-r>', 'FzfCommand --lsp ref tab drop')
  cmd('<leader>ws', 'FzfCommand --lsp workspace_symbol')
  cmd('<leader>m', 'FzfCommand --mru')
  cmd('<leader>cm', 'FzfCommand --commit')

  cmd_gen('<leader>d', [[<C-U><C-R>=printf('FzfCommand --rg %s %s', expand('<cword>'), v:lua.GetFileDir())<CR>]])
  cmd_gen('<leader>fa', [[<C-U><C-R>='FzfCommand --rg '.expand('<cword>')<CR>]])

  -- lsp
  cmd('<M-k>', 'lua vim.lsp.buf.hover()')
  cmd('<leader>rn', 'lua vim.lsp.buf.rename()')
  cmd('<leader>ca', 'lua vim.lsp.buf.code_action()')
  cmd('<leader>a', 'lua vim.diagnostic.goto_next()')
  cmd('<M-o>', [[lua vim.diagnostic.open_float({border='single'})]])
  ino('<M-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
  cmd('<leader><space>f', 'lua vim.lsp.buf.formatting()')
  cmd('<leader><space>f', 'Format')
  cmd('<leader><leader>p', 'GotoPreview')

  cmd('<leader>v', 'SymbolsOutline')

  cmd('<leader><leader>d', 'DiffviewOpen --untracked-files=true -- %')
end

init_nvim_keys()
init_plugins_keymaps()

-- options
local global_cfg = {
  hidden = true;
  backup = false;
  writebackup = false;
  autoread = true;
  autowrite = true;
  smarttab = true;
  smartindent = true;
  scrolloff = 10;
  undofile = true;
  incsearch = true;
  ignorecase = true;
  smartcase = true;
  termguicolors = true;
  laststatus = 2;
  showtabline = 2;
  updatetime = 500;
  shortmess = 'aoOTIcF';
  completeopt = 'menu,menuone,noselect';
  tabline = '%!v:lua.mytabline()',
  guifont = 'Source Code Pro:h22'
}
local win_cfg = {
  signcolumn = "yes";
  number = true;
  cul = true;
}
local buf_cfg = {
  tabstop = 4;
  shiftwidth = 4;
  softtabstop = 4;
  swapfile = false;
  undofile = true;
};
for k, v in pairs(global_cfg) do
  vim.o[k] = v
end
for k, v in pairs(win_cfg) do
  vim.wo[k] = v
end
for k, v in pairs(buf_cfg) do
  vim.opt[k] = v
end

require('plugins')

vim.cmd([[
  set list lcs=tab:→\ ,trail:·
  augroup user_plugin
    autocmd!
    au TabLeave * let g:last_active_tab = tabpagenr() " tab switch
    au FocusGained * :checkt
    au WinEnter * if ! &cursorline | setlocal cul | endif
    au TextYankPost * silent! lua vim.highlight.on_yank{ higroup = "IncSearch", timeout = 700 }
    au BufWinEnter * lua require('plugins.myline').load()
  augroup END
]])

vim.g.clipboard = {
  name = 'tmuxClipboard',
  copy = { ['+'] = {'tmux', 'load-buffer', '-'}, ['*'] = {'tmux', 'load-buffer', '-'}, },
  paste = { ['+'] = {'tmux', 'save-buffer', '-'}, ['*'] = {'tmux', 'save-buffer', '-'}, },
}
