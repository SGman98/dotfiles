-- Basic
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
-- vim.opt.mouse = nil
vim.opt.mousemodel = "extend"
vim.opt.exrc = true
vim.opt.termguicolors = true
vim.opt.spelllang = "en,es"

-- History
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Columns
vim.opt.signcolumn = "yes"

vim.opt.textwidth = 80
vim.opt.colorcolumn = "+1"
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
vim.opt.listchars = "tab:  ›,trail:·,eol:⏎,space:⋅"

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
