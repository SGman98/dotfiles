-- Basic
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.mouse = nil

-- History
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Columns
vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "80"
vim.opt.wrap = false

vim.opt.number = true
vim.opt.relativenumber = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.list = true
vim.opt.listchars = "tab:  ›,trail:·,eol:⏎"

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
