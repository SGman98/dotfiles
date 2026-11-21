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

-- Keyed by the Mason packages in config/languages.lua `dap`
---@type table<string, fun(dap: table)>
local adapters = {
    debugpy = function(dap)
        dap.adapters.python = { type = "executable", command = "debugpy-adapter" }

        local function python_path()
            local venv = vim.env.VIRTUAL_ENV
            return venv and venv .. "/bin/python" or vim.fn.exepath("python3")
        end
        dap.configurations.python = {
            { type = "python", request = "launch", name = "Launch file", program = "${file}", pythonPath = python_path },
            {
                type = "python",
                request = "launch",
                name = "Launch file with arguments",
                program = "${file}",
                args = function() return vim.split(vim.fn.input("Arguments: "), " +", { trimempty = true }) end,
                pythonPath = python_path,
            },
        }
    end,

    codelldb = function(dap)
        dap.adapters.codelldb = { type = "executable", command = "codelldb" }
        dap.configurations.c = {
            {
                type = "codelldb",
                request = "launch",
                name = "Launch executable",
                program = function() return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file") end,
                cwd = "${workspaceFolder}",
            },
        }
        dap.configurations.cpp = dap.configurations.c
    end,

    delve = function(dap)
        dap.adapters.delve = {
            type = "server",
            port = "${port}",
            executable = { command = "dlv", args = { "dap", "-l", "127.0.0.1:${port}" } },
        }
        dap.configurations.go = {
            { type = "delve", request = "launch", name = "Debug file", program = "${file}" },
            { type = "delve", request = "launch", name = "Debug package", program = "${fileDirname}" },
            { type = "delve", request = "launch", name = "Debug test", mode = "test", program = "${file}" },
        }
    end,
}

---@param dap table
local function setup_adapters(dap)
    for _, name in ipairs(require("config.tools").list("dap")) do
        if adapters[name] then
            adapters[name](dap)
        else
            vim.notify(("dap: no adapter setup for %q"):format(name), vim.log.levels.WARN)
        end
    end
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui" },
            { "nvim-neotest/nvim-nio" },
            { "mason-org/mason.nvim" },
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            setup_adapters(dap)

            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close
            dapui.setup()
        end,
        keys = {
            { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
            { "<leader>db", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "DAP Conditional Breakpoint" },
            { "<leader>dp", function() require("dap").set_breakpoint(nil, vim.fn.input("Log point message: ")) end, desc = "DAP Log Point" },
            { "<leader>de", function() require("dap").set_exception_breakpoints({ "all" }) end, desc = "DAP Exception Breakpoints" },
            { "<leader>dc", function() require("dap").continue() end, desc = "DAP Continue" },
            { "<leader>di", function() require("dap").step_into() end, desc = "DAP Step Into" },
            { "<leader>do", function() require("dap").step_over() end, desc = "DAP Step Over" },
            { "<leader>du", function() require("dap").step_out() end, desc = "DAP Step Out" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "DAP Run Last" },
            { "<leader>dr", function() require("dap").repl.open() end, desc = "DAP REPL Open" },
            { "<leader>dd", function() require("dap").disconnect() end, desc = "DAP Disconnect" },
        },
    },
}
