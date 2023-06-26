local myFunc = require("config.functions")

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        lazy = true,
        config = function()
            require("lsp-zero.settings").preset({})
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("luasnip").filetype_extend("typescriptreact", { "javascriptreact" })
                end,
            },
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("lsp-zero.cmp").extend()

            local cmp = require("cmp")
            local cmp_action = require("lsp-zero.cmp").action()

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                sources = {
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "buffer", keyword_length = 3 },
                    { name = "luasnip", keyword_length = 2 },
                },
                mapping = {
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                },
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
            {
                "williamboman/mason.nvim",
                build = function()
                    pcall(function()
                        vim.cmd([[MasonUpdate]])
                    end)
                end,
            },
        },
        config = function()
            local lsp = require("lsp-zero")

            lsp.on_attach(function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
                local function map(mode, l, r, desc)
                    local opts = { desc = desc, buffer = bufnr }
                    vim.keymap.set(mode, l, r, opts)
                end
                map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
                map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
                map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
                map("i", "<C-h>", vim.lsp.buf.signature_help)

                -- Diagnostics
                map("n", "<leader>dv", vim.diagnostic.open_float, "View Diagnostics")
                map("n", "[d", vim.diagnostic.goto_prev)
                map("n", "]d", vim.diagnostic.goto_next)

                -- Formatting
                map({ "n", "v" }, "<leader>ff", myFunc.format, "Format")
            end)

            require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

            lsp.setup()
        end,
    },

    -- Formatter using null-ls
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "jose-elias-alvarez/null-ls.nvim",
            {
                "williamboman/mason.nvim",
                build = function()
                    pcall(function()
                        vim.cmd([[MasonUpdate]])
                    end)
                end,
            },
        },
        config = function()
            local null_ls = require("null-ls")

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
