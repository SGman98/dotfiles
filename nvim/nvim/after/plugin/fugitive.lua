local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>gb", telescope.git_branches, { desc = "Git branches" })
vim.keymap.set("n", "<leader>gc", telescope.git_commits, { desc = "Git commits" })
vim.keymap.set("n", "<leader>gf", telescope.git_files, { desc = "Git files" })
vim.keymap.set("n", "<leader>gt", telescope.git_stash, { desc = "Git stash" })
vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit, { desc = "Git lazy" })
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git fugitive" })
