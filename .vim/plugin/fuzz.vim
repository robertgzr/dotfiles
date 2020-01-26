" skip this, we have vim-clap now!!!
finish

if exists('g:loaded_fuzz')
  finish
endif
let g:loaded_fuzz = 1
let g:fuzz_prompt = '❯'

nmap <silent> ff :call fuzz#files()<CR>
nmap <silent> fb :call fuzz#buffers()<CR>
nmap <silent> fc :call fuzz#commands()<CR>
nmap <silent> fr :Rg<space>

command! -nargs=* -complete=custom,fuzz#cmdoptions Fuzz :call fuzz#exec(<f-args>)
command! -nargs=* Rg :call fuzz#rg(<f-args>)
