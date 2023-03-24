return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>",      desc = "Decrement selection", mode = "x" },
    },
    opts = {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "typescript", "help" },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<c-space>",
                node_incremental = "<c-space>",
                scope_incremental = "<nop>",
                node_decremental = "<bs>",
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
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
                    ["ic"] = "@comment.inner",
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
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
