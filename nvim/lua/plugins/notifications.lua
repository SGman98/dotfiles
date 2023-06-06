return {
    {
        "rcarriga/nvim-notify",
        dependencies = "nvim-telescope/telescope.nvim",
        config = function()
            require("telescope").load_extension("notify")
            require("notify").setup({
                background_colour = "#000000",
                top_down = false,
            })
        end,
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("telescope").load_extension("noice")
            require("noice").setup({
                cmdline = {
                    view = "cmdline",
                },
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                },
            })
        end,
    },
}
