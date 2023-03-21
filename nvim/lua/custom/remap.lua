-- Improvements
vim.keymap.set({ "n", "v" }, "U", "<C-r>")

-- Move lines
vim.keymap.set("n", "[e", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "]e", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "[<space>", ":call append(line('.')-1, '')<CR>", { desc = "Insert line above" })
vim.keymap.set("n", "]<space>", ":call append(line('.'), '')<CR>", { desc = "Insert line below" })

-- Movement
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "[Q", "<cmd>lprev<CR>zz", { desc = "Previous location list" })
vim.keymap.set("n", "]Q", "<cmd>lnext<CR>zz", { desc = "Next location list" })

vim.keymap.set("v", ">", ">gv", { desc = "Add tab keep selection" })
vim.keymap.set("v", "<", "<gv", { desc = "Remove tab keep selection" })

-- Keep movement centered
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy and Paste
vim.keymap.set("x", "<leader>p", '"_dP', { desc = 'Paste "without losing' })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy system" })
vim.keymap.set("n", "Y", "y$", { desc = "Copy from cursor to eol" })
vim.keymap.set("n", "<leader>Y", '"+y$', { desc = "Copy system" })

-- Search and Replace
vim.keymap.set("n", "<leader>sr", ":%s///g<Left><Left><Left>", { desc = "Search and Replace" })
vim.keymap.set("v", "<leader>sr", ":s/\\%V//g<Left><Left><Left>", { desc = "Search and Replace" })

-- File format
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format)
