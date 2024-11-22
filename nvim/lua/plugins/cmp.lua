local myFunc = require("config.functions")

return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
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
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
                ---@diagnostic disable-next-line: missing-fields
                matching = { disallow_symbol_nonprefix_matching = false },
            })
        end,
    },
}
