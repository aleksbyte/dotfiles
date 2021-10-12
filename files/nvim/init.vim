" NeoVim Conrfiguration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set shell=/opt/homebrew/bin/zsh " Set the shell
set encoding=utf-8
scriptencoding utf-8

set t_Co=256                 " 256 colours for regular vim if the terminal can handle it.
set history=100              " longer command history (default=20)

let mapleader = '\'          " Remap the leader key to the spacebar
let g:mapleader = '\'
""" Use plug package manager  " Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync
endif
"
call plug#begin()
Plug 'itchyny/lightline.vim'         " Light and configurable statusline/tabline plugin.
Plug 'shinchu/lightline-gruvbox.vim' " gruvbox theme for lightline
Plug 'mark-westerhof/vim-lightline-base16'
Plug 'skywind3000/asyncrun.vim'      " enable you to run shell commands in background
Plug 'Yggdroot/indentLine'           " Better Visual Guide
Plug 'jiangmiao/auto-pairs'          " Insert or delete brackets, parens, quotes in pair.
" Plug 'junegunn/fzf'                  " command-line fuzzy finder
Plug 'junegunn/fzf',{'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

Plug 'SirVer/ultisnips'

"Plug 'SirVer/ultisnips'          " Snippets plugin
" Snippets are separated from the engine. Add this if you want them:
"Plug 'honza/vim-snippets'
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsListSnippets="<C-l>"
"let g:UltiSnipsJumpForwardTrigger="<C-j>"
"let g:UltiSnipsJumpBackwardTrigger="<C-k>"
"let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetDirectories  = ['codesnippets']
" let g:UltiSnipsSnippetsDir = '~/.vim/codesnippets'
" let g:UltiSnipsEditSplit = 'context'
"nnoremap <Leader>es :UltiSnipsEdit<Cr>

"https://2sang.github.io/journal/vim-snippets-management.html
"Separate vim-snippets and your private snippets
" Our personal snippets go into ~/dotfiles/user_snippets.
" By defining this, ':UltiSnipsEdit' call opens new file at this location
"let g:UltiSnipsSnippetsDir="~/dotfiles/user_snippets"

" Add your private snippet path to runtimepath
"set runtimepath^=~/dotfiles
" When vim starts, Ultisnips tries to find snippet directories defined below, under the paths in runtimepath.
"let g:UltiSnipsSnippetDirectories=["UltiSnips", "user_snippets"]

"nnoremap <leader>es :UltiSnipsEdit<cr>

" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"Plug 'pearofducks/ansible-vim'
Plug 'pearofducks/ansible-vim', { 'do': './ultisnips/generate.sh' }
"Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; ./generate.py' }

Plug 'neoclide/coc.nvim', {'branch': 'release'} "Completions and more using Coc
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} "Completions and mor

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"
"Plug 'airblade/vim-gitgutter'  " Shows a git diff in the 'gutter' (sign column).
Plug 'tpope/vim-fugitive'      " :Git (or just :G), which calls any arbitrary Git command ..

"Plug 'tpope/vim-repeat'
"Plug 'pappasam/nvim-repl'
"nnoremap <leader><leader>e :ReplToggle<CR>
"nmap <leader>a <Plug>ReplSendLine
"vmap <leader>a <Plug>ReplSendVisual
"let g:repl_filetype_commands = {
"      \ 'python': 'bpython -q',
"      \ }

Plug 'morhetz/gruvbox'           " Color theme gruvbox
call plug#end() ""
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" morhetz/gruvbox    "  Color Settings color theme gruvbox
colorscheme gruvbox    " gruvbox
set background=dark    " gruvbox dark
let g:gruvbox_contrast_dark = 'medium' " default - medium, opt 'soft','hard'
"
" lightline
let g:lightline = {
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'ctrlpmark', 'git', 'diagnostic', 'cocstatus', 'filename', 'method' ]
  \   ],
  \   'right':[
  \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \     [ 'blame' ]
  \   ],
  \ },
  \ 'component_function': {
  \   'blame': 'LightlineGitBlame',
  \ }
\ }
function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction
"
""""" 'skywind3000/asyncrun.vim'  " enable you to run shell commands in background
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr> " run make
nnoremap <F5> :call <SID>compile_and_run()<CR>
function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! /opt/homebrew/opt/openjdk/bin/javac %; time /opt/homebrew/opt/openjdk/bin/java %<"
"       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python3 %"
    elseif &filetype == 'go'
       exec "AsyncRun! go build %<"
       exec "AsyncRun! time go run %"
    elseif &filetype == 'make'
       exec "AsyncRun! time make -f makefile %"
    endif
