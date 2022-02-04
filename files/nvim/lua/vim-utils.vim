" NeoVim Conrfiguration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Use plug package manager  " Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync
endif
"""
call plug#begin()

"Plug 'kyoz/purify', { 'rtp': 'vim' }
"syntax on " This is required
"colorscheme purify

Plug 'skywind3000/asyncrun.vim'      " enable you to run shell commands in background
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
"       exec "AsyncRun! -raw python3 %"
    elseif &filetype == 'go'
       exec "AsyncRun! go build %<"
       exec "AsyncRun! time go run %"
    elseif &filetype == 'make'
       exec "AsyncRun! time make -f makefile %"
    endif
endfunction
let g:asyncrun_open = 15
"""
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" MarkDown in .vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" https://github.com/iamcco/markdown-preview.nvim
"" -- live preview markdown files in browser
"" Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app & yarn install', ['for'] = { 'markdown', 'mdx' } })

"" -- fold by heading
"" Plug('masukomi/vim-markdown-folding')
"" Plug('plasticboy/vim-markdown')

