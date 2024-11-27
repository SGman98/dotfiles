return {
    {
        "echasnovski/mini.files",
        version = "*",
        opts = {
            mappings = {
                close = "<Esc>",
                go_in = "<right>",
                go_in_plus = "<CR>",
                go_out = "<left>",
                go_out_plus = "-",
            },
            options = {
                permanent_delete = false,
            },
            windows = {
                preview = true,
            },
        },
        lazy = false,
        keys = {
            { "-", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", desc = "Open files" },
        },
    },
}
