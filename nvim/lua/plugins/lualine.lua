local myFunc = require("config.functions")
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" },
        },
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            options = {
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { myFunc.show_macro_recording, "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { myFunc.get_lsp_client, myFunc.get_null_client },
                lualine_z = { "progress", "location" },
            },
        },
    },
}
