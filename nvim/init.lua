local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true -- set before plugins for colorizer to work

require("lazy").setup({
    spec = { { import = "plugins" } },
    -- defaults = { version = "*" },
    checker = { enabled = true, notify = false },
})

require("custom.clipboard")
require("custom.set")
require("custom.remap")
