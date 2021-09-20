-- init.lua
-----------------------------------------------------------
-- ##### .vim -> .lua
-- #####  MIGRATION ALIAS neo='nvim -u ~/.config/nvim/lua/init.lua'
-- source a vimscript file
-- vim.cmd('source ~/.config/nvim/lua/from_init.vim')

vim.cmd('source ~/.config/nvim/lua/from_init.vim')

require('plugins')       -- plugins
require('settings')      -- settings
require('keybindings')   -- keybindings
require('statusline')    -- statusline
require('utils')         -- lua/utils.lua
--
