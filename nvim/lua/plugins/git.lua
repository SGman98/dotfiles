return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            { "<leader>gg", "<cmd>rightbelow vertical G<cr>", desc = "Git fugitive" },
        },
        cmd = "G",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]h", function()
                    if vim.wo.diff then return "]h" end
                    vim.schedule(function() gs.nav_hunk("next") end)
                    return "<Ignore>"
                end, { desc = "Next hunk", expr = true })
                map("n", "[h", function()
                    if vim.wo.diff then return "[h" end
                    vim.schedule(function() gs.nav_hunk("prev") end)
                    return "<Ignore>"
                end, { desc = "Previous hunk", expr = true })

                -- Actions
                -- stage_hunk on an already staged hunk unstages it
                map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage/unstage hunk" })
                map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
                map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" })
                map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk" })
                map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
                map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
                map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
                map("n", "yob", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
                map("n", "yod", gs.preview_hunk_inline, { desc = "Preview hunk inline" })
                map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
                map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff this" })

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
            end,
        },
    },
}
