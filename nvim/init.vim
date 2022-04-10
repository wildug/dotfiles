call plug#begin('~/.config/nvim/plugged')   
" no coc anymore?
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For luasnip users.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Themes
Plug 'projekt0n/github-nvim-theme'

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

" debug
Plug 'puremourning/vimspector'

" autopairs
Plug 'windwp/nvim-autopairs'
call plug#end()

set nocompatible
set spelllang=en
set relativenumber
set number
set smartcase
set clipboard+=unnamedplus

" might delete
set hidden

set autoindent
set smartindent

set tabstop=4
set shiftwidth=4
set expandtab

source $HOME/.config/nvim/general/keybindings.lua

set cursorline
set cursorlineopt=number

set scrolloff=8
set sidescrolloff=8
cabbrev h vert rightb h
let mapleader = "ö"
nmap <leader>C  :edit $MYVIMRC<cr>
nmap <leader>R  :source $MYVIMRC<cr>


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
    inoremap <C-CR> <Esc>:w<CR>:call firenvim#eval_js('document.querySelector(".btn-recompile").click()')<CR>
    vnoremap <C-CR> <Esc>:w<CR>:call firenvim#eval_js('document.querySelector(".btn-recompile").click()')<CR>
    let g:vimtex_view_enabled = 0
    set guifont=FiraCode_Font_Mono:h10
    set columns=101
    set lines=45
endif


autocmd FileType python map <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:/ \\x1b ipython3 ' shellescape(@%, 1) '\\x1b \\x0d'<CR>

autocmd FileType python imap <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:/ \\x1b ipython3 ' shellescape(@%, 1) '\\x1b \\x0d'<CR>

" sends text to title beginning with R
" inspect with kitty @ ls
" closing () bracket needs to be escaped
autocmd FileType r map <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:^R \\x1b isource\(\"'.shellescape(@%).'\"\)  \\x0d \\x1b' <CR>

autocmd FileType r imap <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:^R \\x1b isource("'.shellescape(@%).'\")  \\x0d \\x1b'<CR>


" autocmd FileType r imap <buffer> <F9> :w<CR> :silent exec '!kitty @ send-text -m title:R \\x1b isource(\"' shellescape(@%, 1) '\")'<CR>



"set updatetime=2000
"set completeopt-=preview
" basic lsp settings without cmp
"source $HOME/.config/nvim/general/lspsettings.lua
"
" with cmp
source $HOME/.config/nvim/general/cmpsettings.lua
" autopairs
source $HOME/.config/nvim/general/autopairs.lua

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
