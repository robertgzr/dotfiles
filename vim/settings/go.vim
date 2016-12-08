let g:go_fmt_autosave = 0
let g:go_metalinter_autosave = 0
let g:go_auto_type_info = 0

let g:go_fmt_command = 'goimports' " 'gofmt'
let g:go_fmt_fail_silently = 0

let g:go_term_enabled = 1
let g:go_term_mode = "split"
" let g:go_list_type = 'quickfix'

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = '2s'
"
let g:go_fmt_experimental = 1 " solves https://github.com/fatih/vim-go/issues/502
" let g:go_info_mode = 'guru'
" let g:go_auto_sameids = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1

augroup filetype_go
    au FileType go nmap <Leader>r <Plug>(go-run)
    au FileType go nmap <Leader>rt <Plug>(go-run-tab)
    au FileType go nmap <Leader>b <Plug>(go-build)
    au FileType go nmap <Leader>t <Plug>(go-test)
    au FileType go nmap <Leader>c <Plug>(go-coverage)
    au FileType go nmap <Leader>a <Plug>(go-alternate)
    au FileType go nmap <Leader>i <Plug>(go-info)
    au FileType go nmap <Leader>db <Plug>(go-doc-browser)
    au FileType go nmap <Leader>d <Plug>(go-def-split)
    au FileType go nmap <Leader>s <Plug>(go-implements)
    au FileType go nmap <Leader>e <Plug>(go-rename)
augroup END
