return {
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        -- rustaceanvim is already lazy and only activates on rust buffers
        lazy = false,
        init = function()
            -- Must be set before the plugin loads
            vim.g.rustaceanvim = {
                tools = {
                    hover_actions = {
                        auto_focus = true,
                    },
                },
                server = {
                    default_settings = {
                        ["rust-analyzer"] = {
                            lens = {
                                enable = true,
                            },
                            check = {
                                command = "clippy",
                            },
                        },
                    },
                },
            }
        end,
    },
    {
        "saecki/crates.nvim",
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        opts = {
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
}
