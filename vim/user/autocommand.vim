augroup metagrp
    au!
    au BufEnter,CursorHold * rshada|wshada
    " au BufWritePre * Neoformat
    " au FileType dirvish call fugitive#detect(@%)
augroup END

augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

augroup Formatting
    autocmd!
    autocmd BufWritePre rust call LanguageClient_textDocument_formatting()
augroup END

