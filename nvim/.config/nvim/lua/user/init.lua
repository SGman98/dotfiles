-- '$HOME/.config/nvim/lua/core/mappings.lua'
-- '$HOME/.config/nvim/lua/user_example/init.lua'
local config = {

    -- Set colorscheme
    colorscheme = "onenord",

    -- null-ls configuration
    ["null-ls"] = function()
        local status_ok, null_ls = pcall(require, "null-ls")
        if not status_ok then
              return
        end

        local formatting = null_ls.builtins.formatting

        null_ls.setup {
            debug = false,
            sources = {
                -- Set a formatter
                formatting.prettier,
                -- formatting.autopep8,
            },

            -- NOTE: You can remove this on attach function to disable format on save
            on_attach = function(client)
                if client.resolved_capabilities.document_formatting then
                    vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
                end
            end,

        }
    end,

    -- Configure plugins
    plugins = {
        -- Add plugins, the packer syntax without the "use"
        init = {
            { "unblevable/quick-scope" },
            { "tpope/vim-surround" },
            { "github/copilot.vim" },
            { "morhetz/gruvbox" },
            { "rmehri01/onenord.nvim"},
        },

        lualine = {
            sections = {
               lualine_a = {'mode'}
            }
        }

    },


    polish = function()
        local opts = { noremap = true, silent = true }
        local map = vim.api.nvim_set_keymap
        local set = vim.opt
        -- Set options
        set.shiftwidth =  4
        set.tabstop = 4
        set.softtabstop = 4
        set.expandtab = true
        set.clipboard = "unnamedplus"
        set.timeoutlen = 500

        map("n", "<leader>f.", "<cmd>Telescope find_files hidden=true<CR>", opts)

        vim.cmd [[
            autocmd VimEnter * :Copilot disable
            imap <silent><script><expr> <C-O> copilot#Accept("\<CR>")
            let g:copilot_no_tab_map = v:true
            let g:qs_highlight_on_keys = ['f', 'F', 't', 'T'] 
            highlight QuickScopePrimary guifg='#00ff00' gui=underline ctermfg=155 cterm=underline
            highlight QuickScopeSecondary guifg='#00ffff' gui=underline ctermfg=81 cterm=underline
        ]]

    end,
}
return config
