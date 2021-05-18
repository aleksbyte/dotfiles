" NeoVim Conrfiguration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{  BASIC
set nocompatible
set shell=/usr/local/bin/zsh " Set the shell
set encoding=utf-8
scriptencoding utf-8

set t_Co=256                 " 256 colours for regular vim if the terminal can handle it.
set history=100              " longer command history (default=20)

let mapleader = '\'          " Remap the leader key to the spacebar
let g:mapleader = '\'
syntax on                    " Enable syntax highlighting
syntax enable

filetype plugin on           " Filetype detection
filetype indent plugin on    " Format indentation
"}}}  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{  PLUGINS
" Use plug package manager

" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync 
"    "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"

call plug#begin()
Plug 'itchyny/lightline.vim'     "{{{ Light and configurable statusline/tabline plugin.
" }}}
Plug 'mark-westerhof/vim-lightline-base16'
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
       exec "AsyncRun! time python3 %"
    elseif &filetype == 'go'
       exec "AsyncRun! go build %<"
       exec "AsyncRun! time go run %"
    elseif &filetype == 'make'
       exec "AsyncRun! time make -f makefile %"
    endif
endfunction
let g:asyncrun_open = 15
" }}}
Plug 'Yggdroot/indentLine'       "{{{ Better Visual Guide
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_char = '┊'
"let g:indentLine_color_gui='#363232'
"let g:indentLine_color_term = 239
" }}}
Plug 'jiangmiao/auto-pairs'      "{{{ Insert or delete brackets, parens, quotes in pair.
"}}}
"Plug 'junegunn/fzf'              "{{{ command-line fuzzy finder
Plug 'junegunn/fzf',{'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'  "{ command-line fuzzy finder
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'down': '~30%' }
nnoremap <silent><C-t>     :FZF -m<CR>   " fuzzy
nnoremap <silent><leader>o :Files<CR>    " Search files recursively ([o]pen file)
nnoremap <silent><leader>g :Rg<CR>       " Search in rg search
nnoremap <silent><leader>s :Snippets<CR>
"nnoremap <silent><leader>s :Snippets<CR> " Search in ultisnips [s]nippets
nnoremap <silent> <leader>f :FZF<cr>     " find file under current directory
nnoremap <silent> <leader>F :FZF ~<cr>   " find file under HOME directory

nnoremap <C-p> :Files<CR>
nnoremap <C-o> :Buffers<CR>
nnoremap <C-g> :GFiles<CR>
nnoremap <C-f> :Rg 

" }}}
Plug 'tpope/vim-fugitive'        "{{{  git plugin
nmap <silent><leader>gs :Gstatus<cr>   " fuGitive
nmap <silent><leader>ge :Gedit<cr>     " fuGitive
nmap <silent><leader>gr :Gread<cr>     " fuGitive
nmap <silent><leader>gb :Gblame<cr>    " fuGitive
" nmap     <Leader>g :Gstatus<CR>gg<c-n>
" nnoremap <Leader>d :Gdiff<CR>

"nmap <Leader>gb :Gblame<cr>
"nmap <Leader>gs :Gstatus<cr>
nmap <Leader>gc :Gcommit -v<cr>
nmap <Leader>ga :Git add -p<cr>
nmap <Leader>gd :Gdiff<cr>
"nmap <Leader>gm :Gcommit --amend<cr>
"nmap <Leader>gp :Gpush<cr>
"nmap <Leader>gw :Gwrite<cr>

" }}}
"Plug 'SirVer/ultisnips'          "{{{ Snippets plugin
" Snippets are separated from the engine. Add this if you want them:
"Plug 'honza/vim-snippets'
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"let g:UltiSnipsExpandTrigger="<tab>"
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

" }}}
"Plug 'phenomenes/ansible-snippets'  "{{{ ansible-snippets
Plug 'phenomenes/ansible-snippets'
"}}}
"Plug 'pearofducks/ansible-vim'  "{{{    ansible-vim syntax highlighting
Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; ./generate.py' }
let g:ansible_unindent_after_newline = 1
let g:ansible_extra_keywords_highlight = 1
au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
au BufRead,BufNewFile */roles/*/*.yml set   filetype=yaml.ansible
au BufRead,BufNewFile *inventory*.yml set   filetype=yaml.ansible
"}}}
"
Plug 'hashivim/vim-terraform'                  " Terraform syntax highlighting"
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'   " 


"  Plug 'iamcco/markdown-preview.nvim'       {{{     MarkdownPreview
"Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown', 'on': 'MarkdownPreview' }
"  https://github.com/iamcco/markdown-preview.nvim
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
let g:mkdp_auto_start = 0
nmap <leader>h :MarkdownPreview<cr>
nmap <leader>hc :MarkdownPreviewStop><cr>
"nmap <leader>v :MarkdownPreviewToggle<cr>
"nmap <C-s> <Plug>MarkdownPreview
"nmap <M-s> <Plug>MarkdownPreviewStop
"nmap <C-p> <Plug>MarkdownPreviewToggle
Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' }
nmap <leader>m :MarkedOpen!<cr>
nmap <leader>mq :MarkedQuit<cr>
nmap <leader>* *<c-o>:%s///gn<cr>
"" markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['go', 'python', 'bash=sh', 'yaml']
let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
"let g:vim_markdown_folding_disabled = 1
"    " markdown {{{
"        Plug 'tpope/vim-markdown', { 'for': 'markdown' }
"        let g:markdown_fenced_languages = [ 'tsx=typescript.tsx' ]
"let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
"        " Open markdown files in Marked.app - mapped to <leader>m

"    " }}}
"}}

" vim-plug
"Plug 'neovim/nvim-lspconfig'
" minpac
"call minpac#add('neovim/nvim-lspconfig', {'type': 'opt'})
"packadd nvim-lspconfig


"https://www.chrisatmachine.com/Neovim/04-vim-coc/


"Plug 'neoclide/coc.nvim'    "  {{{
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
let g:coc_global_extensions = [
            \ 'coc-tsserver',
            \ 'coc-vimlsp',
            \ 'coc-sh',
            \ 'coc-python',
            \ 'coc-snippets',
            \ 'coc-git',
            \ 'coc-json',
            \ 'coc-yaml',
            \ ]
let g:coc_filetype_map = { 'yaml.ansible': 'y*ml', }

" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
" }}}

" https://github.com/fcpg/vim-showmap
" Plug 'fcpg/vim-showmap'  "helps you type multi-char mappings

Plug 'morhetz/gruvbox'           "{{{ Color theme gruvbox
"}}}
call plug#end()
"
"Color Settings
colorscheme gruvbox    " gruvbox
set background=dark    " gruvbox dark
"let g:gruvbox_contrast_dark = 'soft'
"let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_italic=1

if (has("termguicolors"))
    set termguicolors
endif
" Adds correct highlighting of JSONC files
autocmd FileType json syntax match Comment +\/\/.\+$+

"}}}  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"{{{  CONFIGURATION
set rtp+=/usr/local/opt/fzf
set showmatch               " Show highlight matching brackets  [{()}]

" https://www.reddit.com/r/neovim/comments/jy8akf/til_i_can_use_direnv_with_fzfvim_for_project/
set exrc secure " direnv - Add to .exrc file in the root directory of your project ..
" let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow \ 
"      --glob "!.git/*" --glob "!build/*" --glob "!.autogenerated"'
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
" https://bitcrowd.dev/folding-sections-of-markdown-in-vim
"let g:markdown_folding = 1 " folding markdown
"command	effect
"zo	open current fold
"zO	recursively open current fold
"zc	close current fold
"zC	recursively close current fold
"za	toggle current fold
"zA	recursively open/close current fold
"zm	reduce foldlevel by one
"zM	close all folds
"zr	increase foldlevel by one
"zR	open all folds
"}}}
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
"set list listchars=tab:»\ ,trail:·
set list                              "Show invisible characters using listchars
set listchars=tab:▸\ ,nbsp:␣,trail:·  "Define chars for 'list'
"set list listchars=tab:▸\ ,eol:¬
" Set filetype tab settings
autocmd FileType python,doctest set ai ts=4 sw=4 sts=4 et
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab
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
"map <silent> <A-s> :split<CR>   " Split horizontal, ALT-s
"map <silent> <A-v> :vsplit<CR>  " Split vertical, ALV-v
"nnoremap <leader>v  :vsplit<CR>
"nnoremap <leader>s  :split s <CR>

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
