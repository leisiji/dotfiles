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
set t_Co=256
set termguicolors
"set showtabline=2
let mapleader=" "
set undofile
set undodir=$HOME/.cache/vim/undo
syntax enable
set smartindent
set ignorecase
set smartcase

noremap <leader>q :q<CR>
noremap <leader>s :w<CR>
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
noremap <M-l> <Esc>:tabnext<CR>
noremap <M-h> <Esc>:tabprevious<CR>
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
nnoremap <M-e> 5e
nnoremap <M-b> 5b
nnoremap <M-w> 5w
vnoremap <M-e> 5e
vnoremap <M-b> 5b
vnoremap <M-w> 5w
nnoremap <C-Y> <C-r>
"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
"tnoremap <Esc> <C-\><C-n>
nnoremap <C-t> :tabnew<CR>
inoremap <m-h> <c-left>
inoremap <m-l> <c-right>
noremap <m-y> d$

call plug#begin('~/.vim/plugged')
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-gtags'
"Plug 'ncm2/ncm2-ultisnips'
"Plug 'SirVer/ultisnips'
"Plug 'jiangmiao/auto-pairs'
"Plug 'sheerun/vim-polyglot'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus', {'on' : 'GscopeFind'} | Plug 'skywind3000/vim-preview', {'on' : ['PreviewQuickfix', 'PreviewTag']}
"Plug 'Shougo/defx.nvim' , { 'do': ':UpdateRemotePlugins'}
"Plug 'junegunn/seoul256.vim'

if executable('fcitx')
	Plug 'lilydjwg/fcitx.vim', { 'on': [] } | au InsertEnter * call plug#load('fcitx.vim')
endif

Plug 'srcery-colors/srcery-vim'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh', 'on' : 'Leaderf'}
Plug 'itchyny/lightline.vim'
Plug 'honza/vim-snippets'

Plug 'jsfaint/gen_tags.vim', {'for' : ['c', 'cpp']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-sources'

Plug 'lfv89/vim-interestingwords'
Plug 'Yggdroot/indentLine'
Plug 'liuchengxu/vista.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'farmergreg/vim-lastplace'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-surround'
Plug 'plasticboy/vim-markdown', {'for' : ['md']}
Plug 'sbdchd/neoformat', {'on' : 'Neoformat'}
Plug 'voldikss/vim-floaterm', {'on' : 'FloatermToggle'}
Plug 'AndrewRadev/inline_edit.vim', {'on' : 'InlineEdit' }
Plug 'easymotion/vim-easymotion'
"Plug 'justinmk/vim-sneak'

"Plug 'luochen1990/rainbow'
Plug 'neoclide/vim-jsx-improve', {'for' : ['js', 'html']}
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}
"Plug 'mhinz/vim-startify'
call plug#end()

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
" defx
"nnoremap <silent> <leader>tr :Defx `expand('%:p:h')` -search=`expand('%:p')`<CR>
"call defx#custom#option('_', {
			"\ 'winwidth': 30,
			"\ 'split': 'vertical',
			"\ 'direction': 'topleft',
			"\ 'show_ignored_files': 0,
			"\ 'buffer_name': '',
			"\ 'toggle': 1,
			"\ 'resume': 1
			"\ })
"function! s:defx_mappings() abort
"nnoremap <silent><buffer><expr> <CR>
			"\ defx#is_directory() ?
			"\ defx#do_action('open_or_close_tree') :
			"\ defx#do_action('drop',)
"nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
"nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
"nnoremap <silent><buffer><expr> t defx#do_action('drop', 'tabe')
"nnoremap <silent><buffer><expr> o defx#do_action('open_tree')
"nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
"nnoremap <silent><buffer><expr> C defx#do_action('copy')
"nnoremap <silent><buffer><expr> P defx#do_action('paste')
"nnoremap <silent><buffer><expr> M defx#do_action('rename')
"nnoremap <silent><buffer><expr> D defx#do_action('remove_trash')
"nnoremap <silent><buffer><expr> A defx#do_action('new_multiple_files')
"nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
"nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
"nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
"nnoremap <silent><buffer><expr> R defx#do_action('redraw')
"endfunction
" gen_tags.vim
"let g:gen_tags#gtags_default_map=1
"let g:seoul256_background = 236
"highlight Pmenu       ctermfg=245 ctermbg=235
"highlight PmenuSel    ctermfg=236 ctermbg=248
"highlight PmenuSbar   ctermbg=235
"highlight PmenuThumb  ctermbg=238

