-- Improvements
vim.keymap.set({ "n", "v" }, "U", "<C-r>")

vim.keymap.set("v", ">", ">gv", { desc = "Add tab keep selection" })
vim.keymap.set("v", "<", "<gv", { desc = "Remove tab keep selection" })

-- Keep movement centered
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy and Paste
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy system" })
vim.keymap.set("n", "Y", "y$", { desc = "Copy from cursor to eol" })
vim.keymap.set("n", "<leader>Y", '"+y$', { desc = "Copy system" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete char and don't copy" })
vim.keymap.set("n", "X", '"_X', { desc = "Delete char and don't copy" })
vim.keymap.set("v", "x", '"_x', { desc = "Delete char and don't copy" })
vim.keymap.set("v", "X", '"_X', { desc = "Delete char and don't copy" })
vim.keymap.set("v", "p", '"_pP', { desc = "Paste and don't copy" })

-- Search and Replace
vim.keymap.set("n", "<leader>sr", ":%s///g<Left><Left><Left>", { desc = "Search and Replace" })
vim.keymap.set("v", "<leader>sr", ":s/\\%V//g<Left><Left><Left>", { desc = "Search and Replace" })
