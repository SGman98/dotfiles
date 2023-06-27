return {
    "theprimeagen/harpoon",
    keys = {
        { "<leader>fa", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Harpoon add file" },
        { "<leader>fu", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon quick menu" },
        { "<leader>fn", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Harpoon nav 1" },
        { "<leader>fe", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Harpoon nav 2" },
        { "<leader>fi", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Harpoon nav 3" },
        { "<leader>fo", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Harpoon nav 4" },
    },
}
