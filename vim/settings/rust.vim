let g:racer_cmd = $HOME.'/.cargo/bin/racer'

" call lexima#add_rule({'char': '', })

augroup filetype_rust
    autocmd!
    au FileType rust nmap <Leader>d <Plug>(rust-doc)
    au FileType rust nmap <Leader>d <Plug>(rust-def-split)
augroup END
