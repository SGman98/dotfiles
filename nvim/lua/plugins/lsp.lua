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
        { "williamboman/mason-lspconfig.nvim" },
        { "williamboman/mason.nvim", build = ":MasonUpdate" },
    },

    config = function()
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local lspconfig = require("lspconfig")

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())

        local servers = {
            eslint = {
                on_attach = function(_, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            },
        }

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
            },
            automatic_installation = true,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
        lspconfig.uiua.setup({})

        -- Signs
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
    end,
}
