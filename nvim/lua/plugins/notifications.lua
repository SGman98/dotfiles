return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        -- Notifications are rendered by snacks.notifier (see snacks.lua)
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            cmdline = {
                format = {
                    search_down = { view = "cmdline_popup" },
                    search_up = { view = "cmdline_popup" },
                },
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                command_palette = true,
                long_message_to_split = true,
                lsp_doc_border = true,
            },
        },
    },
}
