require("textcase").setup({})
require("telescope").load_extension("textcase")
vim.keymap.set("n", "ga.", vim.cmd.TextCaseOpenTelescope)
vim.keymap.set("v", "ga.", vim.cmd.TextCaseOpenTelescope)
