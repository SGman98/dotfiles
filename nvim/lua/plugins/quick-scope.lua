return {
    "unblevable/quick-scope",
    init = function()
        vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
        vim.g.rainbow_active = 1
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = { "*" },
            command = "highlight QuickScopePrimary guifg=#00ff00 gui=underline ctermfg=155 cterm=underline",
        })
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = { "*" },
            command = "highlight QuickScopeSecondary guifg=#00ffff gui=underline ctermfg=81 cterm=underline",
        })
    end,
}
