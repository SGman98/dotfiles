return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                config = function() require("luasnip").filetype_extend("typescriptreact", { "javascriptreact" }) end,
                dependencies = {
                    { "rafamadriz/friendly-snippets", config = function() require("luasnip.loaders.from_vscode").lazy_load() end },
                },
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
                    expand = function(args) ls.lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-l>"] = cmp.mapping(function()
                        if ls.expand_or_locally_jumpable() then ls.expand_or_jump() end
                    end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if ls.locally_jumpable(-1) then ls.jump(-1) end
                    end, { "i", "s" }),
                }),
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
            })
        end,
    },
}
