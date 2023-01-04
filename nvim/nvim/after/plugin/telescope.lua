require("telescope").setup({})
pcall(require("telescope").load_extension, "fzf")

local telescope = require("telescope.builtin")

local function project_files()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    if vim.v.shell_error == 0 then
        require("telescope.builtin").git_files()
    else
        require("telescope.builtin").find_files()
    end
end

vim.keymap.set("n", "<leader>sb", telescope.buffers, { desc = "Search buffers" })
vim.keymap.set("n", "<leader>sc", telescope.grep_string, { desc = "Search current word" })
vim.keymap.set("n", "<leader>sd", telescope.diagnostics, { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>sd", telescope.diagnostics, { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>sf", project_files, { desc = "Search project files" })
vim.keymap.set("n", "<leader>sh", telescope.help_tags, { desc = "Search help" })
vim.keymap.set("n", "<leader>sk", telescope.keymaps, { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>so", telescope.oldfiles, { desc = "Search oldfiles" })
vim.keymap.set("n", "<leader>sw", telescope.live_grep, { desc = "Search by grep" })
