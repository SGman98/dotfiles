return {
    {
        "nvim-tree/nvim-tree.lua",
        keys = {
            { "<leader>e", vim.cmd.NvimTreeToggle },
            { "<leader>o", vim.cmd.NvimTreeFocus },
        },
        opts = {
            update_focused_file = {
                enable = true,
                update_cwd = true,
            },
            view = {
                side = "right",
            },
        },
    },
    { "kyazdani42/nvim-web-devicons" },
}
