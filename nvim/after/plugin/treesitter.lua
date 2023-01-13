require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "typescript", "help" },

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
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
                ["ac"] = "@class.outer",
                ["ib"] = "@block.inner",
                ["ic"] = "@class.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
                ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
                ["]C"] = "@class.outer",
                ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
                ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[C"] = "@class.outer",
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
})
