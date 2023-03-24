return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        { "rcarriga/nvim-notify", opts = { background_colour = "#000000" } },
    },
    opts = {
        cmdline = {
            view = "cmdline",
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
        },
    },
}
