return {
    {
        "simrat39/rust-tools.nvim",
        config = function()
            require("rust-tools").setup({
                tools = {
                    inlay_hints = {
                        only_current_line = true,
                    },
                    hover_actions = {
                        auto_focus = true,
                    },
                    runnables = {
                        use_telescope = true,
                    },
                },
                server = {
                    settings = {
                        ["rust-analyzer"] = {
                            lens = {
                                enable = true,
                            },
                            checkOnSave = {
                                enable = true,
                                command = "clippy",
                            },
                        },
                    },
                },
            })
        end,
        ft = { "rust", "rs" },
    },
    {
        "saecki/crates.nvim",
        tag = "v0.3.0",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            null_ls = {
                enabled = true,
                name = "crates.nvim",
            },
        },
        event = { "BufRead Cargo.toml" },
    },
}
