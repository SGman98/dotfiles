return {
    {
        "zbirenbaum/copilot.lua",
        build = ":Copilot auth",
        cmd = "Copilot",
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
}
