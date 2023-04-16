local function get_lsp_client()
    local clients = vim.lsp.get_active_clients()
    local buf_client_names = {}
    for _, client in ipairs(clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end
    return table.concat(buf_client_names, ", ")
end

local function null_ls_sources(filetype, method)
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

local function get_null_client()
    local clients = vim.lsp.get_active_clients()
    local ft = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "filetype")

    local buf_client_names = {}
    for _, client in ipairs(clients) do
        if client.name == "null-ls" then
            local null_ls_sources_table = {}
            for _, type in ipairs({ "FORMATTING", "DIAGNOSTICS" }) do
                for _, source in ipairs(null_ls_sources(ft, type)) do
                    null_ls_sources_table[source] = true
                end
            end
            vim.list_extend(buf_client_names, vim.tbl_keys(null_ls_sources_table))
        end
    end
    return table.concat(buf_client_names, ", ")
end

local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "tpope/vim-fugitive" },
        opts = {
            options = {
                icons_enabled = false,
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { show_macro_recording, "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { get_lsp_client, get_null_client },
                lualine_z = { "progress", "location" },
            },
            extensions = {
                "fugitive",
                "lazy",
                "man",
            },
        },
    },
}
