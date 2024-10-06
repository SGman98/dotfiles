local myFunc = require("config.functions")

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP Actions",
    callback = function(event)
        local function map(mode, l, r, desc)
            local opts = { buffer = event.buf, desc = desc }
            vim.keymap.set(mode, l, r, opts)
        end
        -- Diagnostics
        map("n", "<leader>dv", vim.diagnostic.open_float, "View Diagnostics")
        map("n", "[d", vim.diagnostic.goto_prev)
        map("n", "]d", vim.diagnostic.goto_next)
        -- LSP
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
        map("i", "<C-h>", vim.lsp.buf.signature_help)
        -- Formatting
        map({ "n", "v" }, "<leader>ff", myFunc.format, "Format")
    end,
})

return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()

                    require("luasnip").filetype_extend("typescriptreact", { "javascriptreact" })
                end,
            },
            { "petertriho/cmp-git", opts = {} },
            {
                "zbirenbaum/copilot.lua",
                build = ":Copilot auth",
                cmd = "Copilot",
                dependencies = { "zbirenbaum/copilot-cmp", opts = {} },
                opts = {
                    suggestion = { enabled = false },
                    panel = { enabled = false },
                    filetypes = {
                        yaml = true,
                        markdown = true,
                        gitcommit = true,
                        -- ["."] = true,
                    },
                },
            },
        },
        config = function()
            local cmp = require("cmp")
            local ls = require("luasnip")

            cmp.setup({
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "git" },
                }, {
                    { name = "copilot" },
                    { name = "buffer" },
                }),
                snippet = {
                    expand = function(args) require("luasnip").lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-f>"] = function() ls.jump(1) end,
                    ["<C-b>"] = function() ls.jump(-1) end,
                }),
                completion = {
                    completeopt = "menu,menuone,noinsert",
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
            { "williamboman/mason.nvim", build = ":MasonUpdate" },
        },

        config = function()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            local lsp_capabilities = cmp_nvim_lsp.default_capabilities()

            local default_setup = function(server)
                require("lspconfig")[server].setup({
                    capabilities = lsp_capabilities,
                })
            end

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                },
                automatic_installation = true,
                handlers = {
                    default_setup,
                    eslint = function()
                        require("lspconfig").eslint.setup({
                            on_attach = function(_, bufnr)
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                    buffer = bufnr,
                                    command = "EslintFixAll",
                                })
                            end,
                        })
                    end,
                },
            })
            require("lspconfig").uiua.setup({})

            -- Signs
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },
}
