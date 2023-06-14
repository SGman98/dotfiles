return {
    {
        "ggandor/leap.nvim",
        dependencies = { "ggandor/leap-ast.nvim", "nvim-treesitter/nvim-treesitter" },
        config = true,
        keys = {
            { "gf", "<Plug>(leap-forward-to)", mode = { "n", "x", "o" }, desc = "Leap forward to" },
            { "gt", "<Plug>(leap-forward-till)", mode = { "n", "x", "o" }, desc = "Leap forward till" },
            { "gF", "<Plug>(leap-backward-to)", mode = { "n", "x", "o" }, desc = "Leap backward to" },
            { "gT", "<Plug>(leap-backward-till)", mode = { "n", "x", "o" }, desc = "Leap backward till" },
            { "gw", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from window" },
            { "ga", "<cmd>lua require('leap-ast').leap()<cr>", mode = { "n", "x", "o" }, desc = "Leap ast" },
        },
    },
}
