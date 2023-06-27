return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "jay-babu/mason-null-ls.nvim" },
            { "williamboman/mason.nvim", build = ":MasonUpdate" },
        },
        config = function()
            local null_ls = require("null-ls")

            require("null-ls").setup()
            require("mason-null-ls").setup({
                ensure_installed = {
                    "markdownlint",
                    "prettier",
                    "shfmt",
                    "black",
                    "flake8",
                    "stylua",
                },
                automatic_installation = true,
                handlers = {
                    flake8 = function(_, _)
                        null_ls.register(null_ls.builtins.diagnostics.flake8.with({
                            extra_args = { "--max-line-length=88", "--extend-ignore=E203" },
                        }))
                    end,
                },
            })
        end,
    },
}
