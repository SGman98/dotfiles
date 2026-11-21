local prettier = { "prettier" }

---@class Language
---@field lsp? string[] lspconfig server names
---@field format? table<string, string[]> filetype -> conform formatters; without one the LSP formats
---@field lint? table<string, string[]> filetype -> nvim-lint linters
---@field dap? string[] Mason debug adapter packages
---@field tools? string[] other Mason packages the language needs
---@field detect? vim.filetype.add.filetypes
---@field occasional? boolean install on the first matching file, unless already on PATH
---@field mason? false nothing from Mason; servers start only when on PATH

---@type table<string, Language>
return {
    lua = {
        lsp = { "lua_ls" },
        format = { lua = { "stylua" } },
    },

    shell = {
        lsp = { "bashls", "fish_lsp" },
        format = { sh = { "shfmt" }, bash = { "shfmt" }, fish = { "fish_indent" } },
        tools = { "shellcheck" }, -- bashls runs it for diagnostics
    },

    python = {
        lsp = { "basedpyright", "ruff" },
        format = { python = { "ruff_format" } },
        dap = { "debugpy" },
    },

    web = {
        lsp = { "ts_ls", "eslint", "html", "cssls", "tailwindcss" },
        format = {
            javascript = prettier,
            javascriptreact = prettier,
            typescript = prettier,
            typescriptreact = prettier,
            html = prettier,
            css = prettier,
            scss = prettier,
        },
    },

    rust = {
        -- rustaceanvim starts rust-analyzer itself, not through lspconfig
        tools = { "rust-analyzer" },
        dap = { "codelldb" },
    },

    java = {
        lsp = { "jdtls" },
    },

    docker = {
        lsp = { "dockerls", "docker_compose_language_service" },
        lint = { dockerfile = { "hadolint" } },
        detect = {
            pattern = { ["compose%.ya?ml"] = "yaml.docker-compose", ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose" },
        },
    },

    config = {
        lsp = { "jsonls", "yamlls", "taplo" },
        format = { json = prettier, jsonc = prettier, yaml = prettier, markdown = prettier },
        lint = { markdown = { "markdownlint" }, yaml = { "actionlint" } },
    },

    c = {
        occasional = true,
        lsp = { "clangd" },
        dap = { "codelldb" },
    },

    go = {
        occasional = true,
        lsp = { "gopls" },
        dap = { "delve" },
    },

    sql = {
        occasional = true,
        lsp = { "sqruff" },
    },

    typst = {
        occasional = true,
        lsp = { "tinymist" },
    },

    frameworks = {
        occasional = true,
        lsp = { "vue_ls", "svelte", "astro" },
        format = { vue = prettier, svelte = prettier, astro = prettier },
    },

    uiua = {
        occasional = true,
        mason = false,
        lsp = { "uiua" },
        detect = { extension = { ua = "uiua" } },
    },
}
