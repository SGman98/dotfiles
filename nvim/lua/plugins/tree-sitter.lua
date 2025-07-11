return {
    {
        "echasnovski/mini.operators",
        version = "*",
        opts = {
            exchange = { prefix = "ge" },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        main = "nvim-treesitter.configs",
        build = ":TSUpdate",
        event = { "BufNewFile", "BufReadPost" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/nvim-treesitter-textobjects",
            {
                "echasnovski/mini.ai",
                version = "*",
                opts = function()
                    local spec_treesitter = require("mini.ai").gen_spec.treesitter

                    return {
                        search_method = "cover_or_next",
                        mappings = {
                            goto_left = "gl",
                            goto_right = "gn",
                        },
                        custom_textobjects = {
                            F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
                            c = spec_treesitter({ a = "@comment.outer", i = "@comment.outer" }), -- inner comment not working
                            s = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
                            l = spec_treesitter({ a = "@loop.outer", i = "@loop.inner" }),
                        },
                    }
                end,
            },
        },
        cmd = { "TSConfigInfo", "TSInstall", "TSInstallInfo", "TSModuleInfo", "TSUpdate" },
        opts = {
            ensure_installed = { "regex", "bash", "query" },
            auto_install = true,
            ignore_install = { "csv" },
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = nil,
                    node_incremental = "<leader>v",
                    scope_incremental = nil,
                    node_decremental = "<leader>V",
                },
            },
        },
    },
}
