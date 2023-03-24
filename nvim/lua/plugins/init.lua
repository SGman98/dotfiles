return {
    "tpope/vim-sleuth",
    "tpope/vim-obsession",
    "tpope/vim-abolish",

    "christoomey/vim-tmux-navigator",
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            filetypes = {
                "*",
                "!fugitive", -- it was causing issues in status file
            },
            user_default_options = {
                css = true,
                sass = { enable = true },
            },
        },
    },

    { "windwp/nvim-autopairs", config = true },
    { "windwp/nvim-ts-autotag", config = true },
    { "kylechui/nvim-surround", config = true },
    { "tummetott/unimpaired.nvim", config = true },

    "JoosepAlviste/nvim-ts-context-commentstring",
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },
    { "nvim-lualine/lualine.nvim", config = true },

    { "stevearc/dressing.nvim", event = "VeryLazy" },
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
}
