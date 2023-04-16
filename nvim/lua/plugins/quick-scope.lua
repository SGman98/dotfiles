return {
    {
        "ggandor/leap.nvim",
        config = true,
        keys = {
            { "s", "<Plug>(leap-forward-to)", mode = { "n", "x", "o" }, desc = "Leap forward to" },
            { "S", "<Plug>(leap-backward-to)", mode = { "n", "x", "o" }, desc = "Lead backward to" },
        },
    },
}
