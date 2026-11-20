local ensure_installed = { "bash", "lua", "markdown", "markdown_inline", "query", "regex", "vim", "vimdoc" }
local ignored = { csv = true }

---Enable treesitter features for a buffer
---@param buf integer
---@param lang string
local function attach(buf, lang)
    if not vim.api.nvim_buf_is_valid(buf) then return end
    if not pcall(vim.treesitter.start, buf, lang) then return end

    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    -- Incremental selection using the builtin `an` / `in` (nvim 0.12+)
    vim.keymap.set("n", "<CR>", "van", { buffer = buf, remap = true, desc = "Start node selection" })
    vim.keymap.set("x", "<CR>", "an", { buffer = buf, remap = true, desc = "Grow node selection" })
    vim.keymap.set("x", "<BS>", "in", { buffer = buf, remap = true, desc = "Shrink node selection" })
end

return {
    {
        "echasnovski/mini.operators",
        version = "*",
        opts = {
            exchange = { prefix = "ge" },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false, -- does not support lazy-loading
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
            {
                "echasnovski/mini.ai",
                version = "*",
                opts = function()
                    local spec_treesitter = require("mini.ai").gen_spec.treesitter

                    return {
                        search_method = "cover_or_next",
                        mappings = {
                            goto_left = "gl",
                            goto_right = "gn",
                            -- Leave `an` / `in` to builtin treesitter node selection
                            around_next = "",
                            inside_next = "",
                        },
                        custom_textobjects = {
                            F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
                            c = spec_treesitter({ a = "@comment.outer", i = "@comment.outer" }), -- inner comment not working
                            s = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
                            l = spec_treesitter({ a = "@loop.outer", i = "@loop.inner" }),
                        },
                    }
                end,
            },
        },
        config = function()
            local ts = require("nvim-treesitter")
            ts.install(ensure_installed)

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("treesitter-attach", { clear = true }),
                callback = function(event)
                    local lang = vim.treesitter.language.get_lang(event.match)
                    if not lang or ignored[lang] then return end

                    if vim.list_contains(ts.get_installed(), lang) then
                        attach(event.buf, lang)
                    elseif vim.list_contains(ts.get_available(), lang) then
                        -- Auto install missing parsers
                        ts.install(lang):await(function() attach(event.buf, lang) end)
                    end
                end,
            })
        end,
    },
}
