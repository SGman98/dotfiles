return {
    -- Language servers and related
    {
        "VonHeikemen/lsp-zero.nvim",
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
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
    },

    -- Useful status updates for LSP
    "j-hui/fidget.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "jay-babu/mason-null-ls.nvim",
    "mfussenegger/nvim-dap",
}
