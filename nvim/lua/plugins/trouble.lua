return {
    {
        "folke/trouble.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        opts = {
            auto_close = true,
            use_diagnostic_signs = true,
        },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble toggle" },
            { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble workspace diagnostics" },
            { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble document diagnostics" },
            { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble loclist" },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble quickfix" },
            { "<leader>gr", "<cmd>TroubleToggle lsp_references<cr>", desc = "Trouble references" },
        },
    },
}
