return function(use)
    -- Extras
    use("mbbill/undotree")
    use("navarasu/onedark.nvim")
    use("theprimeagen/harpoon")
    use("tpope/vim-sleuth")
    use("johmsalas/text-case.nvim")
    use("christoomey/vim-tmux-navigator")

    use({
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({})
        end,
    })
    use({
        "kylechui/nvim-surround",
        tag = "*",
        config = function()
            require("nvim-surround").setup({})
        end,
    })
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({})
        end,
    })
    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({})
        end,
    })
    use({
        "unblevable/quick-scope",
        setup = function()
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
    })

    -- Fuzzy Finder (files, lsp, etc)
    use("stevearc/dressing.nvim")
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

    -- Git related plugins
    use("tpope/vim-fugitive")
    use("lewis6991/gitsigns.nvim")
    use("kdheepak/lazygit.nvim")

    -- Language servers and related
    use({
        "VonHeikemen/lsp-zero.nvim",
        requires = {
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
    })

    use("jose-elias-alvarez/null-ls.nvim")
    use("mfussenegger/nvim-dap")

    use({ -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        run = function()
            pcall(require("nvim-treesitter.install").update({ with_sync = true }))
        end,
    })

    use({ -- Additional text objects via treesitter
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    })
end
