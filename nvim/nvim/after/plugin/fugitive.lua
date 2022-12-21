local wk = require('which-key')
local telescope = require('telescope.builtin')

wk.register({
  g = {
    name = 'Git',
    b = { telescope.branches, 'Git branches' },
    c = { telescope.commits, 'Git commits' },
    f = { telescope.git_files, 'Git files' },
    t = { telescope.stash, 'Git stash' },
    g = { vim.cmd.LazyGit, 'Git lazy' },
    s = { vim.cmd.Git, 'Git fugitive' },
  },
}, { prefix = '<leader>' })
