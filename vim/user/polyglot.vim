"" Language options

" Neomake 
" let g:neomake_serialize = 1
" augroup neomake_activate
    " autocmd! BufWritePost * Neomake
" augroup end

" JSON
let g:vim_json_syntax_conceal = 1

" Markdown
let g:markdown_syntax_conceal = 1

" Rust
let g:racer_cmd = $HOME.'/.cargo/bin/racer'

augroup filetype_rust
    autocmd!
    au FileType rust call lexima#add_rule({'filetype': ['rust'], 'char': "'", 'at': '<\%# | &\%#'})
    au FileType rust nmap <Leader>d <Plug>(rust-doc)
    au FileType rust nmap <Leader>j <Plug>(rust-def-split)
augroup END

" Make
let g:neomake_makeclean_maker = { 'exe': 'make', 'args': ['clean'] }
augroup filetype_make
    autocmd!
    " Disable tabs->spaces for Makefiles
    au FileType make setlocal noexpandtab
augroup END

" Protobuf
let g:neomake_proto_lint_maker = {
    \ 'exe': 'protoc',
    \ 'args': ['--lint_out=.'],
    \ 'errorformat': '%f:%l:%c: %m',
    \ }
let g:neomake_proto_enabled_makers = ['lint']

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
