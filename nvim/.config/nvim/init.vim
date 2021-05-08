"set hidden nowritebackup number scrolloff=10 autoread autowrite
set list lcs=tab:→\ ,trail:·
set ts=4 sw=4 noswf sts=4
set undofile undodir=$HOME/.cache/vim/undo

"Remove all trailing whitespace
nn <M-s> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

lua require('options')
lua require('keymaps')
lua require('plugins')

" toggle terminal
tno <silent> <expr> <esc> (&ft == 'fzf') ? '<esc>' : '<C-\><C-n>:ToggleTerminal<CR>'

augroup user_plugin
	autocmd!

	au TabLeave * let g:last_active_tab = tabpagenr() " tab switch

	" open last place
	au BufReadPost *
	  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
	  \ |	exe "normal! g`\""
	  \ | endif

	au FocusGained * :checkt
	au BufReadPost,WinEnter * if ! &cursorline | setlocal cul | endif
	au TextYankPost * silent! lua vim.highlight.on_yank{ higroup = "IncSearch", timeout = 700 }
	au FileType NvimTree nn <silent> <buffer> z :lua require('plugins.nvim_tree').resize_toggle()<cr>

augroup END

let g:last_active_tab = 1
nn <M-q> :execute 'tabn ' . g:last_active_tab<cr>

command! -complete=dir -nargs=+ FzfCommand lua require('fzf_utils.commands').load_command(<f-args>)
" gtags fzf
nn <silent> <leader>fu :FzfCommand --gtags --update<CR>
nn <silent> <leader>fb :FzfCommand --gtags --update-buffer<CR>

" Rg search
nn <leader>d :<C-U><C-R>=printf("FzfCommand --rg %s %s", expand("<cword>"), GetFileDir())<CR>
nn <silent> <leader>ff :<C-U><C-R>=printf("FzfCommand --rg %s %s", expand("<cword>"), expand("%"))<CR><CR>
nn <silent> <M-f> :<C-U><C-R>=printf("FzfCommand --rg --all-buffers %s", expand("<cword>"))<CR><CR>
xn <leader>fa :<C-U><C-R>=printf("FzfCommand --rg %s", RgVisual())<CR>

function! RgVisual()
	try
		let x_save = getreg("x", 1)
		let type = getregtype("x")
		norm! gv"xy
		return '"' . escape(@x, '"') . '"'
	finally
		call setreg("x", x_save, type)
	endtry
endfunction

ino <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
ino <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <tab> <Plug>(completion_smart_tab)
