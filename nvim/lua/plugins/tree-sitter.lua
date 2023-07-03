return {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-context",
    },
    keys = {
        { "v", desc = "Increment selection", mode = "x" },
        { "V", desc = "Shrink selection", mode = "x" },
    },
    cmd = { "TSUpdate", "TSInstall", "TSInstallInfo", "TSModuleInfo", "TSConfigInfo" },
    opts = {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = nil,
                node_incremental = "v",
                scope_incremental = nil,
                node_decremental = "V",
            },
        },

        -- See: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                    ["as"] = "@class.outer", -- class or struct
                    ["is"] = "@class.inner", -- class or struct
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["al"] = "@loop.outer",
                    ["il"] = "@loop.inner",
                    ["ac"] = "@comment.outer",
                    ["ic"] = "@comment.outer", -- inner not working
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]s"] = "@class.outer",
                    ["]c"] = "@comment.outer",
                    ["]a"] = "@parameter.inner",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]S"] = "@class.outer",
                    ["]C"] = "@comment.outer",
                    ["]A"] = "@parameter.inner",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[s"] = "@class.outer",
                    ["[c"] = "@comment.outer",
                    ["[a"] = "@parameter.inner",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[S"] = "@class.outer",
                    ["[C"] = "@comment.outer",
                    ["[A"] = "@parameter.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner",
                },
            },
        },
    },
}
