local myFunc = require("config.functions")

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP Actions",
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local function map(mode, l, r, desc)
            local opts = { buffer = event.buf, desc = desc }
            vim.keymap.set(mode, l, r, opts)
        end
        -- Diagnostics
        map("n", "<leader>dv", vim.diagnostic.open_float, "View Diagnostics")
        map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end)
        map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end)
        -- LSP
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
        map("i", "<C-h>", vim.lsp.buf.signature_help)
        -- Formatting
        map({ "n", "v" }, "<leader>ff", myFunc.format, "Format")

        -- Highlight current cursor
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = event2.buf })
                end,
            })
        end

        -- Handle Inlay Hints
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("n", "yoy", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end, "Toggle Inlay Hints")
            map("n", "[oy", function() vim.lsp.inlay_hint.enable(true) end, "Show Inlay Hints")
            map("n", "]oy", function() vim.lsp.inlay_hint.enable(false) end, "Hide Inlay")
        end
    end,
})

return {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "mason-org/mason-lspconfig.nvim" },
        { "mason-org/mason.nvim", build = ":MasonUpdate" },
    },

    config = function()
        -- Applies to every server
        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        -- Keep lspconfig's eslint on_attach (defines LspEslintFixAll) and fix on save
        local eslint_on_attach = vim.lsp.config.eslint.on_attach
        vim.lsp.config("eslint", {
            on_attach = function(client, bufnr)
                if eslint_on_attach then eslint_on_attach(client, bufnr) end
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "LspEslintFixAll",
                })
            end,
        })

        vim.lsp.config("tinymist", {
            settings = {
                exportPdf = "onType",
            },
        })

        require("mason").setup({})
        -- Installed servers are enabled automatically (automatic_enable)
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "eslint",
                "lua_ls",
                "ruff",
                "taplo",
                "tinymist",
                "ts_ls",
            },
            automatic_enable = {
                -- rust-analyzer is managed by rustaceanvim, stylua runs through none-ls
                exclude = { "rust_analyzer", "stylua" },
            },
        })

        vim.diagnostic.config({
            virtual_lines = { current_line = true },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
            },
        })
    end,
}
