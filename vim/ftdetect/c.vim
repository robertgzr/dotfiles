let g:gutentags_enabled = 1
" toggle between header and implementation in c/cpp
function! s:c_alternate()
    let file = expand("%")
    if match(file, '\.c') > 0
        exe ':e %<.h'
    elseif match(file, '\.h') > 0
        exe ':e %<.c'
    endif
endfunction

    " C / Cpp
command! -nargs=0 CAlternate call s:c_alternate()
nmap <Leader>a :CAlternate<CR>
nmap <Leader>a :CAlternate<CR>
