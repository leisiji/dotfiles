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
set smarttab
set smartindent
set t_Co=256
set termguicolors
set showtabline=2
let mapleader=" "
set undofile
set undodir=$HOME/.cache/vim/undo
syntax enable
set ignorecase
set smartcase
set incsearch
set noswapfile
set cul

nn <silent> <leader>q :if(expand('%') == '')<Bar>exe 'q'<Bar>else<Bar>exe 'bd'<Bar>endif<cr>
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
vnoremap L g_
nnoremap <C-j> 5j
nnoremap <C-k> 5k
vnoremap <C-j> 5j
vnoremap <C-k> 5k
nnoremap <M-e> 5e
nnoremap <M-b> 5b
nnoremap <C-b> 5b
nnoremap <M-w> 5w
vnoremap <M-e> 5e
vnoremap <M-b> 5b
vnoremap <C-b> 5b
vnoremap <M-w> 5w
nnoremap <M-y> <C-r>
"Remove all trailing whitespace by pressing F5
nnoremap <M-s> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
"tnoremap <Esc> <C-\><C-n>
nnoremap <C-t> :tabnew<CR>
inoremap <m-h> <c-left>
inoremap <m-l> <c-right>
vmap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>rt :<C-U>%retab!<CR>
nnoremap <leader>ft :<C-U>set ft=

call plug#begin('~/.vim/plugged')

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
"Plug 'liuchengxu/vista.vim', {'on' : 'Vista'}
Plug 'scrooloose/nerdcommenter'
Plug 'farmergreg/vim-lastplace'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-surround'
Plug 'plasticboy/vim-markdown', {'for' : ['md']}
Plug 'sbdchd/neoformat', {'on' : 'Neoformat'}
Plug 'voldikss/vim-floaterm', {'on' : 'FloatermToggle'}
Plug 'AndrewRadev/inline_edit.vim', {'on' : 'InlineEdit' }
Plug 'easymotion/vim-easymotion', {'on' : '<Plug>(easymotion-overwin-f2)'}

Plug 'neoclide/vim-jsx-improve', {'for' : ['js']}
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp', 'cc']}
Plug 'junegunn/vim-easy-align', {'on' : '<Plug>(EasyAlign)'}
Plug 'sheerun/vim-polyglot'
Plug 'skywind3000/asynctasks.vim', {'on' : 'AsyncTask'} | Plug 'skywind3000/asyncrun.vim'
Plug 'simnalamburt/vim-mundo', {'on' : 'MundoToggle'}
"Plug 'puremourning/vimspector', {'do' : './install_gadget.py --all --disable-tcl'}
call plug#end()

let g:srcery_italic = 1
colorscheme srcery

let g:indentLine_leadingSpaceEnabled=1
let g:indentLine_leadingSpaceChar='·'

" cpp-reference
let g:cpp_member_variable_highlight = 1
let g:cpp_posix_standard = 1

"vista.vim
"let g:vista_close_on_jump=1
"nnoremap <leader>v :<C-U>Vista<CR>

" lightline
function! CocCurrentFunction() abort
	return get(b:, 'coc_current_function', '')
endfunction
let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'active': {
			\	'left': [ [ 'mode', 'paste' ],
			\			  [ 'readonly', 'filename', 'modified', 'method' ] ]
			\ },
			\ 'component_function': {
			\	'method': 'CocCurrentFunction'
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
noremap <leader>m :Leaderf --fuzzy mru<CR>
noremap <leader>b :Leaderf! --fuzzy buffer<CR>
noremap <leader>ff :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR><CR>
noremap <leader>fa :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
noremap <leader>d :<C-U><C-R>=printf("Leaderf! rg -e %s %s", expand("<cword>"), fnamemodify(expand("%:p:h"), ":~:."))<CR><CR>
noremap <leader>o :<C-U>LeaderfRgRecall<CR>
xnoremap <leader>fa :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
let g:Lf_FollowLinks = 1
let g:Lf_JumpToExistingWindow = 1
let g:Lf_HideHelp = 1
let g:Lf_WildIgnore = {
			\ 'dir': ['.svn','.git','.hg'],
			\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]', 'compile_commands.json']
			\}
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
"let g:Lf_PopupPosition = [29, 0]
"leaderf tags
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_GtagsAutoGenerate = 1
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
" repo setting
"let g:Lf_RootMarkers=['.root']
let g:Lf_ExternalCommand = 'rg --files --no-ignore "%s"'

