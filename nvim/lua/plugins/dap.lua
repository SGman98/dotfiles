return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui" },
            { "jay-babu/mason-nvim-dap.nvim" },
            { "williamboman/mason.nvim", build = ":MasonUpdate" },
        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "python",
                },
                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    python = function(config)
                        local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
                        config.adapters = {
                            type = "executable",
                            command = mason_path .. "packages/debugpy/venv/bin/python",
                            args = { "-m", "debugpy.adapter" },
                        }
                        require("mason-nvim-dap").default_setup(config)
                    end,
                },
            })

            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
            dapui.setup()
        end,
        keys = {
            { "<leader>dt", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "DAP Toggle Breakpoint" },
            {
                "<leader>db",
                "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
                desc = "DAP Set Conditional Breakpoint",
            },
            {
                "<leader>dp",
                "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
                desc = "DAP Set Log Point",
            },
            { "<leader>dc", "<cmd>lua require('dap').continue()<cr>", desc = "DAP Continue" },
            { "<leader>dd", "<cmd>lua require('dap').disconnect()<cr>", desc = "DAP Disconnect" },
            {
                "<leader>de",
                "<cmd>lua require('dap').set_exception_breakpoints({ 'all' })<cr>",
                desc = "DAP Set Exception Breakpoints",
            },
            { "<leader>di", "<cmd>lua require('dap').step_into()<cr>", desc = "DAP Step Into" },
            { "<leader>do", "<cmd>lua require('dap').step_over()<cr>", desc = "DAP Step Over" },
            { "<leader>du", "<cmd>lua require('dap').step_out()<cr>", desc = "DAP Step Out" },
            { "<leader>dr", "<cmd>lua require('dap').repl.open()<cr>", desc = "DAP REPL Open" },
            { "<leader>dl", "<cmd>lua require('dap').run_last()<cr>", desc = "DAP Run Last" },
        },
    },
}
