return {
    "tpope/vim-sleuth",
    "tpope/vim-obsession",

    {
        "nvzone/showkeys",
        cmd = "ShowkeysToggle",
        opts = {
            show_count = true,
            position = "top-right"
        },
    },

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
        opts = {},
    },
    {
        "tummetott/unimpaired.nvim",
        event = { "VeryLazy" },
        opts = {},
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = { "VeryLazy" },
        opts = {},
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        main = "ibl",
        opts = {
            scope = { enabled = false },
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "TodoTelescope" },
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
    {
        "aserowy/tmux.nvim",
        config = function()
            local tmux = require("tmux")
            tmux.setup({
                navigation = {
                    cycle_navigation = false,
                    enable_default_keybindings = false,
                },
                resize = {
                    enable_default_keybindings = false,
                },
            })

            vim.keymap.set("n", "<C-Left>", tmux.move_left)
            vim.keymap.set("n", "<C-Right>", tmux.move_right)
            vim.keymap.set("n", "<C-Up>", tmux.move_top)
            vim.keymap.set("n", "<C-Down>", tmux.move_bottom)
            vim.keymap.set("n", "<S-Left>", tmux.resize_left)
            vim.keymap.set("n", "<S-Right>", tmux.resize_right)
            vim.keymap.set("n", "<S-Up>", tmux.resize_top)
            vim.keymap.set("n", "<S-Down>", tmux.resize_bottom)
        end,
    },
}
