"" Some Autocommands

augroup on_save
    autocmd!
    " autocmd BufWritePre * Neoformat
augroup END

" completion window
augroup completion_window
    autocmd!
    au InsertLeave * if pumvisible() == 0|pclose|endif
    au CompleteDone * if pumvisible() == 0|pclose|endif
augroup END

" enable fugitive in dirvish
" autocmd FileType dirvish call fugitive#detect(@%)

function! s:goyo_enter()
    set nonumber
    Limelight
endfunction
function! s:goyo_leave()
    set number
    Limelight!
endfunction

augroup minimal_ux
    autocmd!
    au User GoyoEnter nested call <SID>goyo_enter()
    au User GoyoLeave nested call <SID>goyo_leave()
augroup END

augroup filetype_various
    autocmd!
    " toggle spell-check if filetype is markdown
    au FileType markdown setlocal spell
    " Disable tabs->spaces for Makefiles
    au FileType make setlocal noexpandtab
augroup END

" toggle between header and implementation in c/cpp
function! s:c_alternate()
    let file = expand("%")
    if match(file, '\.c') > 0
        exe ":e %<.h"
    elseif match(file, '\.h') > 0
        exe ":e %<.c"
    endif
endfunction

augroup ctype_toggle
    autocmd!
    au FileType c,cpp command! -nargs=0 CAlternate call s:c_alternate()
    au FileType c nmap <Leader>a :CAlternate<CR>
    au FileType cpp nmap <Leader>a :CAlternate<CR>
augroup END
