--- init.lua
-----------------------------------------------------------
-- Neovim settings
-----------------------------------------------------------
-- Neovim API aliases
local cmd = vim.cmd     -- execute Vim commands
local exec = vim.api.nvim_exec       -- execute Vimscript
--local map = vim.api.nvim_set_keymap  -- set global keymap
local fn = vim.fn       -- call Vim functions
local g = vim.g         -- global variables
local o = vim.o         -- global options
local b = vim.bo        -- buffer-scoped options
local w = vim.wo        -- windows-scoped options

-----------------------------------------------------------
-- General
-----------------------------------------------------------
-- g.mapleader = ','           -- change leader to a comma
o.mouse = 'a'               -- enable mouse support
o.clipboard = 'unnamedplus' -- copy/paste to system clipboard
b.swapfile = false          -- don't use swapfile

-- Neovim UI
o.syntax = 'enable'         -- enable syntax highlighting
w.number = true             -- show line number
o.showmatch = true          -- highlight matching parenthesis
w.foldmethod = 'marker'     -- enable folding (default 'foldmarker')
w.colorcolumn = '80'        -- line lenght marker at 80 columns
o.splitright = true         -- vertical split to the right
o.splitbelow = true         -- orizontal split to the bottom
o.ignorecase = true         -- ignore case letters when search
o.smartcase = true          -- ignore lowercase for the whole pattern

o.relativenumber = true           -- Relative line numbers
w.cursorline = true

-- remove whitespace on save
cmd([[au BufWritePre * :%s/\s\+$//e]])

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
o.hidden = true         -- enable background buffers
o.history = 100         -- remember n lines in history
o.lazyredraw = true     -- faster scrolling
b.synmaxcol = 240       -- max column for syntax highlight

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
b.expandtab = true      -- use spaces instead of tabs
b.shiftwidth = 4        -- shift 4 spaces when tab
b.tabstop = 4           -- 1 tab == 4 spaces
b.smartindent = true    -- autoindent new lines

-- don't auto commenting new lines
cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])
-- remove line lenght marker for selected filetypes
cmd([[
  autocmd FileType text,markdown,xml,html,xhtml,javascript setlocal cc=0
]])
-- 2 spaces for selected filetypes
cmd([[
  autocmd FileType xml,html,yaml,j2,css,scss,javascript,lua setlocal shiftwidth=2 tabstop=2
]])
-- 8 spaces for Go files
cmd([[autocmd FileType go setlocal shiftwidth=8 tabstop=8]])

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
o.completeopt = 'menuone,noselect,noinsert' -- completion options
o.shortmess = 'c'       -- don't show completion messages
-----------------------------------------------------------

o.wildignore = [[
.git/*,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*,*.pyc,*.bak,*~
*.gem
*.o,*.lo,*.ko,*.so
*_build/*,*build/*
*.egg,*.egg-info
*.ps,*.bbl,*.docx,*.ppt,*.pptx,*.rtf
]]

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
-- o.termguicolors = true          -- enable 24-bit RGB colors
-- vim.cmd 'colorscheme gruvbox'  -- https://github.com/gruvbox-community/gruvbox
--
-- cmd([[colorscheme molokai]])    -- set colorscheme
-- vim.cmd 'colorscheme molokai'    -- set colorscheme
-- cmd([[colorscheme spacegray]])    -- set colorscheme
-- vim.cmd 'colorscheme spacegray'    -- set colorscheme
-- cmd([[colorscheme wal]])    -- set colorscheme
-- cmd([[colorscheme monokai_pro]])    -- set colorscheme
-- vim.cmd 'colorscheme everforest.vim'  -- https://github.com/gruvbox-community/gruvbox
-- highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
-- cmd ([[ autocmd highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE ]])
-- cmd("hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE")
-- cmd("hi LineNr term=bold ctermfg=DarkGrey ctermbg=Red")

