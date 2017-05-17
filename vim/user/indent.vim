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

" IndentGuides plugin
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_color_change_percent = 5

" indentLine plugin
