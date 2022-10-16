-- sets
local set = vim.opt

set.swapfile = false
set.backup = false
set.colorcolumn = '80'
set.listchars = 'tab:  ›,trail:·'
set.list = true

-- general
lvim.log.level = "warn"
lvim.format_on_save = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- Additional Plugins
lvim.plugins = {
  { "unblevable/quick-scope" },
  { "tpope/vim-surround" },
}

vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

vim.api.nvim_create_autocmd("ColorScheme",
  { pattern = { "*" }, command = "highlight QuickScopePrimary guifg=#00ff00 gui=underline ctermfg=155 cterm=underline" })
vim.api.nvim_create_autocmd("ColorScheme",
  { pattern = { "*" }, command = "highlight QuickScopeSecondary guifg=#00ffff gui=underline ctermfg=81 cterm=underline" })

-- Paste without losing pasted text use <leader>p
lvim.keys.normal_mode["<leader>p"] = '"_dP'
