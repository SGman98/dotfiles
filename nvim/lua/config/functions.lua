local M = {}

function M.get_lsp_client()
    local names = vim.tbl_map(function(client) return client.name end, vim.lsp.get_clients({ bufnr = 0 }))
    return table.concat(names, ", ")
end

-- Formatters and linters that run for the current buffer (conform, nvim-lint)
function M.get_format_tools()
    local names = {}
    local conform_ok, conform = pcall(require, "conform")
    if conform_ok then
        local formatters, uses_lsp = conform.list_formatters_to_run(0)
        for _, formatter in ipairs(formatters) do
            table.insert(names, formatter.name)
        end
        if uses_lsp and #formatters == 0 then table.insert(names, "lsp") end
    end
    local lint_ok, lint = pcall(require, "lint")
    if lint_ok then vim.list_extend(names, lint.linters_by_ft[vim.bo.filetype] or {}) end
    return table.concat(names, ", ")
end

function M.show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end

function M.get_code_snippets()
    local plenary = require("plenary.scandir")
    local cwd = vim.fn.getcwd()

    if vim.fn.isdirectory(cwd .. "/.vscode") == 0 then return {} end
    local files = plenary.scan_dir(cwd .. "/.vscode", {
        depth = 2,
        hidden = true,
        search_pattern = ".code[-]snippets$", -- extension ".code-snippets"
    })

    return files
end

return M
