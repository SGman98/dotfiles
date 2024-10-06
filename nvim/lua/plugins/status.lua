local myFunc = require("config.functions")
return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { myFunc.show_macro_recording, "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { myFunc.get_lsp_client, myFunc.get_null_client },
                lualine_z = { "progress", "location" },
            },
        },
    },
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                relculright = true,
                segments = {
                    { text = { builtin.foldfunc }, auto = true, click = "v:lua.ScFa" },
                    { text = { " " }, hl = "FoldColumn" }, -- Empty column
                    { sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true }, click = "v:lua.ScSa" },
                    { sign = { name = { "Dap*" }, maxwidth = 1, auto = true }, click = "v:lua.ScSa" },
                    { sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true }, click = "v:lua.ScSa" },
                    { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
                    { sign = { namespace = { "gitsign*" }, maxwidth = 1, colwidth = 1 }, click = "v:lua.ScSa" },
                },
            })
        end,
        cond = not vim.g.vscode,
    },
}
