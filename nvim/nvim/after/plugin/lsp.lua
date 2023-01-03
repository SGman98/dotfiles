local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "clangd",
    "gopls",
    "pyright",
    "rust_analyzer",
    "sumneko_lua",
    "tsserver",
    "eslint",
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
    sign_icons = {},
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
})

lsp.on_attach(function(_, bufnr)
    local telescope = require("telescope.builtin")
    local function map(mode, l, r, desc)
        local opts = { desc = desc, buffer = bufnr }
        vim.keymap.set(mode, l, r, opts)
    end

    map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
    map("n", "<leader>lf", vim.lsp.buf.format, "Format")
    map("n", "<leader>lca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>lrn", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>ld", telescope.lsp_definitions, "Definitions")
    map("n", "<leader>lr", telescope.lsp_references, "References")
    map("n", "<leader>lws", telescope.lsp_workspace_symbols, "Workspace Symbols")
    map("n", "<leader>lds", telescope.lsp_document_symbols, "Document Symbols")
    map("n", "<leader>dl", telescope.loclist, "View loclist")
    map("i", "<C-h>", vim.lsp.buf.signature_help)

    -- Diagnostics
   map("n", "<leader>dv", vim.diagnostic.open_float, "View Diagnostics")
    map("n", "[d", vim.diagnostic.goto_prev)
    map("n", "]d", vim.diagnostic.goto_next)
end)

lsp.configure("sumneko_lua", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        --- do whatever you need to do
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint,

        -- markdown
        null_ls.builtins.formatting.remark,

        -- python
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.flake8.with({ extra_args = { "--max-line-length=88", "--extend-ignore=E203" } }),

        -- Lua
        null_ls.builtins.formatting.stylua,
    },
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

require("fidget").setup()
