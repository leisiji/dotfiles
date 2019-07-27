set number
set scrolloff=10
set tags=./.tags;,.tags
let g:gen_tags#gtags_default_map=1
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_winsize=25
let g:netrw_browse_split=3

noremap <C-r> :Leaderf --fuzzy function<CR>
noremap <C-p> :Leaderf --fuzzy file<CR>
noremap <C-f> :Leaderf --fuzzy line<CR>
noremap <F7> :Leaderf --fuzzy tag<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
noremap <F2> :Vexplore<CR>
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

call plug#begin('~/.vim/plugged')

"Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'itchyny/lightline.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-gtags'
Plug 'jsfaint/gen_tags.vim'

call plug#end()

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

set background=dark
color seoul256
