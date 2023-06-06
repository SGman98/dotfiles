local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    local function map(mode, l, r, desc)
        local opts = { desc = desc, buffer = bufnr }
        vim.keymap.set(mode, l, r, opts)
    end
    local function format()
        local allowed_servers = { "null-ls", "rust_analyzer", "lua_ls", "clangd" }
        vim.lsp.buf.format({
            async = false,
            timeout_ms = 10000,
            filter = function(client)
                return vim.tbl_contains(allowed_servers, client.name)
            end,
        })
    end

    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
    map("i", "<C-h>", vim.lsp.buf.signature_help)

    -- Diagnostics
    map("n", "<leader>dv", vim.diagnostic.open_float, "View Diagnostics")
    map("n", "[d", vim.diagnostic.goto_prev)
    map("n", "]d", vim.diagnostic.goto_next)

    -- Formatting
    map({ "n", "v" }, "<leader>ff", format, "Format")
end)

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "buffer", keyword_length = 3 },
        { name = "luasnip" },
    },
    mapping = {
        ["<C-f>"] = cmp_action.luasnip_jump_forward(),
        ["<C-b>"] = cmp_action.luasnip_jump_backward(),
    },
})
