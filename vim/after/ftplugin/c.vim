if exists('g:loaded_gutentags')
    let g:gutentags_enabled = 1
endif

" toggle between header and implementation in c/cpp
function! Alternate_c()
    let file = expand('%')
    if match(file, '\.c') > 0
        exe ':e %<.h'
    elseif match(file, '\.h') > 0
        exe ':e %<.c'
    endif
endfunction

nmap <Leader>a alternate#alternate()<CR>
