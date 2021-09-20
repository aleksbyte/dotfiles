" NeoVim Conrfiguration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Use plug package manager  " Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync
endif
"
call plug#begin()

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
    elseif &filetype == 'go'
       exec "AsyncRun! go build %<"
       exec "AsyncRun! time go run %"
    elseif &filetype == 'make'
       exec "AsyncRun! time make -f makefile %"
    endif
endfunction
let g:asyncrun_open = 15

"Plug 'pearofducks/ansible-vim'
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }

let g:ansible_unindent_after_newline = 1
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1
au BufRead,BufNewFile *inventory*.yml    set filetype=yaml.ansible
au BufRead,BufNewFile */inventory/*.yml  set filetype=yaml.ansible
au BufRead,BufNewFile */playbooks/*.yml  set filetype=yaml.ansible
au BufRead,BufNewFile */roles/*.yml    set filetype=yaml.ansible
au BufRead,BufNewFile */tasks/*.yml        set filetype=yaml.ansible
augroup ansible_vim_fthosts
  autocmd!
  autocmd BufNewFile,BufRead hosts setfiletype yaml.ansible
augroup END

" Terraform
"Plug 'hashivim/vim-terraform'
"let g:terraform_align = 1       " Auto-align code as I type
"let g:terraform_fold_sections=1 " Allow folding

call plug#end() ""
"
