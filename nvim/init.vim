call plug#begin('~/.config/nvim/plugged')
" conquer of completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Themes
Plug 'projekt0n/github-nvim-theme'

" lua Tree and icons
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" linting
Plug 'dense-analysis/ale'

Plug 'knubie/vim-kitty-navigator', {'do': 'cp ./*.py ~/.config/kitty/'}

" kitty
Plug 'fladson/vim-kitty'
Plug 'knubie/vim-kitty-navigator'

" firenvim
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }


" latex
Plug 'lervag/vimtex'


" debug
Plug 'puremourning/vimspector'

call plug#end()

set nocompatible
set spelllang=en
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

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ' ''<Left>
inoremap " ""<Left>
autocmd FileType html inoremap  < <><Left>

set scrolloff=8
set sidescrolloff=8
cabbrev h vert rightb h
let mapleader = "ö"
nmap <leader>C  :edit $MYVIMRC<cr>
nmap <leader>R  :source $MYVIMRC<cr>

" snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


" tex settings
let g:vimtex_view_method='zathura'
let g:tex_flavor='latex'
set conceallevel=1
let g:tex_conceal='abdmg'
autocmd FileType tex autocmd TextChanged,TextChangedI <buffer> silent write

let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'ignoreKeys': {
        \ 'normal': ['<C-1>', '<C-2>', '<C-3>', '<C-4>', '<C-5>', '<C-6>', '<C-7>', '<C-8>', '<C-9>']
            \}
        \},
        \ 'localSettings':{
        \ '.*': {
            \ 'takeover': 'never'
        \ }
        \ }
    \ }
    
" firenvim for overleaf
if exists('g:started_by_firenvim')
    nnoremap <C-CR> <Esc>:w<CR>:call firenvim#eval_js('document.querySelector(".btn-recompile").click()')<CR>

    let g:vimtex_compiler_enabled = 0
endif


autocmd FileType python map <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:/ \\x1b ipython3 ' shellescape(@%, 1) '\\x1b \\x0d'<CR>

autocmd FileType python imap <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:/ \\x1b ipython3 ' shellescape(@%, 1) '\\x1b \\x0d'<CR>

" sends text to title beginning with R
" inspect with kitty @ ls
" closing () bracket needs to be escaped
autocmd FileType r map <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:^R \\x1b isource\(\"'.shellescape(@%).'\"\)  \\x0d \\x1b' <CR>

autocmd FileType r imap <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:^R \\x1b isource("'.shellescape(@%).'\")  \\x0d \\x1b'<CR>


" autocmd FileType r imap <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:R \\x1b isource(\"' shellescape(@%, 1) '\")'<CR>


" Start NERDTree. If a file is specified, move the cursor to its window.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
"
"" Open the existing NERDTree on each new tab.
"autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

"vim tex

" autosave

" coc settings
source $HOME/.config/nvim/general/cocset.vim

" tree
source $HOME/.config/nvim/general/tree.lua
source $HOME/.config/nvim/general/firsttree.vim

" colorscheme TODO
"source $HOME/.config/nvim/general/colorscheme.lua
colorscheme github_*
"colorscheme onedark 


" telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
