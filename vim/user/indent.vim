"" FileType-based indentation

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

function! Tabthis()
    setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
    retab!
endfunction
nmap <Leader>tt :call Tabthis()<CR>

" set autoindent
filetype plugin indent on

" augroup indentation_filetypes
"     autocmd!
"     autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
"     autocmd FileType html   setlocal expandtab shiftwidth=2 softtabstop=2
"     autocmd FileType vue    setlocal expandtab shiftwidth=2 softtabstop=2
"     autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
"     autocmd FileType ruby   setlocal expandtab shiftwidth=2 softtabstop=2
"     autocmd FileType go setlocal expandtab shiftwidth=4 softtabstop=4
"     autocmd FileType c setlocal expandtab shiftwidth=4 softtabstop=4
"     autocmd FileType cpp setlocal expandtab shiftwidth=4 softtabstop=4
"     autocmd FileType zsh setlocal expandtab shiftwidth=4 softtabstop=4
"     autocmd FileType bash setlocal expandtab shiftwidth=4 softtabstop=4
"     autocmd FileType sh setlocal expandtab shiftwidth=4 softtabstop=4
"     autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2
"     autocmd FileType toml setlocal expandtab shiftwidth=2 softtabstop=2
"     autocmd FileType json setlocal expandtab shiftwidth=2 softtabstop=2
" augroup END

" IndentGuides plugin
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_color_change_percent = 2
"
" indentline config
" let g:indentline_setColors = 0
" let g:indentLine_color_color_term = 239
" let g:indentLine_color_color_gui = '#333333'
" let g:indentLine_color_color_dark = 1
" let g:indentLine_char = '┊'
" let g:indentLine_char = '.'
