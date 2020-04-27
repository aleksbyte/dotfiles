" NeoVim Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{  BASIC
set shell=/usr/local/bin/zsh " Set the shell
set encoding=utf-8
set t_Co=256                 " 256 colours for regular vim if the terminal can handle it.
set history=100              " longer command history (default=20)

let mapleader = '\'          " Remap the leader key to the spacebar
syntax on                    " Enable syntax highlighting
syntax enable

filetype plugin on           " Filetype detection
filetype indent plugin on    " Format indentation
"}}}  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{  PLUGINS
call plug#begin()
Plug 'itchyny/lightline.vim'     "{{{ Light and configurable statusline/tabline plugin.
" }}}
Plug 'skywind3000/asyncrun.vim'  "{{{ enable you to run shell commands in background
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr> " run make
nnoremap <F5> :call <SID>compile_and_run()<CR>
function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python %"
    endif
endfunction
let g:asyncrun_open = 15
" }}}
Plug 'Yggdroot/indentLine'       "{{{ Better Visual Guide
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_gui='#363232'
" }}}
Plug 'w0rp/ale'                  "{{{ ALE (Asynchronous Lint Engine)
let g:ale_change_sign_column_color = 0
let g:ale_sign_error = "●"
highlight ALEErrorSign ctermbg=NONE ctermfg=red
let g:ale_sign_warning = "●"
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_sign_info = '??'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
\       'sh': ['shellcheck'],
\       'python3': ['flake8'],
\       'java': ['javac'],
\       'lua': ['luac'],
\       'yml': ['prettier', 'ansible-lint'],
\       'json': ['jsonlint'],
\       'dockerfile': ['hadolint'],
\       'markdown': ['alex', 'mdl', 'vale'],
\       'terraform': ['terraform'],
\       'xml': ['xmllint'],
\       'c': ['cpplint'],
\       'cpp': ['cpplint']
\}
let g:ale_fixers = {
\'*': ['remove_trailing_lines', 'trim_whitespace'],
\       'sh': ['shfmt'],
\       'python3': ['black'],
\       'c': ['clang-format'],
\       'cpp': ['clang-format'],
\       'java': ['clang-format'],
\       'markdown': ['prettier'],
\       'json': ['jq'],
\       'terraform': ['terraform'],
\}
noremap  <leader>f  :ALEFix<CR>
" }}}
Plug 'ncm2/ncm2'                 "{{{ Autocomplete python3
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-jedi', { 'for': 'python' }
Plug 'ncm2/ncm2-vim'
Plug 'ncm2/ncm2-go', { 'for': 'go' }
" ncm2 settings
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noselect,noinsert
set shortmess+=c
inoremap <c-c> <ESC>
" make it fast
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
" Use new fuzzy based matches
let g:ncm2#matcher = 'substrfuzzy'
" }}}
"Plug 'junegunn/fzf'              "{{{ command-line fuzzy finder
Plug 'junegunn/fzf',{'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'  "{ command-line fuzzy finder
set rtp+=/usr/local/opt/fzf

let g:fzf_layout = { 'down': '~30%' }
nnoremap <silent><C-t>     :FZF -m<CR>   " fuzzy
nnoremap <silent><leader>o :Files<CR>    " Search files recursively ([o]pen file)
nnoremap <silent><leader>g :Rg<Cr>       " Search in rg search
nnoremap <silent><leader>s :Snippets<CR> " Search in ultisnips [s]nippets
" }}}
Plug 'tpope/vim-fugitive'        "{{{  git plugin
nmap <silent><leader>gs :Gstatus<cr>   " fuGitive
nmap <silent><leader>ge :Gedit<cr>     " fuGitive
nmap <silent><leader>gr :Gread<cr>     " fuGitive
nmap <silent><leader>gb :Gblame<cr>    " fuGitive
" }}}
Plug 'SirVer/ultisnips'          "{{{ Snippets plugin
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsListSnippets="<C-l>"
let g:UltiSnipsEditSplit="vertical"
" }}}
"Plug 'pearofducks/ansible-vim'  "{{{    ansible-vim
Plug 'pearofducks/ansible-vim' , {'do': './UltiSnips/generate.sh' }
"Plug 'pearofducks/ansible-vim'
"Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; ./generate.py' }
let g:ansible_unindent_after_newline = 1
"}}}
"Plug 'phenomenes/ansible-snippets'  "{{{ ansible-snippets
Plug 'phenomenes/ansible-snippets'
"}}}
Plug 'morhetz/gruvbox'           "{{{ Color theme gruvbox
" }}}
call plug#end()
"
colorscheme gruvbox    " gruvbox
set background=dark    " gruvbox dark

"}}}  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{  CONFIGURATION
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
set relativenumber
"set relativenumber          " show relative line number set nobackup
nnoremap <leader>n :set nonumber!<CR>
nnoremap <leader>r :set relativenumber!<CR>
nnoremap <leader>rn :set norelativenumber!<CR>
nmap <C-N><C-N> :set invnumber<CR>     " Turn on/off line numbering
hi LineNr ctermfg=241 ctermbg=236

" Folding {{{
"=== folding ===
set foldenable          " enable folding
set foldmethod=marker   " fold based on
" }}}
" {{{ Searching & Replacing
"set gdefault                   " use 'global' mode by default for substitutions
set hlsearch                         " highlight searched items
nnoremap <leader>c    :nohl<CR>      " Clear highlighting
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
set list listchars=tab:»\ ,trail:·

" Set filetype tab settings
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python,doctest set ai ts=4 sw=4 sts=4 et

" }}}
"
"
"}}}  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ KEY MAPPINGS
" standard bash shortcuts Ctrl-E and Ctrl-A in vim
map <C-E> $
map <C-A> 0|
" also work in input insert mode
map! <C-E> <esc>A
map! <C-A> <esc>0i

" Use Ctrl+K to delete from the cursor to the end of the line.
map <C-K> d$
" Use Ctrl+U to delete from the cursor to the beginning of the line.
"map <C-U> d0

let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_liststyle=3
let g:netrw_localrmdir='rm -r'
"nnoremap <leader>n :Lexplore<CR>

" shortcuts to other common commands
" nnoremap <leader>t :Tags<CR>
noremap  <leader>z  :terminal<CR>

" Split managment
map <silent> <A-s> :split<CR>   " Split horizontal, ALT-s
map <silent> <A-v> :vsplit<CR>  " Split vertical, ALV-v
nnoremap <leader>v  :vsplit<CR>
nnoremap <leader>s  :split s <CR>

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
