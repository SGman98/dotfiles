local M = {}

function M.get_lsp_client()
    local clients = vim.lsp.get_clients()
    local buf_client_names = {}
    for _, client in ipairs(clients) do
        if client.name ~= "null-ls" then table.insert(buf_client_names, client.name) end
    end
    return table.concat(buf_client_names, ", ")
end

function M.null_ls_sources(filetype, method)
    local registered = {}
    local sources_avail, sources = pcall(require, "null-ls.sources")

    if sources_avail then
        for _, source in ipairs(sources.get_available(filetype)) do
            for source_method in pairs(source.methods) do
                registered[source_method] = registered[source_method] or {}
                table.insert(registered[source_method], source.name)
            end
        end
    end

    local methods_avail, methods = pcall(require, "null-ls.methods")
    return methods_avail and registered[methods.internal[method]] or {}
end

function M.get_null_client()
    local clients = vim.lsp.get_clients()
    local ft = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_get_current_buf() })

    local buf_client_names = {}
    for _, client in ipairs(clients) do
        if client.name == "null-ls" then
            local null_ls_sources_table = {}
            for _, type in ipairs({ "FORMATTING", "DIAGNOSTICS" }) do
                for _, source in ipairs(M.null_ls_sources(ft, type)) do
                    null_ls_sources_table[source] = true
                end
            end
            vim.list_extend(buf_client_names, vim.tbl_keys(null_ls_sources_table))
        end
    end
    return table.concat(buf_client_names, ", ")
end

function M.show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end

function M.format()
    -- local allowed_servers = { "null-ls", "rust_analyzer", "lua_ls", "clangd" }
    vim.lsp.buf.format({
        async = false,
        timeout_ms = 10000,
        -- filter = function(client) return vim.tbl_contains(allowed_servers, client.name) end,
    })
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
