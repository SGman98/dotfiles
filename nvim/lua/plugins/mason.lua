local tools = require("config.tools")

---Map tool names (lspconfig or Mason naming) to Mason packages
---@param names string[]
---@return string[]
local function resolve(names)
    local registry = require("mason-registry")
    local by_lspconfig = {}
    for _, spec in ipairs(registry.get_all_package_specs()) do
        local server = vim.tbl_get(spec, "neovim", "lspconfig")
        if server then by_lspconfig[server] = spec.name end
    end

    local packages = {}
    for _, name in ipairs(names) do
        local dashed = name:gsub("_", "-")
        local pkg = (registry.has_package(name) and name) or by_lspconfig[name] or (registry.has_package(dashed) and dashed)
        if pkg then
            packages[pkg] = true
        else
            vim.notify(("mason: no package for %q"):format(name), vim.log.levels.WARN)
        end
    end
    return vim.tbl_keys(packages)
end

---True if another copy of the package's binaries is already on PATH
---@param pkg Package
local function on_path(pkg)
    for bin in pairs(pkg.spec.bin or {}) do
        if vim.fn.executable(bin) == 1 then return true end
    end
    return false
end

-- Re-run lsp.enable's FileType handler so newly installed servers attach
local function refresh_buffers()
    vim.cmd.doautoall("nvim.lsp.enable FileType")
    local ok, lint = pcall(require, "lint")
    if ok then lint.try_lint() end
end

---@param packages string[]
---@param opts? { skip_on_path?: boolean }
local function install(packages, opts)
    local registry = require("mason-registry")
    for _, name in ipairs(packages) do
        local pkg = registry.get_package(name)
        local skip = pkg:is_installed() or pkg:is_installing() or (opts and opts.skip_on_path and on_path(pkg))
        if not skip then
            vim.notify(("mason: installing %s"):format(name))
            pkg:install({}, function(success, err)
                vim.schedule(function()
                    if success then
                        vim.notify(("mason: installed %s"):format(name))
                        refresh_buffers()
                    else
                        vim.notify(("mason: failed to install %s\n%s"):format(name, err), vim.log.levels.ERROR)
                    end
                end)
            end)
        end
    end
end

---@param declared table<string, true>
local function clean(declared)
    local registry = require("mason-registry")
    local extra = vim.tbl_filter(function(name) return not declared[name] end, registry.get_installed_package_names())
    if #extra == 0 then return vim.notify("mason: nothing to clean") end

    table.sort(extra)
    vim.ui.select({ "Yes", "No" }, { prompt = "Uninstall " .. table.concat(extra, ", ") .. "?" }, function(choice)
        if choice ~= "Yes" then return end
        for _, name in ipairs(extra) do
            registry.get_package(name):uninstall()
        end
    end)
end

local function setup()
    local declared = {}
    local occasional = {} ---@type table<string, Language>

    for id, lang in pairs(tools.languages) do
        if lang.mason ~= false then
            local packages = resolve(tools.names(lang))
            for _, name in ipairs(packages) do
                declared[name] = true
            end
            if lang.occasional then
                occasional[id] = lang
            else
                install(packages)
            end
        end
    end

    ---Install an occasional language's tools when one of its filetypes shows up
    ---@param ft string
    local function on_filetype(ft)
        for id, lang in pairs(occasional) do
            if tools.filetypes(lang)[ft] then
                occasional[id] = nil
                install(resolve(tools.names(lang)), { skip_on_path = true })
            end
        end
    end

    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("mason-occasional", { clear = true }),
        callback = function(event) on_filetype(event.match) end,
    })
    -- Buffers opened before the registry was ready
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then on_filetype(vim.bo[buf].filetype) end
    end

    vim.api.nvim_create_user_command("MasonClean", function() clean(declared) end, { desc = "Uninstall Mason packages no language declares" })
end

return {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonClean" },
    event = "VeryLazy",
    opts = {
        -- Tools already on PATH (e.g. pinned by a project's mise.toml) take precedence
        PATH = "append",
    },
    config = function(_, opts)
        require("mason").setup(opts)
        require("mason-registry").refresh(vim.schedule_wrap(setup))
    end,
}
