return {
    "tpope/vim-sleuth",
    "tpope/vim-obsession",

    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            filetypes = {
                scss = { css = true, sass = { enable = true } },
            },
        },
    },

    { "windwp/nvim-autopairs", config = true },
    { "tummetott/unimpaired.nvim", config = true },

    { "kylechui/nvim-surround", version = "*", event = "VeryLazy", config = true },
    { "lukas-reineke/indent-blankline.nvim", opts = { show_current_context = true } },
}
