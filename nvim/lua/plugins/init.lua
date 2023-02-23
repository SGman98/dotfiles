return {
    "tpope/vim-sleuth",
    "christoomey/vim-tmux-navigator",
    "tpope/vim-obsession",
    "tpope/vim-abolish",
    { "kylechui/nvim-surround", config = true },
    { "numToStr/Comment.nvim", config = true },
    { "nvim-lualine/lualine.nvim", config = true },

    { "stevearc/dressing.nvim", event = "VeryLazy" },
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
}