let g:srcery_italic = 1
colorscheme srcery

let g:indentLine_leadingSpaceEnabled=1
let g:indentLine_leadingSpaceChar='·'

" cpp-reference
let g:cpp_member_variable_highlight = 1
let g:cpp_posix_standard = 1

"vista.vim
let g:vista_close_on_jump=1
map <F4> :Vista<CR>

" lightline
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction
let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'readonly', 'filename', 'modified', 'method' ] ]
			\ },
			\ 'component_function': {
			\   'method': 'NearestMethodOrFunction'
			\ },
			\ }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
let s:palette = g:lightline#colorscheme#wombat#palette
let s:palette.tabline.tabsel = [ ['#d0d0d0', '#5f8787', 252, 66, 'bold'] ]
unlet s:palette

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
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewHorizontalPosition = 'center'
let g:Lf_PreviewPopupWidth=70
"leaderf tags
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'pygments'
let g:Lf_NormalMap = {
			\ "File":[["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
			\ "Buffer":[["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
			\ "Mru":[["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
			\ "Gtags":[["<ESC>", ':exec g:Lf_py "gtagsExplManager.quit()"<CR>']],
			\ "Rg":[["<ESC>", ':exec g:Lf_py "rgExplManager.quit()"<CR>']],
			\ "Line":[["<ESC>", ':exec g:Lf_py "lineExplManager.quit()"<CR>']],
			\}
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
nnoremap <F7> :Leaderf gtags --all --result ctags-x<CR>

"coc.vim
set shortmess+=c
set signcolumn=yes
let g:coc_global_extensions=[
			\ 'coc-json', 'coc-snippets', 'coc-pairs', 'coc-tag', 'coc-yank', 'coc-tsserver', 'coc-explorer',
			\ 'coc-python', 'coc-emmet', 'coc-vimlsp'
			\ ]

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
let g:coc_snippet_next = '<C-n>'

nmap <leader>rn <Plug>(coc-rename)
nmap <M-j> <Plug>(coc-definition)
nmap <M-r>r <Plug>(coc-reference)
nn <M-k> :call CocActionAsync('doHover')<cr>
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

"let g:rainbow_active = 1

" coc-explorer
function ToggleCocExplorer()
	execute 'CocCommand explorer --toggle --width=35 --sources=buffer+,file+'
endfunction
nnoremap <leader>tr :call ToggleCocExplorer()<CR>

" floaterm
nnoremap <leader>tt :FloatermToggle<CR>
tnoremap <M-q> <C-\><C-n>
let g:floaterm_type='floating'
let g:floaterm_position='center'
let g:floaterm_background='#3a3a3a'
function! s:floatermSettings()
	setlocal number
	tnoremap <ESC> <C-\><C-n>:FloatermToggle<CR>
endfunction

augroup user_plugin
	autocmd!
	" vista.vim
	autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
	" defx
	autocmd FileType defx call s:defx_mappings()

	" coc-explorer
	autocmd FileType coc-explorer setlocal signcolumn=no

	" floaterm
	autocmd FileType terminal call s:floatermSettings()
augroup END

" vim-interestingwords
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']

" repo setting, different repo jumping
"let g:Lf_RootMarkers=['.root']

" vim-startify
"let g:startify_session_dir = '~/.vim/sessions'

" inline_edit
nnoremap <leader>e :<C-u>InlineEdit<CR>
vnoremap <leader>e :InlineEdit<CR>
let g:inline_edit_new_buffer_command = "tabedit"

