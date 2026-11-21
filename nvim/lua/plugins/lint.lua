local only_for = {
    actionlint = function(path) return path:match("/%.github/workflows/") ~= nil end,
}

---@param name string
local function installed(name)
    local linter = require("lint").linters[name]
    if type(linter) == "function" then linter = linter() end
    local cmd = linter and linter.cmd
    if type(cmd) == "function" then cmd = cmd() end
    return type(cmd) == "string" and vim.fn.executable(cmd) == 1
end

return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    dependencies = { "mason-org/mason.nvim" },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = require("config.tools").by_ft("lint")

        vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("lint", { clear = true }),
            callback = function(event)
                local path = vim.api.nvim_buf_get_name(event.buf)
                local names = vim.tbl_filter(
                    function(name) return installed(name) and (not only_for[name] or only_for[name](path)) end,
                    lint._resolve_linter_by_ft(vim.bo[event.buf].filetype)
                )
                lint.try_lint(names)
            end,
        })
    end,
}
