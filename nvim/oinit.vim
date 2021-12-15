call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

" For vsnip user.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Themes
Plug 'projekt0n/github-nvim-theme'


" requires
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()


set relativenumber
set number
set cmdheight=1
set smartcase
set autoindent
set smartindent
set syntax
nnoremap Y y$



autocmd TextChanged,TextChangedI <buffer> silent write
map <F8> :w <CR> :!python3 % <CR>



"source $HOME/.config/nvim/general/settings.vim



source $HOME/.config/nvim/general/colorscheme.lua
colorscheme github_*


set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  vim.lsp.set_log_level("debug")
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body)

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      { name = 'vsnip' },


      { name = 'buffer' },
    }
  })

  -- Setup lspconfig.
  require('lspconfig').pyright.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }

  require'lspconfig'.clangd.setup {}

EOF