endfunction
let g:asyncrun_open = 15
"
""""" Yggdroot/indentLine -  Better Visual Guide
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_char = '┆'
"let g:indentLine_color_gui='#363232'
"let g:indentLine_color_term = 239
"
""""" fzf   command-line fuzzy finder  configs
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'down': '~35%' }
" find file under current directory
nnoremap <silent><leader>f :FZF<cr>
" find file under HOME directory
nnoremap <silent><leader>F :FZF ~<cr>
" Search in rg search
nnoremap <silent><leader>g :Rg<cr>
" List buffers-
nnoremap <silent><leader>b  :Buffers<cr>
"
nnoremap <silent><leader>s :Snippets<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-o> :Buffers<CR>
nnoremap <C-g> :GFiles<CR>
nnoremap <C-f> :Rg
"
"""""  pearofducks/ansible-vim
let g:ansible_unindent_after_newline = 1
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1
au BufRead,BufNewFile */inventory/*.yml  set filetype=yaml.ansible
au BufRead,BufNewFile */playbooks/*.yml  set filetype=yaml.ansible
au BufRead,BufNewFile */roles/*/*.yml    set filetype=yaml.ansible
au BufRead,BufNewFile *plays*.yml        set filetype=yaml.ansible
au BufRead,BufNewFile *inventory*.yml    set filetype=yaml.ansible
augroup ansible_vim_fthosts
  autocmd!
  autocmd BufNewFile,BufRead hosts setfiletype yaml.ansible
augroup END
"
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
let g:coc_global_extensions = [
            \ 'coc-tsserver',
            \ 'coc-sh',
            \ 'coc-pyright',
            \ 'coc-git',
            \ 'coc-yaml',
            \ ]
let g:coc_filetype_map = { 'yaml.ansible': 'y*ml', }
"
" iamcco/markdown-preview.nvim        MarkdownPreview
let g:mkdp_auto_start = 0
nmap <leader>h :MarkdownPreview<cr>
nmap <leader>hc :MarkdownPreviewStop><cr>
"nmap <leader>v :MarkdownPreviewToggle<cr>
"nmap <C-s> <Plug>MarkdownPreview
"nmap <M-s> <Plug>MarkdownPreviewStop
"nmap <C-p> <Plug>MarkdownPreviewToggle
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{  CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on                    " Enable syntax highlighting
syntax enable
"
filetype plugin on           " Filetype detection
filetype indent plugin on    " Format indentation
"
" wildignoresettings
set wildignore+=*.pyc
set wildignore+=*.gem
set wildignore+=*.bak,*~,*.swp,*.lock
set wildignore+=*.o,*.lo,*.ko,*.so
set wildignore+=*.git/*
set wildignore+=*.svn/*
set wildignore+=*_build/*
set wildignore+=*build/*
set wildignore+=*target/*
set wildignore+=*coverage/*
set wildignore+=*.egg
set wildignore+=*.egg-info
set wildignore+=*.jpg,*.png,*.gif
set wildignore+=*.pdf,*.ps,*.aux,*.bbl,*.docx,*.doc,*.ppt,*.pptx,*.rtf
set wildignore+=*.mp3,*.ogg,*.mpg,*.mp4,*.wav,*.mov
"
set rtp+=/usr/local/opt/fzf
set showmatch               " Show highlight matching brackets  [{()}]
" Configure spell checking
nmap <silent> <leader>p :set spell!<CR>
set spelllang=en_us
set colorcolumn=80
noremap <Leader>w :w<CR>     " Save the current buffer using the leader key
noremap <Leader>e :wq<CR>    " Save and exit Vim using the leader key
noremap <Leader>q :q!<CR>    " Exit without saving using the leader key
" Show CursorLine
set cursorline               " Highlights the current line of the cursor
"hi  cursorline  ctermbg=239  cterm=none
hi  cursorline  ctermbg=238  cterm=none
" Line numbers
set number                   " show line number
set relativenumber           " show relative line number set nobackup
nnoremap <leader>n :set nonumber!<CR>
nnoremap <leader>r :set relativenumber!<CR>
nnoremap <leader>rn :set norelativenumber!<CR>
"hi LineNr ctermfg=241 ctermbg=236
hi LineNr ctermfg=241 ctermbg=none
" Folding {{{
"=== folding ===
set foldmethod=marker   " fold based on
" set foldmethod=indent
" set foldmethod=syntax
set foldnestmax=10
set foldlevel=2
" add yaml stuffs ..
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
set foldenable          " enable folding
set nofoldenable
"}}}
" {{{ Searching & Replacing
"set gdefault                   " use 'global' mode by default for substitutions
set hlsearch                         " highlight searched items
" nnoremap <leader>c    :nohl<CR>      " Clear highlighting
nnoremap <leader><esc>    :nohl<CR>      " Clear highlighting
" }}}
" {{{ Whitespace settings
set nowrap                          " don't wrap lines
set tabstop=4                       " a tab is two spaces
set shiftwidth=4                    " an autoindent (with <<) is two spaces
set expandtab                       " use spaces, not tabs
set nolist                    " Show invisible characters using listchars
nnoremap <leader>l :set list<CR>
nnoremap <leader>k :set nolist<CR>
" Set to show invisibles (tabs & trailing spaces) & their highlight color
"set list listchars=tab:»\ ,trail:·
set list                    " Show invisible characters using listchars
"set list listchars=tab:▸\ ,eol:¬
" Set filetype tab settings
autocmd FileType python,doctest set ai ts=4 sw=4 sts=4 et
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" }}}
"
"}}}  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ KEY MAPPINGS
" standard bash shortcuts Ctrl-E and Ctrl-A in vim
map <C-E> $
map <C-A> 0|
" also work in input insert mode
map! <C-E> <esc>A
map! <C-A> <esc>0i
"
" Use Ctrl+K to delete from the cursor to the end of the line.
map <C-K> d$
" Use Ctrl+U to delete from the cursor to the beginning of the line.
"map <C-U> d0

set clipboard=unnamed         " copy to the system clipboard
set clipboard+=unnamedplus
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy
" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
"
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_liststyle=3
let g:netrw_localrmdir='rm -r'
"nnoremap <leader>n :Lexplore<CR>
"
" shortcuts to other common commands
" nnoremap <leader>t :Tags<CR>
noremap  <leader>z  :terminal<CR>

" Split managment
map <silent> <A-s> :split<CR>   " Split horizontal, ALT-s
map <silent> <A-v> :vsplit<CR>  " Split vertical, ALV-v

" Settings for buffers
nnoremap <leader>b  :Buffers<CR>
nnoremap <leader>bb :ls<CR>:b<Space>  " list all current buffers
nnoremap <leader>bc :bd<CR>           " close buffer
nnoremap <leader>bn :bn<CR>           " move to next buffer
nnoremap <leader>bp :bp<CR>           " move to previous buffer
noremap <C-Right>   :bn<CR>           " move to next buffer, CTRL-Right
noremap <C-Left>    :bp<CR>           " move to previous buffer, CTRL-Left

" <Leader>T = Delete all Trailing space in file
nnoremap <Leader>t :%s/\s\+$//<CR>:let @/=''<CR>:nohlsearch<CR>

map <leader>- :e $HOME/.config/nvim/init.vim<CR>            " init.vim editing
map <silent> <F1> :source $HOME/.config/nvim/init.vim<CR>   " source init.vim
"}}}  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
