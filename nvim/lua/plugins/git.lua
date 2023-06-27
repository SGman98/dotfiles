return {
    -- Git related plugins
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gg", "<cmd>rightbelow vertical G<cr>", desc = "Git fugitive" },
        },
        cmd = "G",
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]h", gs.next_hunk)
                map("n", "[h", gs.prev_hunk)

                -- Actions
                map("n", "<leader>hs", gs.stage_hunk)
                map("n", "<leader>hr", gs.reset_hunk)
                map("v", "<leader>hs", function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                map("v", "<leader>hr", function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                map("n", "<leader>hu", gs.undo_stage_hunk)
                map("n", "<leader>hp", gs.preview_hunk)
                map("n", "<leader>hS", gs.stage_buffer)
                map("n", "<leader>hR", gs.reset_buffer)
                map("n", "<leader>hd", gs.toggle_deleted)

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
        },
    },
}
