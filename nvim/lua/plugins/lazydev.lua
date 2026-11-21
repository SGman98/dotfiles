return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            -- Load a plugin's types when a file uses its global, not only on require()
            library = {
                { path = "snacks.nvim", words = { "Snacks" } },
            },
        },
    },
}
