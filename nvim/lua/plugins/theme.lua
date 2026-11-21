-- All lazy: config/theme.lua runs `:colorscheme $NVIM_THEME` and lazy.nvim
-- loads the matching plugin on demand, so only the active theme is loaded.
-- `:Telescope colorscheme` still lists the unloaded ones.
return {
    {
        "navarasu/onedark.nvim",
        lazy = true,
        opts = {
            style = "darker",
            transparent = true,
            lualine = {
                transparent = true,
            },
        },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        opts = {
            transparent_background = true,
        },
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
    },
}
