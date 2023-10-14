return {
    {
        "stevearc/oil.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        },
        opts = {
            columns = {
                "icon",
                "permissions",
            },
        },
        lazy = false,
        keys = {
            { "-", vim.cmd.Oil, desc = "Open parent directory" },
        },
    },
}
