-- Install packer

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
-- ensure that packer is installed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

local use = require('packer').use

require('packer').startup(function()
  use 'wbthomason/packer.nvim'         --> packer plugin manager
--> colorschemes
--  use 'rktjmp/lush.nvim'               --> https://github.com/rktjmp/lush.nvim
--
     --> gruvbox for neovim  https://github.com/ellisonleao/gruvbox.nvim
  use 'ellisonleao/gruvbox.nvim'
    vim.cmd 'colorscheme gruvbox'
--
--
--  use 'navarasu/onedark.nvim'
--  Options: dark, darker, cool, deep, warm, warmer, light
-- require('onedark').setup { style = 'light'}
-- require('onedark').load()

--
--
  use 'hoob3rt/lualine.nvim'           --> a statusline written in lua
  use 'Yggdroot/indentLine'            --> indent line
-- Highlight, edit, and navigate code using a fast incremental parsing library
  use {'nvim-treesitter/nvim-treesitter',run = ':TSUpdate',}
-- Additional textobjects for treesitter
--  use 'nvim-treesitter/nvim-treesitter-textobjects'
-- Add git related info in the signs columns and popups
  use {'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }}
  use 'b3nj5m1n/kommentary'
--  LSP
  use 'neovim/nvim-lspconfig'     -- Collection of configurations for built-in LSP client
--
  use 'hrsh7th/nvim-cmp'             --> Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'         --> LSP source for nvim-cmp
  use 'L3MON4D3/LuaSnip'             --> Snippets plugin
  use 'saadparwaiz1/cmp_luasnip'     --> Snippets source for nvim-cmp
  use 'rafamadriz/friendly-snippets' --> Snippets collection for a set of different programming languages
--
  use 'ibhagwan/fzf-lua'             -->
--  use { 'ibhagwan/fzf-lua', opt=false}
--  use { 'ibhagwan/fzf-lua',
--  -- optional for icon support
--    requires = { 'kyazdani42/nvim-web-devicons' }
--  }
--
--  use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }  --#???
  use { 'pianocomposer321/yabs.nvim', requires = { 'nvim-lua/plenary.nvim' }}
--
end)
