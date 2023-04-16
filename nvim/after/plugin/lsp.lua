local lsp = require("lsp-zero")

lsp.preset({
    name = "recommended",
    set_lsp_keymaps = false,
    manage_nvim_cmp = true,
    suggest_lsp_servers = true,
})

lsp.format_mapping("gq", {
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ["null-ls"] = { "java" },
    },
})

lsp.on_attach(function(_, bufnr)
    local function map(mode, l, r, desc)
        local opts = { desc = desc, buffer = bufnr }
        vim.keymap.set(mode, l, r, opts)
    end

    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
    map("i", "<C-h>", vim.lsp.buf.signature_help)

    -- Diagnostics
    map("n", "<leader>dv", vim.diagnostic.open_float, "View Diagnostics")
    map("n", "[d", vim.diagnostic.goto_prev)
    map("n", "]d", vim.diagnostic.goto_next)
end)

lsp.nvim_lua_ls()

lsp.setup()

vim.diagnostic.config({ virtual_text = true })
