-- Replaces the archived dressing.nvim for vim.ui.input and vim.ui.select
return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            input = { enabled = true },
            -- Only used as the vim.ui.select backend (code actions, etc.)
            picker = { enabled = true, ui_select = true },
        },
    },
}
