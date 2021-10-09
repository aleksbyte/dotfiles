--- keymaps.lua
-----------------------------------------------------------
--
-- Map leader default '\'
--
local map = vim.api.nvim_set_keymap
local options = { noremap = true }
local defaults = {noremap = true, silent = true}
--
-- fast saving
map('n', '<leader>w', ':w<cr>',  options) -- Save the current buffer using the leader key
map('n', '<leader>e', ':wq<cr>', options) -- Save and exit Vim using the leader key
map('n', '<leader>q', ':q!<cr>', defaults) -- Exit without saving using the leader key
--
map('n', '<leader><esc>', ':nohlsearch<cr>', options) -- Clear highlite search
map('n', '<leader>c', ':nohl<CR>', {noremap = true, silent = true})
--
-- Windows and Splits
map("n", "<leader>wc", "<C-W>c",  options) -- Close Split
map("n", "<leader>ws", "<C-W>s",  options) -- Horizontal Split
map("n", "<leader>s",  "<C-W>s",  options) -- Horizontal Split (:vsplit)
map("n", "<leader>wv", "<C-W>v",  options) -- Vertical Split
map("n", "<leader>wl", "<C-W>5>", options) -- Expand Split Right
map("n", "<leader>wh", "<C-W>5<", options) -- Expand Split left
map("n", "<leader>wb", "<C-W>=",  options) --  Balance Splits
map("n", "<leader>wj", "<cmd>resize -5<CR>", options) -- Expand Split above
map("n", "<leader>wk", "<cmd>resize +5<CR>", options) -- Expand Split below
--
-- Buffers or Tabs  " Settings for buffers
map('n', '<leader>n', ':bnext<cr>', options) -- Next buffer
map('n', '<leader>p', ':bprev<cr>', options) -- Prev. buffer
map("n", "<leader>bn", "<cmd>enew<CR>", options) -- New tab
map("n", "<leader>bb", "<cmd>ls<CR>",   options) -- list all current buffers
map("n", "<leader>bd", "<cmd>bd!<CR>",  options) -- Close tab
map("n", "<leader>bc", "<cmd>bc<CR>",   options) -- Close tab
-- map("n", "<leader>bn", "<cmd>bn<CR>",  options) -- move to next buffer
-- map("n", "<leader>bp", "<cmd>bp<CR>",  options) -- move to previous buffer
map("n", "<C-Right>", "<cmd>bn<CR>",  options) -- move to next buffer, CTRL-Right
map("n", "<C-Left>",  "<cmd>bp<CR>",  options) -- move to previous buffer, CTRL-Left
-- map("n", "<leader>bp", "<cmd>BufferLinePick<CR>",   options) -- Pick a buffer or tab
map("n", "<TAB>",   "<cmd>BufferLineCycleNext<CR>", options) -- Next Tab
map("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<CR>", options) -- Prev Tab
--
-- Bash like
map("n", "<C-a>", "<Home>", options)
map("n", "<C-e>", "<End>",  options)
--
