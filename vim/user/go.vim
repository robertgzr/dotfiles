" deactivate vim-polyglot go support
let g:polyglot_disabled = ['go']
let g:neoformat_enabled_go = []

let g:go_fmt_autosave = 0
let g:go_metalinter_autosave = 0
let g:go_auto_type_info = 0

let g:go_fmt_command = 'gofmt'
let g:go_fmt_fail_silently = 1

let g:go_term_enabled = 1
let g:go_term_mode = 'split'

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = '2s'

let g:go_fmt_experimental = 1 " solves https://github.com/fatih/vim-go/issues/502
let g:go_info_mode = 'guru'
let g:go_auto_sameids = 1

let g:go_gocode_unimported_packages = 1
let g:go_list_type = 'quickfix'

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_operators = 0
let g:go_highlight_space_tab_error = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_trailing_whitespace_error = 1

augroup filetype_go
    autocmd!
    au FileType go nmap <Leader>r <Plug>(go-run)
    au FileType go nmap <Leader>rt <Plug>(go-run-tab)
    au FileType go nmap <Leader>b <Plug>(go-build)
    au FileType go nmap <Leader>t <Plug>(go-test)
    au FileType go nmap <Leader>c <Plug>(go-coverage)
    au FileType go nmap <Leader>cb <Plug>(go-coverage-browser)
    au FileType go nmap <Leader>a <Plug>(go-alternate-edit)
    au FileType go nmap <Leader>av <Plug>(go-alternate-vertical)
    au FileType go nmap <Leader>i <Plug>(go-info)
    au FileType go nmap <Leader>db <Plug>(go-doc-browser)
    au FileType go nmap <Leader>d <Plug>(go-doc)
    au FileType go nmap <Leader>j <Plug>(go-def)
    au FileType go nmap <Leader>im <Plug>(go-implements)
    au FileType go nmap <Leader>rn <Plug>(go-rename)
    au FileType go nmap <Leader>f <Plug>(go-imports)
    au FileType go nmap <Leader>l <Plug>(go-lint)
augroup END

" https://github.com/fatih/dotfiles/blob/master/vimrc#L380
" create a go doc comment based on the word under the cursor
function! s:create_go_doc_comment()
  norm "zyiw
  execute ":put! z"
  execute ":norm I// \<Esc>$"
endfunction
nnoremap <leader>ui :<C-u>call <SID>create_go_doc_comment()<CR>
