-- init.lua
-----------------------------------------------------------
-- ##### .vim -> .lua
-- #####  MIGRATION ALIAS neo='nvim -u ~/.config/nvim/lua/init.lua'
-- source a vimscript file
-- vim.cmd('source ~/.config/nvim/lua/from_init.vim')

vim.cmd('source ~/.config/nvim/lua/from_init.vim')

require('settings')      -- settings
require('keymaps')       -- keymaps
require('plugins')       -- plugins
require('statusline')    -- statusline
require('utils')         -- utils.lua
--
