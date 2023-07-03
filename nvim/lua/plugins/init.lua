return {
    "tpope/vim-sleuth",
    "tpope/vim-obsession",

    {
        "NvChad/nvim-colorizer.lua",
        cmd = { "ColorizerToggle" },
        opts = {
            filetypes = {
                scss = { css = true, sass = { enable = true } },
            },
        },
    },

    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        config = true,
    },
    {
        "tummetott/unimpaired.nvim",
        event = { "VeryLazy" },
        config = true,
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = { show_current_context = true },
    },
}
