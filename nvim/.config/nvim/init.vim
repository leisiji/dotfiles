"set hidden nowritebackup number scrolloff=10 autoread autowrite noswapfile
set list lcs=tab:→\ ,trail:·,extends:↷,precedes:↶
set tabstop=4
"set tabstop=4 shiftwidth=4 softtabstop=4 smarttab smartindent ignorecase smartcase incsearch cul
"set t_Co=256 termguicolors showtabline=2
set undofile undodir=$HOME/.cache/vim/undo
lua require('options')
let mapleader=" "
let g:markdown_fenced_languages = [
	\ 'vim', 'cpp', 'c', 'java', 'python', 'lua',
	\ 'sh', 'make', 'groovy', 'sql', 'javascript'
	\]

function! MyQuit() abort
	if len(win_findbuf(bufnr())) > 1 || expand('%') == '' || tabpagenr('$') == 1
		exe 'q'
	else
		exe 'bd'
	endif
endfunction
nn <silent> <leader>q :call MyQuit()<CR>
nn <silent> <leader><leader>q :qa<CR>

nn <silent> <leader>s :w<CR>
nn <M-a> <C-w>w
nn <M-1> 1gt
nn <M-2> 2gt
nn <M-3> 3gt
nn <M-4> 4gt
nn <M-5> 5gt
nn <silent> <M-l> <Esc>:tabnext<CR>
nn <silent> <M-h> <Esc>:tabprevious<CR>
" move like bash in insert mode
ino <C-j> <Down>
ino <C-k> <Up>
ino <C-b> <Left>
ino <C-f> <Right>
ino <C-a> <Home>
ino <C-e> <End>
ino <C-d> <Delete>
ino <C-h> <Backspace>
ino <M-b> <C-Left>
ino <M-f> <C-Right>
nn H ^
nn L $
vn H ^
vn L g_
nn <C-j> 5j
nn <C-k> 5k
vn <C-j> 5j
vn <C-k> 5k
nn <M-e> 5e
nn <M-b> 5b
nn <C-b> 5b
nn <M-w> 5w
vn <M-e> 5e
vn <M-b> 5b
vn <C-b> 5b
vn <M-w> 5w
nn <M-y> <C-r>
"Remove all trailing whitespace by pressing F5
nn <M-s> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
tnoremap <M-e> <C-\><C-n>
ino <M-b> <c-left>
ino <M-f> <c-right>
ino <M-d> <C-o>diw
vmap <leader>y "+y
nn <leader>p "+p
nn <leader>rt :<C-U>%retab!<CR>

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (&filetype == 'vim' || &filetype == 'lua' || &filetype == 'help')
		execute 'vertical h '.expand('<cword>')
	else
		execute 'vertical Man '.expand('<cword>')
	endif
endfunction

lua require('plugins')

"coc.vim
set shortmess+=c signcolumn=yes updatetime=500
ino <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction
ino <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
ino <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
ino <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" lsp
nm <silent> <M-t> <Plug>(coc-definition)
nm <silent> <M-r> <Plug>(coc-references)
nm <silent> <leader>rn <Plug>(coc-rename)
nn <silent> <M-v> :call CocAction('jumpDefinition','vsplit')<cr>
nn <silent> <M-j> :call CocAction('jumpDefinition', 'edit')<cr>
nn <silent> <M-k> :call CocActionAsync('doHover')<cr>
nn <silent> <space>a :<C-u>CocList --normal diagnostics<cr>
nn <silent> <space>v :<C-u>CocList --normal outline<cr>
nn <silent> <expr> <leader>j coc#float#scroll(1, 1)
xmap <leader><leader>f <Plug>(coc-format-selected)
nmap <leader><leader>f <Plug>(coc-format)

" coc-yank
nn <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

" floaterm
let g:floaterm_type='floating'
let g:floaterm_position='center'
nn <silent> <leader>tt :FloatermToggle<CR>

