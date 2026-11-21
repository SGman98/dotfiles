local M = {}

M.languages = require("config.languages")

---Union of a list field across languages, e.g. M.list("lsp")
---@param field "lsp"|"dap"|"tools"
---@return string[]
function M.list(field)
    local seen, out = {}, {}
    for _, lang in pairs(M.languages) do
        local items = lang[field] --[[@as string[]?]]
        for _, name in ipairs(items or {}) do
            if not seen[name] then
                seen[name] = true
                table.insert(out, name)
            end
        end
    end
    table.sort(out)
    return out
end

---Merged filetype map of a field, e.g. M.by_ft("format")
---@param field "format"|"lint"
---@return table<string, string[]>
function M.by_ft(field)
    local out = {}
    for _, lang in pairs(M.languages) do
        local items = lang[field] --[[@as table<string, string[]>?]]
        for ft, names in pairs(items or {}) do
            out[ft] = vim.list_extend(out[ft] or {}, names)
        end
    end
    return out
end

-- conform/nvim-lint names that aren't Mason package names (false: not from Mason)
local aliases = { ruff_format = "ruff", fish_indent = false }

---Every tool name a language uses, in the naming of the plugin that runs it
---@param lang Language
---@return string[]
function M.names(lang)
    local names = vim.list_extend(vim.list_extend({}, lang.lsp or {}), lang.dap or {})
    vim.list_extend(names, lang.tools or {})
    for _, field in ipairs({ "format", "lint" }) do
        local items = lang[field] --[[@as table<string, string[]>?]]
        for _, tools in pairs(items or {}) do
            for _, name in ipairs(tools) do
                if aliases[name] ~= false then table.insert(names, aliases[name] or name) end
            end
        end
    end
    return names
end

---Filetypes a language covers (needs lspconfig on the runtimepath)
---@param lang Language
---@return table<string, true>
function M.filetypes(lang)
    local fts = {}
    for _, field in ipairs({ "format", "lint" }) do
        local items = lang[field] --[[@as table<string, string[]>?]]
        for ft in pairs(items or {}) do
            fts[ft] = true
        end
    end
    for _, server in ipairs(lang.lsp or {}) do
        for _, ft in ipairs(vim.lsp.config[server] and vim.lsp.config[server].filetypes or {}) do
            fts[ft] = true
        end
    end
    for _, kind in pairs(lang.detect or {}) do
        for _, ft in pairs(kind) do
            fts[ft] = true
        end
    end
    return fts
end

---Register every language's filetype rules. Compound filetypes ("yaml.docker-compose")
---reuse the treesitter parser of their first part.
function M.detect()
    for _, lang in pairs(M.languages) do
        if lang.detect then
            vim.filetype.add(lang.detect)
            for _, kind in pairs(lang.detect) do
                for _, ft in pairs(kind) do
                    local base = ft:match("^(%w+)%.")
                    if base then vim.treesitter.language.register(base, ft) end
                end
            end
        end
    end
end

return M
