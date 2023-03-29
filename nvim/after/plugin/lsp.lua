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
    local function map(mode, l, r, desc)
        local opts = { desc = desc, buffer = bufnr }
        vim.keymap.set(mode, l, r, opts)
    end

    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
    map("i", "<C-h>", vim.lsp.buf.signature_help)

    -- Diagnostics
    map("n", "<leader>dv", vim.diagnostic.open_float, "View Diagnostics")
    map("n", "[d", vim.diagnostic.goto_prev)
    map("n", "]d", vim.diagnostic.goto_next)
end)

lsp.nvim_workspace()

lsp.setup()

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

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

require("mason-null-ls").setup({
    ensure_installed = { "markdownlint", "prettier", "shfmt", "black", "flake8" },
    automatic_setup = true,
    automatic_installation = true,
})

require("mason-null-ls").setup_handlers()

vim.diagnostic.config({
    virtual_text = true,
})
