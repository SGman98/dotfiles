return {
    { "stevearc/dressing.nvim", event = "VeryLazy" },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local lga_actions = require("telescope-live-grep-args.actions")
            telescope.setup({
                pickers = {
                    colorscheme = {
                        enable_preview = true,
                    },
                },
                extensions = {
                    live_grep_args = {
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                                ["<C-space>"] = lga_actions.to_fuzzy_refine,
                            },
                        },
                    },
                },
            })

            -- Load extensions
            telescope.load_extension("fzf")
            telescope.load_extension("live_grep_args")
        end,
        cmd = "Telescope",
        keys = {
            -- FILE PICKERS
            {
                "<leader>sf",
                function()
                    local excludes = { ".git", "node_modules", ".next", "amplify" }

                    require("telescope.builtin").find_files({
                        hidden = true,
                        follow = true,
                        no_ignore = true,
                        find_command = vim.iter({
                            "rg",
                            "--files",
                            "--hidden",
                            "--follow",
                            "--no-ignore",
                            vim.tbl_map(function(dir) return { "--glob", "!" .. dir } end, excludes),
                        })
                            :flatten(2)
                            :totable(),
                    })
                end,
                desc = "Search Files",
            },
            {
                "<leader>sgf",
                function()
                    require("telescope.builtin").git_files({
                        show_untracked = true,
                    })
                end,
                desc = "Search Git Files",
            },
            { "<leader>sc", function() require("telescope-live-grep-args.shortcuts").grep_word_under_cursor() end, desc = "Search current word" },
            { "<leader>sw", function() require("telescope").extensions.live_grep_args.live_grep_args() end, desc = "Search by grep" },
            -- VIM PICKERS
            { "<leader>sb", function() require("telescope.builtin").buffers() end, desc = "Search buffers" },
            { "<leader>so", function() require("telescope.builtin").oldfiles() end, desc = "Search oldfiles" },
            { "<leader>st", function() require("telescope.builtin").tags() end, desc = "Search tags" },
            { "<leader>sh", function() require("telescope.builtin").help_tags() end, desc = "Search help" },
            { "<leader>sk", function() require("telescope.builtin").keymaps() end, desc = "Search keymaps" },
            { "<leader>sp", function() require("telescope.builtin").pickers() end, desc = "Search pickers" },
            { "<leader>dl", function() require("telescope.builtin").loclist() end, desc = "Search loclist" },
            { "z=", function() require("telescope.builtin").spell_suggest() end, desc = "Spell suggest" },
            -- LSP PICKERS
            { "<leader>ld", function() require("telescope.builtin").lsp_definitions() end, desc = "Go to definition" },
            { "<leader>lr", function() require("telescope.builtin").lsp_references() end, desc = "Search references" },
            { "<leader>lsd", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Search document symbols" },
            { "<leader>lsw", function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "Search workspace symbols" },
            { "<leader>sd", function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" },
            -- GIT PICKERS
            { "<leader>gc", function() require("telescope.builtin").git_commits() end, desc = "Git commits" },
            { "<leader>gb", function() require("telescope.builtin").git_branches() end, desc = "Git commits" },
            { "<leader>gs", function() require("telescope.builtin").git_status() end, desc = "Git status" },
            { "<leader>gt", function() require("telescope.builtin").git_stash() end, desc = "Git stash" },
        },
    },
}
