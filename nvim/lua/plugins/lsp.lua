local myFunc = require("config.functions")

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
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
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()
            local cmp_format = lsp_zero.cmp_format()

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                formatting = cmp_format,
                sources = {
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "git" },
                    { name = "luasnip" },
                    { name = "buffer", keyword_length = 5 },
                    { name = "copilot" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                }),
                completion = {
                    completeopt = "menu,menuone,noinsert",
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
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(_, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
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

            require("mason").setup()
            require("mason-lspconfig").setup({
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function() require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls()) end,
                    eslint = function()
                        require("lspconfig").eslint.setup({
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

            -- Signs
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },
}
