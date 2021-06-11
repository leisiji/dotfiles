set list lcs=tab:→\ ,trail:·
set ts=4 sw=4 noswf sts=4
set undofile
set expandtab

lua require('options')
lua require('keymaps')
lua require('plugins')

augroup user_plugin
    autocmd!
    au TabLeave * let g:last_active_tab = tabpagenr() " tab switch
    au BufWinEnter * call v:lua.MyOpenLastplace()
    au FocusGained * :checkt
    au WinEnter * if ! &cursorline | setlocal cul | endif
    au TextYankPost * silent! lua vim.highlight.on_yank{ higroup = "IncSearch", timeout = 700 }
augroup END
