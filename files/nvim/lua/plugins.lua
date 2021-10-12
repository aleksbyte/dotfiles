-- plugins.lua
-----------------------------------------------------------------------------
-- paq-nvim
-- $ git clone https://github.com/savq/paq-nvim.git \
-- "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/opt/paq-nvim
vim.cmd 'packadd paq-nvim'           -- load package
local paq = require('paq-nvim').paq  -- import module with `paq` function
paq{'savq/paq-nvim', opt=true}       -- let paq manage itself
--
paq 'rktjmp/lush.nvim'
paq 'ellisonleao/gruvbox.nvim'
vim.cmd 'colorscheme gruvbox'
--
paq 'hoob3rt/lualine.nvim'
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'gruvbox',
--    theme = 'dracula',gruvbox
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding','filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
--
paq 'Yggdroot/indentLine'
vim.g.indentLine_char = '┊'     -- set indentLine character
vim.g.indentLine_leadingSpaceEnabled = 1  --
vim.g.indentLine_leadingSpaceChar = '·' -- set
--
paq {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
paq {'nvim-treesitter/nvim-treesitter-textobjects', requires = 'nvim-treesitter/nvim-treesitter'}
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "bash",
    "dockerfile",
    "hcl",
    "go",
    "java",
    "json",
    "lua",
    "python",
    "yaml",
    "swift",
    "html",
    "scss"
  },
}
--
