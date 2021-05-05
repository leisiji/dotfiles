"set hidden nowritebackup number scrolloff=10 autoread autowrite
set list lcs=tab:→\ ,trail:·,extends:↷,precedes:↶
set ts=4 sw=4 noswf sts=4
set undofile undodir=$HOME/.cache/vim/undo

"Remove all trailing whitespace
nn <M-s> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

lua require('options')
lua require('keymaps')
lua require('plugins')

" toggle terminal
nn <silent> <leader>tt :ToggleTerminal<CR>
tno <silent> <expr> <esc> (&ft == 'fzf') ? '<esc>' : '<C-\><C-n>:ToggleTerminal<CR>'

augroup user_plugin
	autocmd!

	au TabLeave * let g:last_active_tab = tabpagenr() " tab switch
	au FocusGained * :checktime 

	" open last place
	au BufReadPost *
	  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
	  \ |	exe "normal! g`\""
	  \ | endif

	au BufReadPost,WinEnter * if ! &cursorline | setlocal cul | endif
	au FileType markdown if ! &expandtab | setlocal expandtab | endif
	au TextYankPost * silent! lua vim.highlight.on_yank{ higroup = "IncSearch", timeout = 700 }
	au FileType NvimTree nmap <silent> <buffer> z :lua require('plugins.nvim_tree').resize_toggle()<cr>

augroup END

" inline_edit
nn <leader>e :<C-u>InlineEdit<CR>
xn <leader>e :InlineEdit<cr>

" easy-align
xm ga :EasyAlign<cr>

function! WinZoomToggle() abort
	if exists('t:zoomed') && t:zoomed
		execute t:zoom_winrestcmd
		let t:zoomed = 0
	else
		let t:zoom_winrestcmd = winrestcmd()
		resize
		vertical resize
		let t:zoomed = 1
	endif
endfunction
nn <silent> <Leader>z :call WinZoomToggle()<CR>

let g:last_active_tab = 1
nn <M-q> :execute 'tabn ' . g:last_active_tab<cr>

command! -complete=dir -nargs=+ FzfCommand lua require('fzf_utils.commands').load_command(<f-args>)
" fzf find
nn <silent> <C-p> :FzfCommand --files<CR>
nn <silent> <C-f> :FzfCommand --lines<CR>
nn <silent> <C-r> :FzfCommand --ctags<CR>
nn <silent> <leader>b :FzfCommand --buffers<CR>
nn <silent> <leader><leader>m :FzfCommand --man<CR>
nn <silent> <leader><leader>h :FzfCommand --vim help<CR>
nn <silent> <leader>h :FzfCommand --vim cmdHists<CR>
nn <silent> <leader>ft :FzfCommand --vim filetypes<CR>

" gtags fzf
nn <silent> <leader>fd :<C-U><C-R>=printf("FzfCommand --gtags -d %s", expand("<cword>"))<CR><CR>
nn <silent> <leader>fr :<C-U><C-R>=printf("FzfCommand --gtags -r %s", expand("<cword>"))<CR><CR>
nn <silent> <leader>fu :FzfCommand --gtags --update<CR>
nn <silent> <leader>fb :FzfCommand --gtags --update-buffer<CR>

" Rg search
nn <leader>fa :<C-U><C-R>=printf("FzfCommand --rg %s ", expand("<cword>"))<CR>
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

function! GetFileDir()
	return fnamemodify(expand("%:p:h"), ":.")
endfunction

nn <leader>tj :NvimTreeFindFile<CR>
nn <leader>tr :NvimTreeToggle<CR>

nn <silent> <leader>k :HighlightGroupsAddWord 4 0<CR>
nn <silent> <leader>K :HighlightGroupsClearGroup 4 0<CR>

nn <leader><leader>d :<C-U><C-R>=printf("DiffviewOpen -- %s", GetFileDir())<CR><CR>
"nn <leader><leader>c :<C-U><C-R>=printf("DiffviewOpen -- %s", expand('%:p'))<CR><CR>

inoremap <expr> <Tab>	pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <tab> <Plug>(completion_smart_tab)
set completeopt=menuone,noinsert,noselect
set shortmess+=c
