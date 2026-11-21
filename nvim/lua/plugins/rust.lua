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
                    -- rustup's rust-analyzer proxy is first on PATH but not installed
                    cmd = function() return { vim.env.MASON and vim.env.MASON .. "/bin/rust-analyzer" or "rust-analyzer" } end,
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
