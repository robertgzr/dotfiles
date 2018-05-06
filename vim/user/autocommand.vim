augroup metagrp
    au!
    " au BufWritePre * Neoformat
    au BufEnter,CursorHold * rshada|wshada
    " au FileType dirvish call fugitive#detect(@%)
augroup END

augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END