augroup user_plugin
	autocmd!

	" coc-nvim
	au CursorHold * silent call CocActionAsync('highlight')

	" tab switch
	au TabLeave * let g:last_active_tab = tabpagenr()

	au BufRead,BufNewFile *.lds setfiletype ld
	au BufRead,BufNewFile *.aidl setfiletype java
	au FocusGained * :checktime

	au BufReadPost *
	  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
	  \ |	exe "normal! g`\""
	  \ | endif

	au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

	au FileType floaterm tnoremap <buffer> <ESC> <C-\><C-n>:FloatermToggle<CR>

	au FileType fern call s:init_fern()
augroup END

" inline_edit
nn <leader>e :<C-u>InlineEdit<CR>
xn <leader>e :InlineEdit<cr>
let g:inline_edit_new_buffer_command = "tabedit"
let g:inline_edit_autowrite = 1

" easy-align
xm ga :EasyAlign<cr>

" asynctasks
let g:asyncrun_open = 6
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
nn <leader><leader>r :AsyncTask file-run<cr>

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

"leaderf
let g:Lf_WindowPosition = 'popup'
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_PreviewInPopup = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_RootMarkers=['.root']
let g:Lf_GtagsAutoUpdate = 0
nn <silent> <leader>m :Leaderf --fuzzy mru<CR>
nn <leader>ft :<C-U>Leaderf filetype<CR>
"leaderf tags
nn <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
nn <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
nn <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>

" fzf find
nn <silent> <C-p> :lua require('fzf_utils.nvim_fzf_commands').find_files()<CR>
nn <silent> <C-f> :lua require('fzf_utils.nvim_fzf_commands').grep_lines()<CR>
nn <silent> <C-r> :lua require('fzf_utils.ctags')()<CR>
nn <silent> <leader>b :lua require('fzf_utils.nvim_fzf_commands').buffers()<CR>
nn <silent> <leader><leader>m :lua require('fzf_utils.nvim_fzf_commands').Man()<CR>
nn <silent> <leader><leader>h :lua require('fzf_utils.vim_utils').vim_help()<CR>

" Rg search
nn <leader>fa :<C-U><C-R>=printf("FzfRg %s ", expand("<cword>"))<CR>
nn <leader>d :<C-U><C-R>=printf("FzfRg %s %s", expand("<cword>"), fnamemodify(expand("%:p:h"), ":."))<CR>
nn <silent> <leader>ff :<C-U><C-R>=printf("FzfRg %s %s", expand("<cword>"), expand("%"))<CR><CR>
nn <silent> <M-f> :<C-U><C-R>=printf("FzfRg --all-buffers %s", expand("<cword>"))<CR><CR>
nn <silent> <leader>h :<C-U><C-R>=printf("lua require('fzf_utils.vim_utils').vim_cmd_history", expand("<cword>"))<CR><CR>
xn <leader>fa :<C-U><C-R>=printf("FzfRg %s", RgVisual())<CR>
command! -complete=dir -nargs=+ FzfRg lua require('fzf_utils.commands').load_command(<f-args>)

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

let g:fern#disable_default_mappings = 1
nn <leader>tj :Fern . -reveal=% -drawer<CR>
nn <leader>tr :Fern . -drawer<CR>
function! s:init_fern() abort
	nmap <buffer> t <Plug>(fern-action-open:tabedit)
	nmap <buffer> v <Plug>(fern-action-open:vsplit)
	nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
	nmap <buffer> l <Plug>(fern-action-expand)
	nmap <buffer> h <Plug>(fern-action-collapse)
	nmap <buffer> <C-j> 5j
	nmap <buffer> <C-k> 5k
	nmap <buffer> A <Plug>(fern-action-new-dir)
	nmap <buffer> a <Plug>(fern-action-new-file)
	nmap <buffer> D <Plug>(fern-action-remove)
	nmap <buffer> r <Plug>(fern-action-rename)
	nmap <buffer> q :<C-u>quit<CR>
	nmap <buffer> z <Plug>(fern-action-zoom:half)
	nmap <buffer><nowait> ! <Plug>(fern-action-hidden:toggle)
endfunction

