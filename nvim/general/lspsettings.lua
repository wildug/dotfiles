local lsp_installer = require("nvim-lsp-installer")

local opts = { noremap=true }

local keymap = vim.api.nvim_buf_set_keymap


local function on_attach(client_bufnr)
     vim.api.nvim_buf_set_option(client_bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

     keymap(client_bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
     keymap(client_bufnr, 'i', '<C-space>', '<C-x><C-o>', opts)
     keymap(client_bufnr, 'i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
     keymap(client_bufnr, 'i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})
end

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
-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local options = {
        on_attach  = on_attach,
    }
    if enhance_server_opts[server.name] then
    -- Enhance the default opts with the server-specific ones
        enhance_server_opts[server.name](options)
    end
    server:setup(options)
end)
