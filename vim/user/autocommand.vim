"" Some Autocommands

" augroup metagrp
"     autocmd!
"     autocmd BufWritePre * Neoformat
" augroup END

" enable fugitive in dirvish
" autocmd FileType dirvish call fugitive#detect(@%)

" toggle between header and implementation in c/cpp
function! s:c_alternate()
    let file = expand("%")
    if match(file, '\.c') > 0
        exe ':e %<.h'
    elseif match(file, '\.h') > 0
        exe ':e %<.c'
    endif
endfunction

augroup ctype_toggle
    autocmd!
    au FileType c,cpp command! -nargs=0 CAlternate call s:c_alternate()
    au FileType c nmap <Leader>a :CAlternate<CR>
    au FileType cpp nmap <Leader>a :CAlternate<CR>
augroup EN

augroup shada
    autocmd!
    autocmd BufEnter,CursorHold * rshada|wshada
augroup END
