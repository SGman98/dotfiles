local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'clangd',
    'gopls',
    'pyright',
    'rust_analyzer',
    'sumneko_lua',
    'tsserver',
    'eslint'
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

lsp.set_preferences({
    sign_icons = {}
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function (_, bufnr)
    local telescope = require('telescope.builtin')
    local opts = { buffer = bufnr }
    local wk = require('which-key')

    wk.register({
        l = {
            name = 'LSP',
            h = { vim.lsp.buf.hover, 'Hover' },
            f = { vim.lsp.buf.format, 'Format' },
            ca = { vim.lsp.buf.code_action, 'Code Action' },
            rn = { vim.lsp.buf.rename, 'Rename' },
            d = { telescope.lsp_definitions, 'Definitions' },
            r = { telescope.lsp_references, 'References' },
            ws = { telescope.lsp_workspace_symbols, 'Workspace Symbols' },
            ds = { telescope.lsp_document_symbols, 'Document Symbols' },
        },
        d = {
            name = 'Diagnostics',
            v = { vim.diagnostic.open_float, 'View Diagnostics' },
            l = { telescope.loclist, 'View loclist' },
        }
    }, { prefix = '<leader>' })

    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)

    -- Diagnostics
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end)


lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})

local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local null_opts = lsp.build_options('null-ls', {
    on_attach = function (client, bufnr)
        if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function ()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end
})

null_ls.setup({
    on_attach = null_opts.on_attach,
    sources = {
        --- do whatever you need to do
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint,

        -- markdown
        null_ls.builtins.formatting.remark,
    }
})

lsp.setup()

vim.diagnostic.config {
    virtual_text = true
}

require('fidget').setup()
