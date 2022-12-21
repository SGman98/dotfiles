require('telescope').setup {}
pcall(require('telescope').load_extension, 'fzf')

local wk = require('which-key')
local telescope = require('telescope.builtin')

wk.register({
  s = {
    name = 'Search',
    f = { telescope.find_files, 'Search files' },
    h = { telescope.help_tags, 'Search help' },
    w = { telescope.grep_string, 'Search current word' },
    g = { telescope.live_grep, 'Search by grep' },
    d = { telescope.diagnostics, 'Search diagnostics' },
    b = { telescope.buffers, 'Search buffers' },
    o = { telescope.oldfiles, 'Search oldfiles' },
    k = { telescope.keymaps, 'Search keymaps' },
    ['/'] = { telescope.current_buffer_fuzzy_find, 'Search in current buffer' },
  },
}, { prefix = '<leader>' })
