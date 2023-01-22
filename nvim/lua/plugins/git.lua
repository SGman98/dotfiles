return {
    -- Git related plugins
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gg", "<cmd>G | only<cr>", desc = "Git fugitive" },
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
                map({ "n", "v" }, "<leader>hs", gs.stage_hunk)
                map({ "n", "v" }, "<leader>hr", gs.reset_hunk)
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
