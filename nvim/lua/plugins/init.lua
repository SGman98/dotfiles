return {
    "tpope/vim-sleuth",
    "tpope/vim-obsession",
    "tpope/vim-abolish",

    "christoomey/vim-tmux-navigator",
    "kyazdani42/nvim-web-devicons",

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
    { "tummetott/unimpaired.nvim", config = true },

    { "kylechui/nvim-surround", version = "*", event = "VeryLazy", config = true },
    { "lukas-reineke/indent-blankline.nvim", opts = { show_current_context = true } },
    { "folke/neodev.nvim", config = true },
    { "folke/neoconf.nvim", config = true },
}
