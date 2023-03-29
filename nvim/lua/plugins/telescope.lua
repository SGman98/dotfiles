return {
    { "stevearc/dressing.nvim", event = "VeryLazy" },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
            },
        },
        config = function()
            local telescope = require("telescope.builtin")

            local function project_files()
                vim.fn.system("git rev-parse --is-inside-work-tree")
                if vim.v.shell_error == 0 then
                    require("telescope.builtin").git_files({
                        show_untracked = true,
                    })
                else
                    require("telescope.builtin").find_files()
                end
            end

            -- FILE PICKERS
            vim.keymap.set("n", "<leader>sf", project_files, { desc = "Search project files" })
            vim.keymap.set("n", "<leader>sc", telescope.grep_string, { desc = "Search current word" })
            vim.keymap.set("n", "<leader>sw", telescope.live_grep, { desc = "Search by grep" })

            -- VIM PICKERS
            vim.keymap.set("n", "<leader>sb", telescope.buffers, { desc = "Search buffers" })
            vim.keymap.set("n", "<leader>so", telescope.oldfiles, { desc = "Search oldfiles" })
            vim.keymap.set("n", "<leader>st", telescope.tags, { desc = "Search tags" })
            vim.keymap.set("n", "<leader>sh", telescope.help_tags, { desc = "Search help" })
            vim.keymap.set("n", "<leader>dl", telescope.loclist, { desc = "Search loclist" })
            vim.keymap.set("n", "<leader>sk", telescope.keymaps, { desc = "Search keymaps" })
            vim.keymap.set("n", "z=", telescope.spell_suggest, { desc = "Spell suggest" })
            vim.keymap.set("n", "<leader>sp", telescope.pickers, { desc = "Search pickers" })

            -- LSP PICKERS
            vim.keymap.set("n", "<leader>lr", telescope.lsp_references, { desc = "Search references" })
            vim.keymap.set("n", "<leader>lsd", telescope.lsp_document_symbols, { desc = "Search document symbols" })
            vim.keymap.set("n", "<leader>lsw", telescope.lsp_workspace_symbols, { desc = "Search workspace symbols" })
            vim.keymap.set("n", "<leader>sd", telescope.diagnostics, { desc = "Search diagnostics" })
            vim.keymap.set("n", "<leader>ld", telescope.lsp_definitions, { desc = "Go to definition" })

            -- GIT PICKERS
            vim.keymap.set("n", "<leader>gc", telescope.git_commits, { desc = "Git commits" })
            vim.keymap.set("n", "<leader>gb", telescope.git_branches, { desc = "Git commits" })
            vim.keymap.set("n", "<leader>gs", telescope.git_status, { desc = "Git status" })
            vim.keymap.set("n", "<leader>gt", telescope.git_stash, { desc = "Git stash" })
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
        dependencies = "nvim-telescope/telescope.nvim",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
}
