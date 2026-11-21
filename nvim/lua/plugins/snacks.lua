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
            -- indent-blankline's highlight groups (themes still define them):
            -- dim guides plus an animated guide for the current scope
            indent = {
                enabled = true,
                indent = { hl = "IblIndent" },
                scope = { hl = "IblScope" },
            },
            notifier = {
                enabled = true,
                top_down = false, -- stack from the bottom
            },
        },
        keys = {
            { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification history" },
        },
    },
}
