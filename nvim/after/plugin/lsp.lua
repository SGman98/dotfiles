local lsp = require("lsp-zero")

lsp.preset({
    name = "minimal",
    set_lsp_keymaps = false,
    manage_nvim_cmp = true,
    suggest_lsp_servers = true,
})

lsp.set_preferences({
    sign_icons = {},
})

lsp.on_attach(function(_, bufnr)
    local telescope = require("telescope.builtin")
    local function map(mode, l, r, desc)
        local opts = { desc = desc, buffer = bufnr }
        vim.keymap.set(mode, l, r, opts)
    end

    map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
    map("n", "<leader>ld", telescope.lsp_definitions, "Definitions")
    map("n", "<leader>lr", telescope.lsp_references, "References")
    map("n", "<leader>lsw", telescope.lsp_workspace_symbols, "Workspace Symbols")
    map("n", "<leader>lsd", telescope.lsp_document_symbols, "Document Symbols")
    map("n", "<leader>dl", telescope.loclist, "View loclist")
    map("i", "<C-h>", vim.lsp.buf.signature_help)

    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")

    -- Diagnostics
    map("n", "<leader>dv", vim.diagnostic.open_float, "View Diagnostics")
    map("n", "[d", vim.diagnostic.goto_prev)
    map("n", "]d", vim.diagnostic.goto_next)
end)

lsp.nvim_workspace()

lsp.setup()

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

require("mason-null-ls").setup({
    ensure_installed = { "stylua", "markdownlint", "prettier", "shfmt", "black", "flake8" },
    automatic_setup = true,
    automatic_installation = true,
})

require("mason-null-ls").setup_handlers()

null_ls.setup({
    on_attach = function(client, bufnr)
        null_opts.on_attach(client, bufnr)
    end,
    sources = {
        -- Python
        null_ls.builtins.diagnostics.flake8.with({ extra_args = { "--max-line-length=88", "--extend-ignore=E203" } }),

        -- Gitsigns
        null_ls.builtins.code_actions.gitsigns,
    },
})

vim.diagnostic.config({
    virtual_text = true,
})

require("fidget").setup()
