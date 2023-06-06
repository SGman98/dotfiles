return {
    -- Language servers and related
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Autocompletion
            "hrsh7th/nvim-cmp",

            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",

            -- Snippets
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("luasnip").filetype_extend("typescriptreact", { "javascriptreact" })
                end,
            },
            "rafamadriz/friendly-snippets",
        },
    },

    { "jose-elias-alvarez/null-ls.nvim", config = true },

    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "jose-elias-alvarez/null-ls.nvim",
            "williamboman/mason.nvim",
        },
        config = function()
            local null_ls = require("null-ls")

            require("mason-null-ls").setup({
                ensure_installed = {
                    "markdownlint",
                    "prettier",
                    "shfmt",
                    "black",
                    "flake8",
                    "stylua",
                },
                automatic_installation = true,
                handlers = {
                    flake = function(_, _)
                        null_ls.register(null_ls.builtins.diagnostics.flake8.with({
                            extra_args = { "--max-line-length=88", "--extend-ignore=E203" },
                        }))
                    end,
                },
            })
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        opts = {
            auto_close = true,
            use_diagnostic_signs = true,
        },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble toggle" },
            { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble workspace diagnostics" },
            { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble document diagnostics" },
            { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble loclist" },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble quickfix" },
            { "<leader>gr", "<cmd>TroubleToggle lsp_references<cr>", desc = "Trouble references" },
        },
    },
}
