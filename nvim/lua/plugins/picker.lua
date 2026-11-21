-- Snacks picker keymaps (replaced Telescope; same keys as before).
-- `?` in a picker's normal mode lists its keys, <leader>sp lists all pickers.
local function pick(source, opts)
    return function() Snacks.picker[source](opts) end
end

return {
    {
        "folke/snacks.nvim",
        keys = {
            -- FILE PICKERS
            {
                "<leader>sf",
                pick("files", {
                    hidden = true,
                    ignored = true,
                    follow = true,
                    exclude = { ".git", "node_modules", ".next", "amplify" },
                }),
                desc = "Search Files",
            },
            { "<leader>sgf", pick("git_files", { untracked = true }), desc = "Search Git Files" },
            { "<leader>sc", pick("grep_word"), mode = { "n", "x" }, desc = "Search current word" },
            -- Extra rg args after ` -- `, e.g. `foo -- -g *.lua`
            { "<leader>sw", pick("grep"), desc = "Search by grep" },
            -- VIM PICKERS
            { "<leader>sb", pick("buffers"), desc = "Search buffers" },
            { "<leader>so", pick("recent"), desc = "Search oldfiles" },
            { "<leader>st", pick("tags"), desc = "Search tags" },
            { "<leader>sh", pick("help"), desc = "Search help" },
            { "<leader>sk", pick("keymaps"), desc = "Search keymaps" },
            { "<leader>sp", pick("pickers"), desc = "Search pickers" },
            { "<leader>sl", pick("loclist"), desc = "Search loclist" },
            { "z=", pick("spelling"), desc = "Spell suggest" },
            -- LSP PICKERS
            { "<leader>ld", pick("lsp_definitions"), desc = "Go to definition" },
            { "<leader>lr", pick("lsp_references"), desc = "Search references" },
            { "<leader>lsd", pick("lsp_symbols"), desc = "Search document symbols" },
            { "<leader>lsw", pick("lsp_workspace_symbols"), desc = "Search workspace symbols" },
            { "<leader>sd", pick("diagnostics"), desc = "Search diagnostics" },
            -- GIT PICKERS
            { "<leader>gc", pick("git_log"), desc = "Git commits" },
            { "<leader>gb", pick("git_branches"), desc = "Git branches" },
            { "<leader>gs", pick("git_status"), desc = "Git status" },
            { "<leader>gt", pick("git_stash"), desc = "Git stash" },
        },
    },
}
