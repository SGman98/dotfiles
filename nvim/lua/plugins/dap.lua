-- Dap signs
local signs = {
    Breakpoint = "",
    BreakpointCondition = "",
    BreakpointRejected = "",
    LogPoint = "",
    Stopped = "",
}
for type, icon in pairs(signs) do
    local hl = "Dap" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui" },
            { "nvim-neotest/nvim-nio" },
            { "jay-babu/mason-nvim-dap.nvim" },
            { "williamboman/mason.nvim", build = ":MasonUpdate" },
        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "python",
                },
                automatic_installation = true,
                handlers = {
                    function(config) require("mason-nvim-dap").default_setup(config) end,
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
            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close
            dapui.setup()
        end,
        keys = function(_, keys)
            local dap = require("dap")

            return {
                { "<leader>dt", function() dap.toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
                { "<leader>db", function() dap.set_breakpoint(vim.fn.input("Condition: ")) end, desc = "DAP Conditional Breakpoint" },
                { "<leader>dp", function() dap.set_breakpoint(nil, vim.fn.input("Log point message: ")) end, desc = "DAP Log Point" },
                { "<leader>de", function() dap.set_exception_breakpoints({ "all" }) end, desc = "DAP Exception Breakpoints" },
                { "<leader>dc", function() dap.continue() end, desc = "DAP Continue" },
                { "<leader>di", function() dap.step_into() end, desc = "DAP Step Into" },
                { "<leader>do", function() dap.step_over() end, desc = "DAP Step Over" },
                { "<leader>du", function() dap.step_out() end, desc = "DAP Step Out" },
                { "<leader>dl", function() dap.run_last() end, desc = "DAP Run Last" },
                { "<leader>dr", function() dap.repl.open() end, desc = "DAP REPL Open" },
                { "<leader>dd", function() dap.disconnect() end, desc = "DAP Disconnect" },
                unpack(keys),
            }
        end,
    },
}
