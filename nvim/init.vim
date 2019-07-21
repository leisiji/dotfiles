set number
set tags=./.tags;,.tags
let g:gen_tags#gtags_default_map=1

noremap <C-r> :Leaderf --fuzzy function<CR>
noremap <C-f> :Leaderf --fuzzy line<CR>
noremap <C-p> :Leaderf --fuzzy file<CR>
noremap <F7> :Leaderf --fuzzy tag<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

call plug#begin('~/.vim/plugged')

"Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Yggdroot/indentLine'
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
