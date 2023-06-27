return {
    {
        "stevearc/oil.nvim",
        dependencies = {
            {
                { "nvim-tree/nvim-web-devicons" },
            },
        },
        config = true,
        lazy = false,
        keys = {
            { "-", vim.cmd.Oil, desc = "Open parent directory" },
        },
    },
}
