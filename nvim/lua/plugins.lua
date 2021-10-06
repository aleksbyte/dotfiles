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
-- paq 'npxbr/gruvbox.nvim'
paq 'ellisonleao/gruvbox.nvim'
paq 'hoob3rt/lualine.nvim'
paq 'Yggdroot/indentLine'

-- paq {'nvim-treesitter/nvim-treesitter'}
-- paq {'nvim-treesitter/nvim-treesitter', hook = ':TSUpdate'}
paq { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
paq { 'nvim-treesitter/nvim-treesitter-textobjects', requires = 'nvim-treesitter/nvim-treesitter' }

--  LSP - Intellisense
paq {'neovim/nvim-lspconfig'}
paq {'kabouzeid/nvim-lspinstall'}
paq {'glepnir/lspsaga.nvim'} --  https://github.com/glepnir/lspsaga.nvim
-- paq {'hrsh7th/nvim-compe'}  --
-- paq {'hrsh7th/nvim-comp'}  --  https://github.com/hrsh7th/nvim-cmp

-- paq {'hrsh7th/vim-vsnip'}   -- https://github.com/hrsh7th/vim-vsnip
-- paq {'hrsh7th/vim-vsnip-integ'}   -- https://github.com/hrsh7th/vim-vsnip
-- paq {'rafamadriz/friendly-snippets'} -- https://github.com/rafamadriz/friendly-snippets

-- paq {'mfussenegger/nvim-lint'}  -- https://github.com/mfussenegger/nvim-lint

-- paq {'norcalli/snippets.nvim'}
--   use 'onsails/lspkind-nvim'
--   use 'mfussenegger/nvim-jdtls'
--   use 'mfussenegger/nvim-dap'
--
-- paq {'mfussenegger/nvim-lint'} -- https://github.com/mfussenegger/nvim-lint
-- require('lint').linters_by_ft = {
--  markdown = {'vale',}
-- }
-----------------------------------------------------------------------------
--   -- Linters
-- Linters https://github.com/mfussenegger/nvim-lint
-- Configure the linters you want to run per filetype. For example:
-- require('lint').linters_by_ft = {
--  markdown = {'vale',}
--}
-- Then setup a autocmd to trigger linting. For example:
-- au BufWritePost <buffer> lua require('lint').try_lint()
-----------------------------------------------------------------------------
--   -- Git
--   use 'lewis6991/gitsigns.nvim'
-----------------------------------------------------------------------------
-- paq {'junegunn/fzf', run = fn['fzf#install']}
-- paq {'junegunn/fzf'}
-- paq {'junegunn/fzf.vim'}
-- paq {'ojroques/nvim-lspfuzzy'}

-----------------------------------------------------------------------------
-- https://github.com/RhythmShahriar/minimal-nvim/blob/master/lua/plugins.lua
--
--   -- Telescope
--   use 'nvim-lua/popup.nvim'
--   use 'nvim-lua/plenary.nvim'
--   use 'nvim-telescope/telescope.nvim'
--   use 'nvim-telescope/telescope-media-files.nvim'
--
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
----- Configure Plugins  ----------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
--
-- Color theme
-- https://github.com/gruvbox-community/gruvbox
vim.cmd 'colorscheme gruvbox'
--
-----------------------------------------------------------------------------
-- lualine  -->  statusline.lua-- lualine
--require'lualine'.setup{
--  options = {theme = 'gruvbox'}
--}
--
-----------------------------------------------------------------------------
-- indentLine
vim.g.indentLine_char = '┊'     -- set indentLine character
vim.g.indentLine_leadingSpaceEnabled = 1  --
vim.g.indentLine_leadingSpaceChar = '·' -- set
-- vim.g.indentLine_setColors = 0  -- set indentLine color
--
-----------------------------------------------------------------------------
-- nvim-treesitter  -- syntax highlightings
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
-----------------------------------------------------------------------------
--------------------- LSP ---------------------------------------------------
-----------------------------------------------------------------------------
-- Bash --> npm install -g bash-language-server
--- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#bashls
--  https://github.com/bash-lsp/bash-language-server
-- Python --> npm i -g pyright
--- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#pyright
-- go --> brew install golps
-- Ansible --> yarn global add ansible-language-server
--         --> npm install -g ansible-language-server
-- Terraform --> brew install hashicorp/tap/terraform-ls
-- https://github.com/hashicorp/terraform-ls/tree/v0.9.0
-----------------------------------------------------------------------------
-- plugin: nvim-lspconfig
-- For language server setup see: https://github.com/neovim/nvim-lspconfig

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
-- buf_set_keymap('n', '<leader>law', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- buf_set_keymap('n', '<leader>lrw', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- buf_set_keymap('n', '<leader>llw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<leader>st', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<leader>sr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<leader>sd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '<leader>sl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<leader>sa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap('n', '<leader>FF', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap('n', '<leader>FF', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Code actions
capabilities.textDocument.codeAction = {
	dynamicRegistration = true,
	codeActionLiteralSupport = {
		codeActionKind = {
			valueSet = (function()
				local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
				table.sort(res)
				return res
			end)(),
		},
	},
}

capabilities.textDocument.completion.completionItem.snippetSupport = true

local nvim_lsp = require('lspconfig')
local servers = { 'bashls', 'pyright', 'gopls', 'ansiblels', 'terraformls'}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end
--
-----------------------------------------------------------------------------
-- lspsaga - improve LSP UI
local saga = require 'lspsaga'
-- saga.init_lsp_saga()  --use default config
saga.init_lsp_saga {
-- your custom option here
   error_sign = '●',
   warn_sign = '○',
   hint_sign = '■',
   infor_sign = '.',
   border_style = "round",
}
--
-----------------------------------------------------------------------------
-- Autocomplete configuration file
-- paq {'hrsh7th/nvim-comp'}  --  https://github.com/hrsh7th/nvim-cmp
-----------------------------------------------------------------------------
-- Plugin: nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp

--  local cmp = require 'cmp'
--  local luasnip = require 'luasnip'

--  cmp.setup {
  -- load snippet support
--    snippet = {
--      expand = function(args)
--        luasnip.lsp_expand(args.body)
--      end
--    },

  -- key mapping
--    mapping = {
--      ['<C-p>'] = cmp.mapping.select_prev_item(),
--      ['<C-n>'] = cmp.mapping.select_next_item(),
--      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--      ['<C-f>'] = cmp.mapping.scroll_docs(4),
--      ['<C-Space>'] = cmp.mapping.complete(),
--      ['<C-e>'] = cmp.mapping.close(),
--      ['<CR>'] = cmp.mapping.confirm {
--        behavior = cmp.ConfirmBehavior.Replace,
--        select = true,
--      },
--      ['<Tab>'] = function(fallback)
--        if vim.fn.pumvisible() == 1 then
--          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
--        elseif luasnip.expand_or_jumpable() then
--          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
--        else
--          fallback()
--        end
--      end,
--      ['<S-Tab>'] = function(fallback)
--        if vim.fn.pumvisible() == 1 then
--          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
--        elseif luasnip.jumpable(-1) then
--          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
--        else
--          fallback()
--        end
--      end,
--    },

  -- load sources, see: https://github.com/topics/nvim-cmp
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--     { name = 'path' },
--     {
--       name = 'buffer',
--       opts = {
--         get_bufnrs = function()
--           return vim.api.nvim_list_bufs()
--         end
--       }
--    }
--  },
--}



-----------------------------------------------------------------------------

-- vim.o.completeopt = "menuone,noselect"
--
-- require'compe'.setup {
--     enabled = true,
--     autocomplete = true,
--     debug = false,
--     min_length = 1,
--     preselect = 'enable',
--     throttle_time = 80,
--     source_timeout = 200,
--     incomplete_delay = 400,
--     max_abbr_width = 100,
--     max_kind_width = 100,
--     max_menu_width = 100,
--     documentation = false,
--   source = {
--     buffer = true,
--     calc = true,
--     nvim_lsp = true,
--     nvim_lua = true,
--     spell = true,
--     path = true,
--     treesitter = true,
-- --     vsnip = true,
--     ultisnips = true,
--     snippets_nvim = true
--   };
-- }
--
-- local t = function(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
--
-- local check_back_space = function()
--     local col = vim.fn.col('.') - 1
--       if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--          return true
--       else
--          return false
--       end
-- end
-- -- Use (s-)tab to:
-- --- move to prev/next item in completion menuone
-- --- jump to prev/next snippet's placeholder
-- _G.tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--       return t "<C-n>"
--   elseif vim.fn.call("vsnip#available", {1}) == 1 then
--       return t "<Plug>(vsnip-expand-or-jump)"
--   elseif check_back_space() then
--       return t "<Tab>"
--   else
--       return vim.fn['compe#complete']()
--   end
-- end
-- _G.s_tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--       return t "<C-p>"
--   elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
--       return t "<Plug>(vsnip-jump-prev)"
--   else
--     -- If <S-Tab> is not working in your terminal, change it to <C-h>
--       return t "<S-Tab>"
--   end
-- end
-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--
-- -----------------------------------------------------------------------------
-- https://github.com/projekt0n/github-nvim-theme
--paq {'projekt0n/github-nvim-theme'}
--require('github-theme').setup({
--  themeStyle = "light",
--     commentStyle = "NONE",
--     keywordStyle = "NONE",
--     functionStyle = "NONE",
--     variableStyle = "NONE"
--     -- ... your github-theme config
--})
--require("github-theme").setup({
--  themeStyle = "dimmed",
--  hideInactiveStatusline = true,
--  darkFloat = false,
--  darkSidebar = false
-- })
--
-- https://github.com/eddyekofo94/gruvbox-flat.nvim
-- paq {'eddyekofo94/gruvbox-flat.nvim'}
-- vim.g.gruvbox_flat_style = "dark"
-- vim.g.gruvbox_italic_comments = "false"
-- vim.g.gruvbox_transparent = "true"
-- vim.cmd[[colorscheme gruvbox-flat]]
-----------------------------------------------------
-- paq 'rktjmp/lush.nvim'
-- paq 'npxbr/gruvbox.nvim'
-- paq {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])

-- vim.cmd([[colorscheme desert]])
-- vim.cmd([[colorscheme monokai_pro]])
-- vim.cmd([[colorscheme molokai]])
-----------------------------------------------------
