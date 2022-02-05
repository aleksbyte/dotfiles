-- init.lua
--
-- vim.cmd('source ~/.config/nvim/lua/vim-utils.vim') -- .vim scripts
--
require('settings')      -- settings
require('keymaps')       -- keymaps
--
-- Plugins package manager:
require('plugins/plugins')
-- Plugins configs:
require('plugins/indentline')
require('plugins/lualine')
require('plugins/treesitter')
require('plugins/gitsigns')
require('plugins/kommentary')
require('plugins/lsp-config')
require('plugins/nvim-cmp')
require('plugins/fzf')
-- require('plugins/code_runner')
require('plugins/yabs')
--
-- require('plugins/vista')
-- ???
-- require('plugins/lsp-installer')
-- require('plugins/lsp-saga')
-- require('plugins/nvim-tree')
--
-- https://github.com/brainfucksec/neovim-lua/tree/main/nvim/lua/plugins

