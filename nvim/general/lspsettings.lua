local lsp_installer = require("nvim-lsp-installer")

local opts = { noremap=true }

local keymap = vim.api.nvim_buf_set_keymap

local function on_attach(client_bufnr)
     vim.api.nvim_buf_set_option(client_bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    keymap(client_bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
     keymap(client_bufnr, 'i', '<C-space>', '<C-x><C-o>', opts)
     keymap(client_bufnr, 'i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
     keymap(client_bufnr, 'i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})
     keymap(client_bufnr, 'i', '<CR>', 'pumvisible() ? "\\<ESC>a" : "\\<CR>"', {expr = true})

      keymap(client_bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      keymap(client_bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      keymap(client_bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      keymap(client_bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      keymap(client_bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      keymap(client_bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      keymap(client_bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      keymap(client_bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      keymap(client_bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      keymap(client_bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      keymap(client_bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

--      if client_bufnr.resolved_capabilities.document_highlight then
--        vim.cmd [[
--          hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
--          hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
--          hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
--          augroup lsp_document_highlight
--            autocmd! * <buffer>
--            autocmd! CursorHold <buffer> lua vim.lsp.buf.hover()
--            autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--          augroup END
--        ]]
--    end

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
local border = {
    {"🭽", "FloatBorder"},
    {"▔", "FloatBorder"},
    {"🭾", "FloatBorder"},
    {"▕", "FloatBorder"},
    {"🭿", "FloatBorder"},
    {"▁", "FloatBorder"},
    {"🭼", "FloatBorder"},
    {"▏", "FloatBorder"},
}

local handlers = {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local options = {
        on_attach  = on_attach,
        handlers = handlers,
    }
    if enhance_server_opts[server.name] then
    -- Enhance the default opts with the server-specific ones
        enhance_server_opts[server.name](options)
    end
    server:setup(options)
end)


