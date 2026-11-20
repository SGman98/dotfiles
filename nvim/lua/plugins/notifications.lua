return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                opts = {
                    background_colour = "#000000",
                    top_down = false,
                },
            },
        },
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
