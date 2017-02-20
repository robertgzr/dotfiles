"" Some Autocommands

" formatter
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

augroup filetype_various
    autocmd!
    " toggle spell-check if filetype is markdown
    au FileType markdown setlocal spell
    " Disable tabs->spaces for Makefiles
    au FileType make setlocal noexpandtab
augroup END
