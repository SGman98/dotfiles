return {
    "nvim-tree/nvim-tree.lua",
    keys = {
        { "<leader>e", vim.cmd.NvimTreeToggle },
        { "<leader>o", vim.cmd.NvimTreeFocus },
    },
    config = {
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
        view = {
            side = "right",
        },
    },
}
