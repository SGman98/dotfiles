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
            indent = { enabled = true },
            notifier = {
                enabled = true,
                top_down = false, -- stack from the bottom
            },
            -- Highlight LSP references of the word under the cursor
            words = { enabled = true },
            statuscolumn = { enabled = not vim.g.vscode },
            -- Lighter mode for huge or minified files (>1.5MB or long lines)
            bigfile = { enabled = true },
        },
        keys = {
            { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification history" },
            { "]r", function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference" },
            { "[r", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev reference" },
        },
    },
}
