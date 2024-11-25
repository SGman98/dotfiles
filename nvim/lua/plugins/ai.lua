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
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        build = "make tiktoken", -- Only on MacOS or Linux
        cmd = { "CopilotChat" },
        opts = {},
    },
}
