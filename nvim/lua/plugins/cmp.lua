local myFunc = require("config.functions")

return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
                config = function()
                    local ls = require("luasnip")
                    ls.filetype_extend("typescriptreact", { "javascriptreact" })
                    ls.config.set_config({
                        history = true,
                        updateevents = "TextChanged,TextChangedI",
                    })
                end,
                dependencies = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                            local files = myFunc.get_code_snippets()
                            if #files <= 0 then return end
                            for _, file in ipairs(files) do
                                require("luasnip.loaders.from_vscode").load_standalone({ lazy = true, path = file })
                            end
                        end,
                    },
                },
            },
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            { "petertriho/cmp-git", opts = {} },
        },
        config = function()
            local cmp = require("cmp")
            local ls = require("luasnip")
            local lspkind = require("lspkind")

            cmp.setup({
                ---@diagnostic disable-next-line: missing-fields
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                    }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "git" },
                }, {
                    { name = "codeium" },
                    { name = "buffer" },
                }),
                snippet = {
                    expand = function(args) ls.lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-l>"] = cmp.mapping(function()
                        if ls.expand_or_locally_jumpable() then ls.expand_or_jump() end
                    end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if ls.locally_jumpable(-1) then ls.jump(-1) end
                    end, { "i", "s" }),
                    ["<C-j>"] = cmp.mapping(function()
                        if ls.choice_active() then ls.change_choice(1) end
                    end, { "i", "s" }),
                }),
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
            })
        end,
    },
}
