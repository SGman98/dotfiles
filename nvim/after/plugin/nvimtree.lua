require("nvim-tree").setup({
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    view = {
        side = "right",
    },
})
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>o", vim.cmd.NvimTreeFocus)
