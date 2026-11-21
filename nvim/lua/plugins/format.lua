return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = "ConformInfo",
    dependencies = { "mason-org/mason.nvim" },
    keys = {
        { "<leader>ff", function() require("conform").format({ async = true }) end, mode = { "n", "v" }, desc = "Format" },
    },
    opts = function()
        return {
            formatters_by_ft = require("config.tools").by_ft("format"),
            default_format_opts = { lsp_format = "fallback" },
        }
    end,
}
