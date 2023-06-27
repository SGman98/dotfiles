return {
    "theprimeagen/harpoon",
    keys = {
        { "<leader>fa", function() require('harpoon.mark').add_file() end, desc = "Harpoon add file" },
        { "<leader>fu", function() require('harpoon.ui').toggle_quick_menu() end, desc = "Harpoon quick menu" },
        { "<leader>fn", function() require('harpoon.ui').nav_file(1) end, desc = "Harpoon nav 1" },
        { "<leader>fe", function() require('harpoon.ui').nav_file(2) end, desc = "Harpoon nav 2" },
        { "<leader>fi", function() require('harpoon.ui').nav_file(3) end, desc = "Harpoon nav 3" },
        { "<leader>fo", function() require('harpoon.ui').nav_file(4) end, desc = "Harpoon nav 4" },
    },
}
