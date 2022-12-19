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
    local map = function(mode, keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end
    local telescope = require('telescope.builtin')

    map('n', '<leader>lh', vim.lsp.buf.hover, '[H]over Documentation')
    map('n', '<leader>lca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('n', '<leader>lrn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('n', '<leader>lf', vim.lsp.buf.format, '[F]ormat')
    map('i', '<C-h>', vim.lsp.buf.signature_help, 'signature_help')

    map('n', '<leader>ld', telescope.lsp_definitions, '[D]efinition')
    map('n', '<leader>lws', telescope.lsp_workspace_symbols, '[W]orkspace [S]ymbols')
    map('n', '<leader>ls', telescope.lsp_document_symbols, 'Document [S]ymbols')
    map('n', '<leader>lr', telescope.lsp_references, '[R]eferences')

    map('n', '<leader>vd', vim.diagnostic.open_float, '[V]iew [D]iagnostic')
    map('n', '[d', vim.diagnostic.goto_next, 'Goto next')
    map('n', ']d', vim.diagnostic.goto_prev, 'Goto prev')


    -- Diagnostics
    map('n', '[d', vim.diagnostic.goto_prev)
    map('n', ']d', vim.diagnostic.goto_next)
    map('n', '<leader>vd', vim.diagnostic.open_float)
    map('n', '<leader>vl', telescope.loclist, '[V]iew [L]oclist')
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
