return {
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                relculright = true,
                segments = {
                    { text = { builtin.foldfunc }, maxwidth = 1, click = "v:lua.ScFa" },
                    {
                        sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true },
                        click = "v:lua.ScSa",
                    },
                    {
                        sign = { name = { "Dap*" }, maxwidth = 1, auto = true },
                        click = "v:lua.ScSa",
                    },
                    {
                        sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true },
                        click = "v:lua.ScSa",
                    },
                    { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
                    {
                        sign = { namespace = { "gitsign*" }, maxwidth = 1, colwidth = 1 },
                        click = "v:lua.ScSa",
                    },
                },
            })
        end,
        cond = not vim.g.vscode,
    },
}
