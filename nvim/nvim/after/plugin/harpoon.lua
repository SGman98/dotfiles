local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

local wk = require('which-key')

wk.register({
  h = {
    name = 'Harpoon',
    a = { mark.add_file, 'Harpoon add file' },
    u = { ui.toggle_quick_menu, 'Harpoon quick menu' },
    n = { function () ui.nav_file(1) end, 'Harpoon nav 1' },
    e = { function () ui.nav_file(2) end, 'Harpoon nav 2' },
    i = { function () ui.nav_file(3) end, 'Harpoon nav 3' },
    o = { function () ui.nav_file(4) end, 'Harpoon nav 4' },
  },
}, { prefix = '<leader>' })

