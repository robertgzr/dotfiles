" Neomake maker definitions

" activate
augroup neomake_activate
    " autocmd! BufWritePost * Neomake
augroup end

let g:neomake_serialize = 1
" let g:neomake_open_list = 2

" JS
let g:neomake_javascript_jshint_maker = {
            \ 'args': ['--esversion=6'],
            \ }

" CSS
let g:neomake_css_cssbeautify_maker = {
    \ 'exe': 'css-beautify',
    \ 'args': ['-r', '%:p', '--indent-size', '4']
    \ }
let g:neomake_css_enabled_makers = ['csslint', 'cssbeautify']

" Make
let g:neomake_makeclean_maker = { 'exe': 'make', 'args': ['clean'] }

" Protobuf
let g:neomake_proto_lint_maker = {
    \ 'exe': 'protoc',
    \ 'args': ['--lint_out=.'],
    \ 'errorformat': '%f:%l:%c: %m',
    \ }
let g:neomake_proto_enabled_makers = ['lint']
