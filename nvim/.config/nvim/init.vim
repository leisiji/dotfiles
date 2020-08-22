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
filetype plugin indent on
syntax enable
set ignorecase
set smartcase
set incsearch
set noswapfile
set cul

function! MyQuit() abort
	if len(win_findbuf(bufnr())) > 1 || expand('%') == '' || tabpagenr('$') == 1
		exe 'q'
	else
		exe 'bd'
	endif
endfunction
nn <silent> <leader>q :call MyQuit()<CR>
nn <silent> <leader><leader>q :qa<CR>

nn <leader>s :w<CR>
nn <M-1> 1gt
nn <M-2> 2gt
nn <M-3> 3gt
nn <M-4> 4gt
nn <M-5> 5gt
nn <M-l> <Esc>:tabnext<CR>
nn <M-h> <Esc>:tabprevious<CR>
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
ino <M-d> <C-o>diw
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
"tnoremap <Esc> <C-\><C-n>
nn <C-t> :tabnew<CR>
ino <m-h> <c-left>
ino <m-l> <c-right>
vmap <leader>y "+y
nn <leader>p "+p
nn <leader>rt :<C-U>%retab!<CR>

call plug#begin('~/.vim/plugged')

if executable('fcitx5')
	Plug 'lilydjwg/fcitx.vim', { 'on': [] } | au InsertEnter * call plug#load('fcitx.vim')
endif

Plug 'srcery-colors/srcery-vim'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh', 'on' : ['Leaderf', 'LeaderfFile']}
Plug 'itchyny/lightline.vim'
Plug 'honza/vim-snippets'
"Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!', 'on': 'Clap'}
Plug 'liuchengxu/vista.vim', {'on' : ['Vista', 'Clap']}

"Plug 'jsfaint/gen_tags.vim', {'for' : ['c', 'cpp']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-sources'

Plug 'lfv89/vim-interestingwords'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'
Plug 'farmergreg/vim-lastplace'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-surround'
Plug 'plasticboy/vim-markdown', {'for' : ['md']}
Plug 'sbdchd/neoformat', {'on' : 'Neoformat'}
Plug 'voldikss/vim-floaterm', {'on' : 'FloatermToggle'}
Plug 'AndrewRadev/inline_edit.vim', {'on' : 'InlineEdit'}
Plug 'easymotion/vim-easymotion', {'on' : '<Plug>(easymotion-overwin-f2)'}

Plug 'neoclide/vim-jsx-improve', {'for' : ['js']}
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}
Plug 'junegunn/vim-easy-align', {'on' : '<Plug>(EasyAlign)'}
Plug 'sheerun/vim-polyglot'
Plug 'skywind3000/asynctasks.vim', {'on' : 'AsyncTask'} | Plug 'skywind3000/asyncrun.vim'
Plug 'simnalamburt/vim-mundo', {'on' : 'MundoToggle'}
Plug 'ARM9/arm-syntax-vim', {'for' : ['asm']}
Plug 'Shirk/vim-gas', {'for' : ['asm']}
Plug 'rubberduck203/aosp-vim', {'for' : ['hal', 'bp', 'rc']}
Plug 'uiiaoo/java-syntax.vim', {'for' : ['java']}
"Plug 'jsfaint/gen_tags.vim', {'for' : ['c']}
"Plug 'puremourning/vimspector', {'do' : './install_gadget.py --all --disable-tcl'}
call plug#end()

let g:srcery_italic = 1
colorscheme srcery

let g:indentLine_leadingSpaceEnabled=1
let g:indentLine_leadingSpaceChar='·'

" cpp-reference
let g:cpp_member_variable_highlight = 1
let g:cpp_posix_standard = 1

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
"let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
"let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
let s:palette = g:lightline#colorscheme#wombat#palette
let s:palette.tabline.tabsel = [ ['black', '#7FB3D5', 252, 66, 'bold'] ]
unlet s:palette


"coc.vim
set shortmess+=c
set signcolumn=yes
set updatetime=300
let g:coc_global_extensions=[
			\ 'coc-json', 'coc-snippets', 'coc-pairs', 'coc-tag', 'coc-yank', 'coc-tsserver', 'coc-explorer',
			\ 'coc-python', 'coc-emmet', 'coc-vimlsp', 'coc-git', 'coc-powershell', 'coc-css', 'coc-emmet',
			\ 'coc-eslint', 'coc-java']
ino <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
ino <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
ino <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
let g:coc_snippet_next = '<C-n>'
" lsp
nm [g <Plug>(coc-diagnostic-prev)
nm ]g <Plug>(coc-diagnostic-next)
nm <M-t> <Plug>(coc-definition)
nm <M-r> <Plug>(coc-references)
nm <leader>rn <Plug>(coc-rename)
nn <M-v> :call CocAction('jumpDefinition','vsplit')<cr>
nn <M-j> :call CocAction('jumpDefinition', 'edit')<cr>
nn <M-k> :call CocActionAsync('doHover')<cr>
nn <space>a :<C-u>CocList --normal diagnostics<cr>
nn <space>v :<C-u>CocList --normal outline<cr>
" coc-yank
nn <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>
" coc function obj
xm if <Plug>(coc-funcobj-i)
xm af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" ccls
function! CclsMap() abort
	" class data member
	nn <silent> <leader>xm :call CocLocations('ccls','$ccls/member')<cr>
	" class function member
	nn <silent> <leader>xf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
	" class's inner struct or typedef
	nn <silent> <leader>xs :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>
	" class refs
	nn <silent> <leader>xv :call CocLocations('ccls','$ccls/vars')<cr>
	" function call chains
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
nm <space>tr :CocCommand explorer<CR>

