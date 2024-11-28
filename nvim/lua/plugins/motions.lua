return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            labels = "arstdhneiofwuygmplcxzbkvjq",
            modes = {
                search = {
                    enabled = false,
                },
            },
        },
        keys = {
            { "<leader>ss", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "<leader>sS", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Flash Treesitter Search" },
        },
    },
    {
        "theprimeagen/harpoon",
        keys = {
            { "<leader>fa", function() require("harpoon.mark").add_file() end, desc = "Harpoon add file" },
            { "<leader>fu", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon quick menu" },
            { "<leader>fn", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon nav 1" },
            { "<leader>fe", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon nav 2" },
            { "<leader>fi", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon nav 3" },
            { "<leader>fo", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon nav 4" },
        },
    },
}
