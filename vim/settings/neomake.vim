" Neomake maker definitions

" activate
autocmd! BufWritePost * Neomake

" JavaScript
" let g:neomake_javascript_jshint_maker = {
"     \ 'args': ['--verbose'],
"     \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
"     \ }
" let g:neomake_javascript_enabled_makers = ['jshint']

" let g:neomake_serialize = 1
" let g:neomake_open_list = 2

" CSS
let g:neomake_css_cssbeautify_maker = {
    \ 'exe': 'css-beautify',
    \ 'args': ['-r', '%:p', '--indent-size', '4']
    \ }
let g:neomake_css_enabled_makers = ['csslint', 'cssbeautify']

" Make
let g:neomake_makeclean_maker = { 'exe': 'make', 'args': ['clean'] }
