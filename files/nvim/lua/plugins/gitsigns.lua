--
-- local gitsigns = Vapour.utils.plugins.require('gitsigns')
-- gitsigns.setup {
--
require('gitsigns').setup {
  signs = {
    add = {hl = 'GitSignsAdd', text = '▌', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn'},
    change = {hl = 'GitSignsChange', text = '▌', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
    delete = {hl = 'GitSignsDelete', text = '▶', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
    topdelete = {hl = 'GitSignsDelete', text = '▶', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '◢', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'}
  },
  numhl = false,
  linehl = false,
  watch_gitdir = {interval = 1000},
  sign_priority = 6,
  update_debounce = 200,
  status_formatter = nil,
--  keymaps = {noremap = true, buffer = true},
  keymaps = {
    noremap = true,
    buffer = true,
    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',

    ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
  }
}
