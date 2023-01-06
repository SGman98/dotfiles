local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>gg", ":G | only<CR>", { desc = "Git fugitive" })
vim.keymap.set("n", "<leader>gb", telescope.git_branches, { desc = "Git commits" })
vim.keymap.set("n", "<leader>gc", telescope.git_commits, { desc = "Git commits" })
vim.keymap.set("n", "<leader>gs", telescope.git_status, { desc = "Git status" })
vim.keymap.set("n", "<leader>gt", telescope.git_stash, { desc = "Git stash" })

require("gitsigns").setup({
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
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hS", gs.stage_buffer)
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hd", gs.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
})
