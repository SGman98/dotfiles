return {
    "johmsalas/text-case.nvim",
    keys = {
        { "ga.", vim.cmd.TextCaseOpenTelescope },
    },
    config = function()
        require("textcase").setup({})
        require("telescope").load_extension("textcase")
    end,
}
