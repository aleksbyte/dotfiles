-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------
-- Plugin: nvim-lspconfig
-- for language server setup see: https://github.com/neovim/nvim-lspconfig

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { 'bashls', 'pyright', 'gopls', 'yamlls', 'ansiblels', 'terraformls' }
local servers = { 'bashls', 'pyright', 'gopls', 'yamlls', 'terraformls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach,
    flags = { debounce_text_changes = 150,
    }
  }
end

-- test config foe go ls
-- local lspconfig = require'lspconfig'
-- lspconfig.gopls.setup{
--  root_dir = lspconfig.util.root_pattern('.git');
--   root_dir = lspconfig.util.root_pattern('test');
-- }
--
--> npm i -g bash-language-server
--> npm i -g pyright
--> npm i -g gopls
--> yamlls --> npm i -g yaml-language-server
--> ansiblels  --> ???
--> terraformls --> brew install hashicorp/tap/terraform-ls
--[[
Language servers:
Add your language server to `servers`
For language servers list see:
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
- Bash --> bashls  :  npm i -g bash-language-server
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#bashls
- Python --> pyright : npm i -g pyright
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#pyright
- Go --> gopls
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
https://github.com/golang/tools/tree/master/gopls
- Yaml --> yamlls
- Ansible --> ansiblels
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ansiblels
https://github.com/ansible/ansible-language-server
- Terraform --> terraformls
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#terraformls
https://github.com/hashicorp/terraform-ls
--]]


