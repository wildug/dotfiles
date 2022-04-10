local luasnip = require("luasnip")
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    completion = {
        autocomplete = false,
    },

    mapping = {
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),

        ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
              end
        end, { "i", "s" }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
              else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
              end
        end, {'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },

    sources = cmp.config.sources({
        {name = 'nvim_lsp'},
        {name = 'buffer'},
        {name = 'luasnip'},
    })
})

cmp.setup.cmdline('/', {
    sources = {
        {name = 'buffer'},
    }
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
})

local enhance_server_opts = {
    ["sumneko_lua"] = function(options)
        options.settings = {
            Lua = {
                diagnostics = {
                -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                -- Make the server aware of Neovim runtime files
                    library = {
                      [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                      [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
            }
        }
    end,
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local options = {
        capabilites = capabilities,
    }
    if enhance_server_opts[server.name] then
    -- Enhance the default opts with the server-specific ones
        enhance_server_opts[server.name](options)
    end
    server:setup(options)
end)
