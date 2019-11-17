set hidden
set nobackup
set nowritebackup
set number
set scrolloff=10
set autoread
set autowrite
set list lcs=tab:→\ ,trail:·,extends:↷,precedes:↶
set tabstop=4
set shiftwidth=4
set softtabstop=4
let mapleader=" "

noremap <leader>q :q<CR>
noremap <leader>s :w<CR>
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
noremap <C-L> <Esc>:tabnext<CR>
noremap <C-H> <Esc>:tabprevious<CR>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
nnoremap <C-j> 5j
nnoremap <C-k> 5k
vnoremap <C-j> 5j
vnoremap <C-k> 5k
nnoremap <C-m> %
nnoremap <C-Y> <C-r>
"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

call plug#begin('~/.vim/plugged')
Plug 'junegunn/seoul256.vim'
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}
Plug 'Yggdroot/LeaderF', { 'do': './install.sh'}
Plug 'itchyny/lightline.vim'
Plug 'honza/vim-snippets'

"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-gtags'
"Plug 'ncm2/ncm2-ultisnips'
"Plug 'SirVer/ultisnips'
"Plug 'jiangmiao/auto-pairs'

"Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus', {'on' : 'GscopeFind'} | Plug 'skywind3000/vim-preview', {'on' : ['PreviewQuickfix', 'PreviewTag']}

Plug 'jsfaint/gen_tags.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-sources'

Plug 'lfv89/vim-interestingwords'
Plug 'Yggdroot/indentLine'
Plug 'easymotion/vim-easymotion'
Plug 'liuchengxu/vista.vim', {'on' : 'Vista'}
Plug 'Shougo/defx.nvim' , { 'do': ':UpdateRemotePlugins'}
Plug 'scrooloose/nerdcommenter'
Plug 'farmergreg/vim-lastplace'
Plug 'mg979/vim-visual-multi'
Plug 'lilydjwg/fcitx.vim'
Plug 'tpope/vim-surround'
Plug 'plasticboy/vim-markdown', {'for' : ['md']}
call plug#end()

set background=dark
color seoul256

highlight Pmenu       ctermfg=245 ctermbg=235
highlight PmenuSel    ctermfg=236 ctermbg=248
highlight PmenuSbar   ctermbg=235
highlight PmenuThumb  ctermbg=238

let g:indentLine_leadingSpaceEnabled=1
let g:indentLine_leadingSpaceChar='·'

" cpp-reference
let g:cpp_member_variable_highlight = 1
let g:cpp_posix_standard = 1

" gen_tags.vim
"let g:gen_tags#gtags_default_map=1

"vista.vim
let g:vista_close_on_jump=1
map <F4> :Vista<CR>

"gutentags
"let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
"let g:gutentags_ctags_tagfile = '.tags'
"let g:gutentags_cache_dir = expand('~/.cache/tags')
"let g:gutentags_modules = ['ctags', 'gtags_cscope']
"let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" gutentags plus
"let g:gutentags_plus_auto_close_list = 1
"let g:gutentags_plus_switch = 1
"let g:gutentags_plus_nomap = 1
"noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
"noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
"noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
"noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
"noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
"noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
"noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
"noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
"noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>

" vim-preview
"autocmd FileType qf nnoremap p :PreviewQuickfix<cr>
"autocmd FileType qf nnoremap P :PreviewClose<cr>
"nnoremap <leader>p :PreviewTag<cr>
"nnoremap <m-u> :PreviewScroll -1<cr>
"nnoremap <m-d> :PreviewScroll +1<cr>

" defx
nnoremap <leader>tr :Defx `expand('%:p:h')` -search=`expand('%:p')`<CR>
nnoremap <leader>tt :Defx<CR>
call defx#custom#option('_', {
	\ 'winwidth': 30,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'show_ignored_files': 0,
	\ 'buffer_name': '',
	\ 'toggle': 1,
	\ 'resume': 1
	\ })
augroup user_plugin_defx
	autocmd!
	autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif
	autocmd TabClosed * call s:defx_close_tab(expand('<afile>'))
	autocmd FileType defx call s:defx_mappings()
augroup END
function! s:defx_close_tab(tabnr)
	" When a tab is closed, find and delete any associated defx buffers
	for l:nr in range(1, bufnr('$'))
		let l:defx = getbufvar(l:nr, 'defx')
		if empty(l:defx)
			continue
		endif
		let l:context = get(l:defx, 'context', {})
		if get(l:context, 'buffer_name', '') ==# 'tab' . a:tabnr
			silent! execute 'bdelete '.l:nr
			break
		endif
	endfor
endfunction
function! s:defx_mappings() abort
	nnoremap <silent><buffer><expr> <CR>
	\ defx#is_directory() ?
	\ defx#do_action('open_or_close_tree') :
	\ defx#do_action('drop',)
	nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
	nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
	nnoremap <silent><buffer><expr> t defx#do_action('drop', 'tabe')
	nnoremap <silent><buffer><expr> o defx#do_action('open_tree')
	nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
	nnoremap <silent><buffer><expr> C defx#do_action('copy')
	nnoremap <silent><buffer><expr> P defx#do_action('paste')
	nnoremap <silent><buffer><expr> M defx#do_action('rename')
	nnoremap <silent><buffer><expr> D defx#do_action('remove_trash')
	nnoremap <silent><buffer><expr> A defx#do_action('new_multiple_files')
	nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
	nnoremap <silent><buffer><expr> R defx#do_action('redraw')
endfunction

"leaderf
noremap <C-r> :Leaderf --fuzzy function<CR>
noremap <C-p> :Leaderf --fuzzy file<CR>
noremap <C-f> :Leaderf --fuzzy line<CR>
noremap <leader>b :Leaderf! --fuzzy buffer<CR>
noremap <leader>m :Leaderf! --fuzzy mru<CR>
noremap <leader>ff :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR><CR>
noremap <leader>a :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
let g:Lf_WildIgnore = {
	\ 'dir': ['.svn','.git','.hg'],
	\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
	\}
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewHorizontalPosition = 'center'
"leaderf tags
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

"coc.vim
set shortmess+=c
set signcolumn=yes
autocmd CursorHold * silent call CocActionAsync('highlight')
let g:coc_global_extensions=['coc-json', 'coc-snippets', 'coc-pairs', 'coc-tag', 'coc-yank']
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
let g:coc_snippet_next = '<C-n>'

nmap <leader>rn <Plug>(coc-rename)
nmap <M-j> <Plug>(coc-definition)
nmap <M-r> <Plug>(coc-reference)
nn <silent> <M-k> :call CocActionAsync('doHover')<cr>
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" ncm2
"set shortmess+=c
"set completeopt=noinsert,menuone,noselect
"let g:ncm2#complete_length=[[1,2],[7,2]]
"autocmd BufEnter * call ncm2#enable_for_buffer()
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
"let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
"let g:UltiSnipsRemoveSelectModeMappings = 0

" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

