return {
    {
        "folke/lazydev.nvim",
        dependencies = {
            {
                "hrsh7th/nvim-cmp",
                opts = function(_, opts)
                    table.insert(opts.sources or {}, {
                        name = "lazydev",
                        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                    })
                end,
            },
        },
        ft = "lua", -- only load on lua files
        opts = {},
    },
}
