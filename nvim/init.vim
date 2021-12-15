call plug#begin('~/.config/nvim/plugged')
" conquer of completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Themes
Plug 'projekt0n/github-nvim-theme'
Plug 'joshdick/onedark.vim'


" Tree and icons
"Plug 'ryanoasis/vim-devicons'
"Plug 'preservim/nerdtree'

" lua Tree and icons
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


Plug 'knubie/vim-kitty-navigator', {'do': 'cp ./*.py ~/.config/kitty/'}

" kitty
Plug 'fladson/vim-kitty'
Plug 'knubie/vim-kitty-navigator'


" firenvim
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" latex
Plug 'lervag/vimtex'

call plug#end()

set nocompatible
set relativenumber
set number
set smartcase
set clipboard+=unnamedplus

set autoindent
set smartindent

set tabstop=4
set shiftwidth=4
set expandtab

nnoremap Y y$
nnoremap <C-i> <C-]>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

set scrolloff=8
set sidescrolloff=8
cabbrev h vert rightb h
let mapleader = "ö"
nmap <leader>C  :edit $MYVIMRC<cr>
nmap <leader>R  :source $MYVIMRC<cr>

" firenvim
if exists('g:started_by_firenvim')
    nnoremap <C-CR> <Esc>:w<CR>:call firenvim#eval_js('document.querySelector(".btn-recompile").click()')<CR>
    au TextChanged * ++nested write
    au TextChangedI * ++nested write
endif

let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'ignoreKeys': {
        \ 'normal': ['<C-1>', '<C-2>', '<C-3>', '<C-4>', '<C-5>', '<C-6>', '<C-7>', '<C-8>', '<C-9>']
        \ }
    \ }
\ }


autocmd FileType python map <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:fish \\x1b ipython3 ' shellescape(@%, 1) '\\x1b \\x0d'<CR>

autocmd FileType python imap <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:fish \\x1b ipython3 ' shellescape(@%, 1) '\\x1b \\x0d'<CR>

" sends text to title beginning with R
" inspect with kitty @ ls
" closing bracket needs to be escaped
autocmd FileType r map <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:^R \\x1b isource\(\"'.shellescape(@%).'\"\)  \\x0d \\x1b' <CR>

autocmd FileType r imap <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:^R \\x1b isource("'.shellescape(@%).'\")  \\x0d \\x1b'<CR>


" autocmd FileType r imap <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:R \\x1b isource(\"' shellescape(@%, 1) '\")'<CR>


" Start NERDTree. If a file is specified, move the cursor to its window.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
"
"" Open the existing NERDTree on each new tab.
"autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif


" autosave
" autocmd TextChanged,TextChangedI <buffer> silent write

" coc settings
source $HOME/.config/nvim/general/cocset.vim

" tree
source $HOME/.config/nvim/general/tree.lua
source $HOME/.config/nvim/general/firsttree.vim

" colorscheme TODO
"source $HOME/.config/nvim/general/colorscheme.lua
colorscheme github_*
"colorscheme onedark 
"

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
