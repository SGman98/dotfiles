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
                    "markdownlint",
                    "prettier",
                    "shfmt",
                    "black",
                    "ruff",
                    "stylua",
                },
                automatic_installation = true,
                handlers = {},
            })
        end,
    },
}
