local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>fa", mark.add_file, { desc = "Harpoon add file" })
vim.keymap.set("n", "<leader>fu", ui.toggle_quick_menu, { desc = "Harpoon quick menu" })
vim.keymap.set("n", "<leader>fn", function() ui.nav_file(1) end, { desc = "Harpoon nav 1" })
vim.keymap.set("n", "<leader>fe", function() ui.nav_file(2) end, { desc = "Harpoon nav 2" })
vim.keymap.set("n", "<leader>fi", function() ui.nav_file(3) end, { desc = "Harpoon nav 3" })
vim.keymap.set("n", "<leader>fo", function() ui.nav_file(4) end, { desc = "Harpoon nav 4" })
