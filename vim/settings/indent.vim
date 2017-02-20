"" FileType-based indentation

set expandtab
set shiftwidth=4
set softtabstop=4

" set autoindent
filetype plugin indent on

augroup indentation_filetypes
    autocmd!

    autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType html   setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType vue    setlocal expandtab shiftwidth=2 softtabstop=2

    autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType ruby   setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType go setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType c setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType cpp setlocal expandtab shiftwidth=4 softtabstop=4

    autocmd FileType zsh setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType bash setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType sh setlocal expandtab shiftwidth=4 softtabstop=4
augroup END