" coc-git
nn <silent> <space>gs :<C-u>CocList --normal gstatus<CR>
nn <leader>gu :CocCommand git.chunkUndo<CR>
nn <leader>gf :CocCommand git.foldUnchanged<CR>
nn <leader>gd :CocCommand git.diffCached<CR>
nm <leader>gi <Plug>(coc-git-chunkinfo)
nm <leader>gc <Plug>(coc-git-commit)
nm <leader>gj <Plug>(coc-git-nextchunk)
nm <leader>gk <Plug>(coc-git-prevchunk)

" floaterm
nn <leader>tt :FloatermToggle<CR>
tnoremap <M-q> <C-\><C-n>
let g:floaterm_type='floating'
let g:floaterm_position='center'
tnoremap <ESC> <C-\><C-n>:FloatermToggle<CR>

augroup user_plugin
	autocmd!

	" coc-nvim
	autocmd FileType c,cpp call CclsMap()
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" tab switch
	autocmd TabLeave * let g:last_active_tab = tabpagenr()

	au BufRead,BufNewFile *.lds setfiletype ld
augroup END

" vim-interestingwords
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']

" vim-startify
"let g:startify_session_dir = '~/.vim/sessions'

" inline_edit
nn <leader>e :<C-u>InlineEdit<CR>
xn <leader>e :InlineEdit<cr>
let g:inline_edit_new_buffer_command = "tabedit"
let g:inline_edit_autowrite = 1

" easy-align
xm ga <Plug>(EasyAlign)
nm ga <Plug>(EasyAlign)

let g:polyglot_disabled = [ 'c', 'cpp', 'markdown', 'javascript' , 'java']

nm f <Plug>(easymotion-overwin-f2)
nm <leader>u :MundoToggle<CR>

"vista.vim
"let g:vista_close_on_jump=1
"nn <leader>v :<C-U>Vista<CR>

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

" scp copy
"let g:scp_des_proj = "xxx"
"let g:scp_src_proj = "xxx"
"let g:ip_des = 142
"nn <leader><leader>t :<C-U><C-R>=printf("AsyncRun! sshpass -p yexuelin scp %s yexuelin@192.168.10.%d:%s", expand("%:p"), g:ip_des, g:scp_des_proj . substitute(expand("%:p"), g:scp_src_proj, "", ""))<CR><CR>
highlight link JavaIdentifier NONE

"vim-clap
"nn <C-r> :Clap tags<CR>
"nn <C-p> :Clap files<CR>
"nn <C-f> :Clap blines<CR>
"nn <leader>b :Clap buffers<CR>
"nn <leader>m :Clap history<CR>
"nn <leader>ft :Clap filetypes<CR>
"nn <leader>fj :Clap jumps<CR>
"nn <leader>fa :<C-U><C-R>=printf("Clap grep ++opt=--no-ignore ++opt=-w ++query=%s", expand("<cword>"))<CR>
"xn <leader>fa :Clap grep ++query=@visual<CR>
"let g:clap_theme = 'material_design_dark'

"leaderf
nn <C-r> :Leaderf --fuzzy function<CR>
nn <C-p> :LeaderfFile<CR>
nn <C-f> :Leaderf rg --current-buffer<CR>
nn <leader>m :Leaderf --fuzzy mru<CR>
nn <M-f> :Leaderf rg --all-buffers<CR>
nn <leader>b :Leaderf! buffer<CR>
nn <leader>ff :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -w -e %s ", expand("<cword>"))<CR><CR>
nn <leader>fa :<C-U><C-R>=printf("Leaderf! rg -w -e %s ", expand("<cword>"))<CR>
nn <leader>d :<C-U><C-R>=printf("Leaderf! rg -e %s %s", expand("<cword>"), fnamemodify(expand("%:p:h"), ":~:."))<CR><CR>
nn <leader>o :<C-U>LeaderfRgRecall<CR>
xn <leader>fa :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
"let g:Lf_FollowLinks = 1
let g:Lf_JumpToExistingWindow = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_NormalMap = {
			\ "File":[["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
			\ "Buffer":[["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
			\ "Mru":[["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
			\ "Gtags":[["<ESC>", ':exec g:Lf_py "gtagsExplManager.quit()"<CR>']],
			\ "Rg":[["<ESC>", ':exec g:Lf_py "rgExplManager.quit()"<CR>']],
			\ "Line":[["<ESC>", ':exec g:Lf_py "lineExplManager.quit()"<CR>']],
			\}
let g:Lf_HideHelp = 1
let g:Lf_PreviewInPopup = 1
"leaderf tags
let g:Lf_Gtagslabel = 'native-pygments'
nn <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
nn <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
nn <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
nn <leader>ft :<C-U>Leaderf filetype<CR>
" repo setting
let g:Lf_RootMarkers=['.root']
let g:Lf_ExternalCommand = 'fd --type file "%s"'
" repo files
"let g:Lf_UseVersionControlTool = 0
let g:Lf_ShowDevIcons = 0
