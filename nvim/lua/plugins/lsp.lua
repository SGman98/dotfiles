---Per-server settings, merged over lspconfig's defaults
---@return table<string, vim.lsp.Config>
local function server_settings()
    local mason = vim.env.MASON or ""

    -- Keep lspconfig's eslint on_attach (defines LspEslintFixAll) and fix on save
    local eslint_on_attach = vim.lsp.config.eslint.on_attach

    -- jdtls needs Java 25+: run it on the global JDK, not a project's pinned one
    local jdtls_cmd = vim.lsp.config.jdtls.cmd --[[@as fun(dispatchers: vim.lsp.rpc.Dispatchers, config: vim.lsp.ClientConfig): vim.lsp.rpc.PublicClient]]

    -- vue_ls handles templates; TypeScript inside .vue goes through ts_ls + this plugin
    local vue_plugin = mason .. "/packages/vue-language-server/node_modules/@vue/language-server"
    local has_vue = vim.uv.fs_stat(vue_plugin) ~= nil

    return {
        basedpyright = {
            settings = {
                basedpyright = {
                    disableOrganizeImports = true,
                    analysis = { typeCheckingMode = "standard" },
                },
            },
        },
        ruff = {
            on_attach = function(client) client.server_capabilities.hoverProvider = false end, -- basedpyright provides hover
        },
        eslint = {
            on_attach = function(client, bufnr)
                if eslint_on_attach then eslint_on_attach(client, bufnr) end
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "LspEslintFixAll",
                })
            end,
        },
        ts_ls = has_vue and {
            filetypes = vim.list_extend(vim.deepcopy(vim.lsp.config.ts_ls.filetypes or {}), { "vue" }),
            init_options = {
                plugins = { { name = "@vue/typescript-plugin", location = vue_plugin, languages = { "vue" } } },
            },
        } or {},
        jdtls = {
            cmd = function(dispatchers, config)
                local where = vim.system({ "mise", "where", "java" }, { cwd = vim.env.HOME, text = true }):wait()
                local java_home = vim.trim(where.stdout or "")
                if where.code == 0 then
                    config = vim.tbl_deep_extend("force", config, { cmd_env = { JAVA_HOME = java_home } })
                else
                    vim.notify("jdtls: global Java not found, run `mise install`", vim.log.levels.WARN)
                end
                return jdtls_cmd(dispatchers, config)
            end,
        },
        gopls = {
            settings = { gopls = { gofumpt = true } },
        },
        tinymist = {
            settings = { exportPdf = "onType", formatterMode = "typstyle" },
        },
    }
end

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP Actions",
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local function map(mode, l, r, desc)
            local opts = { buffer = event.buf, desc = desc }
            vim.keymap.set(mode, l, r, opts)
        end
        -- Diagnostics
        map("n", "<leader>dv", vim.diagnostic.open_float, "View Diagnostics")
        map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end)
        map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end)
        -- LSP
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
        -- Formatting is <leader>ff from conform (plugins/format.lua)

        -- Reference highlighting under the cursor is done by snacks.words
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Handle Inlay Hints
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("n", "yoy", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end, "Toggle Inlay Hints")
            map("n", "[oy", function() vim.lsp.inlay_hint.enable(true) end, "Show Inlay Hints")
            map("n", "]oy", function() vim.lsp.inlay_hint.enable(false) end, "Hide Inlay")
        end
    end,
})

return {
    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "mason-org/mason.nvim" },
        },

        config = function()
            -- Applies to every server
            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            for name, config in pairs(server_settings()) do
                vim.lsp.config(name, config)
            end
            vim.lsp.enable(require("config.tools").list("lsp"))

            vim.diagnostic.config({
                virtual_lines = { current_line = true },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                },
            })
        end,
    },
}
