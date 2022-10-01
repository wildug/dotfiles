require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "rust_analyzer" },
    automatic_installation = true
    })
require("mason-lspconfig").setup_handlers({
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
    -- Next, you can provide targeted overrides for specific servers.
    ["sumneko_lua"] = function ()
        require("lspconfig").sumneko_lua.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
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
        }
    end,
})
