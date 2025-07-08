return {
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "jay-babu/mason-null-ls.nvim" },
            { "williamboman/mason.nvim", build = ":MasonUpdate" },
        },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup()
            require("mason-null-ls").setup({
                ensure_installed = {
                    "black",
                    "markdownlint",
                    "prettier",
                    "shellcheck",
                    "shfmt",
                    "stylua",
                },
                automatic_installation = true,
                handlers = {},
            })
        end,
    },
}
