local myFunc = require("config.functions")

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP Actions",
    callback = function(event)
        local function map(mode, l, r, desc)
            local opts = { buffer = event.buf, desc = desc }
            vim.keymap.set(mode, l, r, opts)
        end
        -- Diagnostics
        map("n", "<leader>dv", vim.diagnostic.open_float, "View Diagnostics")
        map("n", "[d", vim.diagnostic.goto_prev)
        map("n", "]d", vim.diagnostic.goto_next)
        -- LSP
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
        map("i", "<C-h>", vim.lsp.buf.signature_help)
        -- Formatting
        map({ "n", "v" }, "<leader>ff", myFunc.format, "Format")
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

        local lsp_capabilities = cmp_nvim_lsp.default_capabilities()

        local default_setup = function(server)
            require("lspconfig")[server].setup({
                capabilities = lsp_capabilities,
            })
        end

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
            },
            automatic_installation = true,
            handlers = {
                default_setup,
                eslint = function()
                    lspconfig.eslint.setup({
                        on_attach = function(_, bufnr)
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                buffer = bufnr,
                                command = "EslintFixAll",
                            })
                        end,
                    })
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
