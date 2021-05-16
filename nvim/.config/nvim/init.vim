set list lcs=tab:→\ ,trail:·
set ts=4 sw=4 noswf sts=4
set undofile undodir=$HOME/.cache/vim/undo

lua require('options')
lua require('keymaps')
lua require('plugins')

augroup user_plugin
	autocmd!

	au TabLeave * let g:last_active_tab = tabpagenr() " tab switch

	" open last place
	au BufWinEnter * call v:lua.MyOpenLastplace()

	au FocusGained * :checkt
	au WinEnter * if ! &cursorline | setlocal cul | endif
	au TextYankPost * silent! lua vim.highlight.on_yank{ higroup = "IncSearch", timeout = 700 }

augroup END

command! -complete=dir -nargs=+ FzfCommand lua require('fzf_utils.commands').load_command(<f-args>)
