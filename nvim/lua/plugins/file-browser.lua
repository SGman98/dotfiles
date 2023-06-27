return {
    {
        "stevearc/oil.nvim",
        config = true,
        lazy = false,
        keys = {
            { "-", vim.cmd.Oil, desc = "Open parent directory" },
        },
    },
}
