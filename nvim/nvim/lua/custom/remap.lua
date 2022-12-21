vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Improvements
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Keep movement centered
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- Copy and Paste
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste without losing' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy system' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy system' })
vim.keymap.set('n', 'Y', 'y$', { desc = 'Copy from cursor to eol' })
vim.keymap.set('n', '<leader>Y', "\"+y$", { desc = 'Copy system' })

-- Search and 
vim.keymap.set('n', '<leader>sr', ':%s///g<Left><Left><Left>', { desc = 'Search and Replace' })
vim.keymap.set('v', '<leader>sr', ':s/\\%V//g<Left><Left><Left>', { desc = 'Search and Replace' })

