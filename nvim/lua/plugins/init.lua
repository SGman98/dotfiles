return {
    -- Extras
    "mbbill/undotree",
    "navarasu/onedark.nvim",
    "nvim-tree/nvim-tree.lua",
    "theprimeagen/harpoon",
    "tpope/vim-sleuth",
    "johmsalas/text-case.nvim",
    "christoomey/vim-tmux-navigator",
    "tpope/vim-obsession",

    { "folke/zen-mode.nvim", config = {} },
    { "kylechui/nvim-surround", config = {}, version = "*" },
    { "numToStr/Comment.nvim", config = {} },
    { "nvim-lualine/lualine.nvim", config = {} },
    {
        "unblevable/quick-scope",
        init = function()
            vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
            vim.g.rainbow_active = 1
            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = { "*" },
                command = "highlight QuickScopePrimary guifg=#00ff00 gui=underline ctermfg=155 cterm=underline",
            })
            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = { "*" },
                command = "highlight QuickScopeSecondary guifg=#00ffff gui=underline ctermfg=81 cterm=underline",
            })
        end,
    },

    -- Fuzzy Finder (files, lsp, etc)
    "stevearc/dressing.nvim",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },

    -- Git related plugins
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",
    "kdheepak/lazygit.nvim",

    -- Language servers and related
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Useful status updates for LSP
            "j-hui/fidget.nvim",

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

    "jose-elias-alvarez/null-ls.nvim",
    "mfussenegger/nvim-dap",

    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        build = function()
            pcall(require("nvim-treesitter.install").update({ with_sync = true }))
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
    },
}
