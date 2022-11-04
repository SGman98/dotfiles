-- ***Sets***
  local set = vim.opt

  set.swapfile    = false
  set.backup      = false
  set.colorcolumn = '80'
  set.listchars   = 'tab:  ›,trail:·'
  set.list        = true
  set.mousemodel  = extend
  set.rnu         = true

-- ***General***
  lvim.log.level      = "warn"
  lvim.format_on_save = true

-- ***Leader Key***
  lvim.leader = "space"

-- ***Plugins***
  lvim.plugins = {
    -- Colorscheme
    { "navarasu/onedark.nvim" },

    -- Utilities
    { "folke/todo-comments.nvim" },
    { "folke/trouble.nvim" },
    { "tpope/vim-fugitive" },
    { "tpope/vim-surround" },
    { "unblevable/quick-scope" },

    -- language specific
    { "akinsho/flutter-tools.nvim" },
    { "simrat39/rust-tools.nvim" },

    -- Others
    { "rest-nvim/rest.nvim" },
  }

-- ***Plugin Configurations***

  -- Colorscheme
    lvim.colorscheme = "onedark"

  -- Utilities

    -- Todo Comments
    require "todo-comments".setup {}

    -- Trouble
    lvim.builtin.which_key.mappings["x"] = {
      name = "+Trouble",
      t = { "<cmd>TroubleToggle<cr>", "Trouble" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
      l = { "<cmd>TroubleToggle loclist<cr>", "Location List" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix List" },
      r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
    }

    -- Quick Scope
    vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    vim.g.rainbow_active = 1
    vim.api.nvim_create_autocmd("ColorScheme", { pattern = { "*" }, command = "highlight QuickScopePrimary guifg=#00ff00 gui=underline ctermfg=155 cterm=underline" })
    vim.api.nvim_create_autocmd("ColorScheme", { pattern = { "*" }, command = "highlight QuickScopeSecondary guifg=#00ffff gui=underline ctermfg=81 cterm=underline" })

  -- Language Specific

    -- Flutter Tools
    require "flutter-tools".setup {
      lsp = {
        color = {
          enabled = true,
        }
      },
      widget_guides = {
        enabled = true
      },
    }

    -- Rust Tools
    require "rust-tools".setup {}
    require "rust-tools".runnables.runnables()
    require "rust-tools".inlay_hints.enable()
    require "rust-tools".open_cargo_toml.open_cargo_toml()

  -- Others

-- ***My Keymappings***

  -- Paste without losing pasted text
  lvim.keys.normal_mode["<leader>p"] = '"_dP'

  -- New visual mode key
  lvim.keys.normal_mode["x"] = "V"
  lvim.keys.visual_mode["x"] = "V"

  -- My which-key mappings
  lvim.keys.normal_mode["<leader>f"] = nil 
  lvim.builtin.which_key.mappings["f"] = {
    name = "+File",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    s = { "<cmd>w<cr>", "Save" },
    R = { "<cmd>lua require('lv-utils').rename_current_buffer_file()<cr>", "Rename File" },
    n = { "<cmd>enew<cr>", "New File" },
    m = { "<cmd>lua require('lv-utils').move_current_buffer_file()<cr>", "Move File" },
    t = { "<cmd>TodoTelescope<cr>", "Todos" },
    T = { "<cmd>TodoTrouble<cr>", "Trouble Todos" },
  }

  lvim.builtin.which_key.mappings["t"] = {
    name = "+Toggle",
    r = { "<cmd>set rnu!<cr>", "Relative Number" },
    n = { "<cmd>set number!<cr>", "Number" },
    l = { "<cmd>set list!<cr>", "List" },
    c = { "<cmd>set colorcolumn!<cr>", "Color Column" },
    w = { "<cmd>set wrap!<cr>", "Wrap" },
    s = { "<cmd>set spell!<cr>", "Spell" },
    f = { "<cmd>lua require('lv-utils').toggle_fullscreen()<cr>", "Fullscreen" },
    z = { "<cmd>lua require('lv-utils').toggle_zoom()<cr>", "Zoom" },
    t = { "<cmd>ToggleTerm<cr>", "Terminal" },
  }
