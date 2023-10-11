local myFunc = require("config.functions")

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        lazy = true,
        config = function() require("lsp-zero.settings").preset({}) end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                config = function() require("luasnip").filetype_extend("typescriptreact", { "javascriptreact" }) end,
            },
            { "petertriho/cmp-git", config = true },
            {
                "zbirenbaum/copilot.lua",
                build = ":Copilot auth",
                dependencies = { "zbirenbaum/copilot-cmp" },
                config = function()
                    require("copilot").setup({
                        suggestion = { enabled = false },
                        panel = { enabled = false },
                        filetypes = {
                            yaml = true,
                            markdown = true,
                            gitcommit = true,
                            -- ["."] = true,
                        },
                    })
                    require("copilot_cmp").setup()
                end,
            },
        },
        config = function()
            require("lsp-zero.cmp").extend()

            local cmp = require("cmp")
            local cmp_action = require("lsp-zero.cmp").action()

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "git" },
                    { name = "luasnip" },
                    { name = "buffer", keyword_length = 5 },
                    { name = "copilot" },
                },
                mapping = {
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                },
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
            { "williamboman/mason.nvim", build = ":MasonUpdate" },
        },
        config = function()
            local lsp = require("lsp-zero")

            lsp.on_attach(function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
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

                -- Formatting
                map({ "n", "v" }, "<leader>ff", myFunc.format, "Format")
            end)

            require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

            lsp.setup()

            -- Signs
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },
}
