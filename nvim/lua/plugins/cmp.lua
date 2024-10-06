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
}