"coc.vim
set shortmess+=c
set signcolumn=yes
set updatetime=300
let g:coc_global_extensions=[
			\ 'coc-json', 'coc-snippets', 'coc-pairs', 'coc-tag', 'coc-yank', 'coc-tsserver', 'coc-explorer',
			\ 'coc-python', 'coc-emmet', 'coc-vimlsp', 'coc-git', 'coc-powershell', 'coc-css', 'coc-emmet',
			\ 'coc-eslint']
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
" lsp
nmap [g <Plug>(coc-diagnostic-prev)
nmap ]g <Plug>(coc-diagnostic-next)
nmap <M-j> <Plug>(coc-definition)
nmap <M-r> <Plug>(coc-references)
nn <M-v> :call CocAction('jumpDefinition','vsplit')<cr>
nn <M-t> :call CocAction('jumpDefinition','tabe')<cr>
nn <M-k> :call CocActionAsync('doHover')<cr>
nn <leader>rn <Plug>(coc-rename)
nn <space>a :<C-u>CocList diagnostics<cr>
nn <space>v :<C-u>CocList outline<cr>
" coc-yank
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>
" coc function obj
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" ccls
function! CclsMap() abort
	nn <silent> <leader>xm :call CocLocations('ccls','$ccls/member')<cr>
	nn <silent> <leader>xf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
	nn <silent> <leader>xs :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>
	nn <silent> <leader>xv :call CocLocations('ccls','$ccls/vars')<cr>
	nn <silent> <leader>xe :call CocLocations('ccls','$ccls/call',{'hierarchy':v:true, 'levels':10})<cr>
endfunction

" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" coc-explorer
let g:indentLine_fileTypeExclude = ['coc-explorer']
nmap <space>tr :CocCommand explorer --preset floating<CR>
hi CocExplorerNormalFloatBorder guifg=#414347 guibg=#272B34
hi CocExplorerNormalFloat guibg=#272B34

" coc-git
nnoremap <silent> <space>gs :<C-u>CocList --normal gstatus<CR>
nnoremap <leader>gu :CocCommand git.chunkUndo<CR>
nnoremap <leader>gf :CocCommand git.foldUnchanged<CR>
nnoremap <leader>gd :CocCommand git.diffCached<CR>
nmap <leader>gi <Plug>(coc-git-chunkinfo)
nmap <leader>gc <Plug>(coc-git-commit)
nmap <leader>gj <Plug>(coc-git-nextchunk)
nmap <leader>gk <Plug>(coc-git-prevchunk)

" floaterm
nnoremap <leader>tt :FloatermToggle<CR>
tnoremap <M-q> <C-\><C-n>
let g:floaterm_type='floating'
let g:floaterm_position='center'
"let g:floaterm_background='#3a3a3a'
tnoremap <ESC> <C-\><C-n>:FloatermToggle<CR>

augroup user_plugin
	autocmd!

	" coc-nvim
	autocmd FileType c,cpp call CclsMap()
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" tab switch
	autocmd TabLeave * let g:last_active_tab = tabpagenr()
augroup END

" vim-interestingwords
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']

" vim-startify
"let g:startify_session_dir = '~/.vim/sessions'

" inline_edit
nnoremap <leader>e :<C-u>InlineEdit<CR>
xnoremap <leader>e :InlineEdit<cr>
let g:inline_edit_new_buffer_command = "tabedit"
let g:inline_edit_autowrite = 1

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:polyglot_disabled = [ 'c', 'cpp', 'markdown', 'javascript' ]

nmap f <Plug>(easymotion-overwin-f2)

nmap <leader>u :MundoToggle<CR>

let g:vimspector_enable_mappings = 'HUMAN'

" asynctasks
let g:asyncrun_open = 6
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
noremap <leader><leader>r :AsyncTask file-run<cr>

nnoremap <expr> <CR> NormalMapForEnter() . "\<Esc>"
function! NormalMapForEnter()
	if &filetype ==# 'quickfix'
		return "\<CR>"
	elseif index([
		\ 'c',
		\ 'cpp',
		\ 'cs',
		\ 'css',
		\ 'java',
		\ 'rust',
		\ 'scss',
		\ 'typescript',
		\ 'typescript.tsx'
	\ ],&filetype) >= 0
		let l:line = getline('.')
		if l:line != '' && l:line !~ '^\s\+$' && index([';', '{', '(', '\'], l:line[-1:]) < 0
			return "A;"
		else
			return ""
		endif
	else
		return ""
	endif
endfunction

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
nnoremap <silent> <Leader>z :call WinZoomToggle()<CR>

let g:last_active_tab = 1
nnoremap <silent> <M-q> :execute 'tabnext ' . g:last_active_tab<cr>

