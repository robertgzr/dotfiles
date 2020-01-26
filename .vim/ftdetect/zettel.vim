augroup zettel_file
    au!
    au BufNewFile,BufRead * if zettel#is_zettel(expand('%:p')) | call zettel#set_filetype() | en
augroup END
