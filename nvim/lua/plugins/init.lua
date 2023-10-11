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
        main = "ibl",
        opts = {},
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
}
