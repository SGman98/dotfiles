-- One formatter per filetype (conform), linters the LSPs don't cover (nvim-lint).
-- Filetypes not listed fall back to their LSP (taplo, rust-analyzer, tinymist).

-- Mason packages used by conform and nvim-lint
local tools = { "markdownlint", "prettier", "shfmt", "stylua" }

local prettier = { "prettier" }

return {
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        cmd = "ConformInfo",
        dependencies = { { "mason-org/mason.nvim", build = ":MasonUpdate" } },
        keys = {
            { "<leader>ff", function() require("conform").format({ async = true }) end, mode = { "n", "v" }, desc = "Format" },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                fish = { "fish_indent" },
                python = { "ruff_format" },
                javascript = prettier,
                javascriptreact = prettier,
                typescript = prettier,
                typescriptreact = prettier,
                json = prettier,
                jsonc = prettier,
                yaml = prettier,
                css = prettier,
                html = prettier,
                markdown = prettier,
            },
            default_format_opts = { lsp_format = "fallback" },
        },
        config = function(_, opts)
            require("conform").setup(opts)

            local registry = require("mason-registry")
            registry.refresh(function()
                for _, name in ipairs(tools) do
                    local ok, pkg = pcall(registry.get_package, name)
                    if ok and not pkg:is_installed() then pkg:install() end
                end
            end)
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufNewFile", "BufWritePost" },
        config = function()
            local lint = require("lint")
            -- shellcheck runs inside bashls, ruff and eslint are LSPs
            lint.linters_by_ft = {
                markdown = { "markdownlint" },
            }

            vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
                group = vim.api.nvim_create_augroup("lint", { clear = true }),
                callback = function() lint.try_lint() end,
            })
        end,
    },
}
