" deactivate vim-polyglot go support
let g:neoformat_enabled_go = []

let g:go_echo_go_info = 0
let g:go_auto_type_info = 0
let g:go_info_mode = 'guru'
let g:go_auto_sameids = 1
let g:go_gocode_unimported_packages = 1
let g:go_list_type = 'quickfix'

let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_fmt_experimental = 1 " solves https://github.com/fatih/vim-go/issues/502

let g:go_term_enabled = 1
let g:go_term_mode = 'split'

let g:go_metalinter_autosave = 0
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = '2s'

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

" deoplete-go
" let g:deoplete#sources#go#gocode_binary = '' " $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#package_dot = 0
let g:deoplete#sources#go#pointer = 1
" let g:deoplete#sources#go#sort_class = [] " ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 0
" let g:deoplete#sources#go#json_directory = '' "$HOME.'/.cache/deoplete/go/'.$GOOS.'_'.$GOARCH
let g:deoplete#sources#go#align_class = 1
let g:deoplete#sources#go#cgo = 0
" let g:deoplete#sources#go#goos = ''

" tagbar - gotags
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
        \ }

let g:neomake_go_fast_maker = {
\   'exe': 'gometalinter',
\   'args': ['--vendor', '--fast'],
\   'append_file': 0,
\   'cwd': '%:h',
\   'errorformat': '%f:%l:%c:%t%*[^:]: %m',
\ }
let g:neomake_go_full_maker = g:neomake#makers#ft#go#gometalinter()
let g:neomake_go_full_exe = 'gometalinter'
let g:neomake_go_full_append_file = 0
let g:neomake_go_enabled_makers = ['go', 'fast']
let makeprg = 'full'

" https://github.com/fatih/dotfiles/blob/master/vimrc#L380
" create a go doc comment based on the word under the cursor
function! s:create_go_doc_comment()
  norm "zyiw
  execute ":put! z"
  execute ":norm I// \<Esc>$"
endfunction

au filetype go nmap <Leader>r <Plug>(go-run)
au filetype go nmap <Leader>rt <Plug>(go-run-tab)
au filetype go nmap <Leader>b <Plug>(go-build)
au filetype go nmap <Leader>t <Plug>(go-test)
au filetype go nmap <Leader>c <Plug>(go-coverage)
au filetype go nmap <Leader>cb <Plug>(go-coverage-browser)
au filetype go nmap <Leader>a <Plug>(go-alternate-edit)
au filetype go nmap <Leader>av <Plug>(go-alternate-vertical)
au filetype go nmap <Leader>i <Plug>(go-info)
au filetype go nmap <Leader>db <Plug>(go-doc-browser)
au filetype go nmap <Leader>d <Plug>(go-doc)
au filetype go nmap <Leader>j <Plug>(go-def)
au filetype go nmap <Leader>im <Plug>(go-implements)
au filetype go nmap <Leader>rn <Plug>(go-rename)
au filetype go nmap <Leader>f <Plug>(go-imports)
" au filetype go nmap <Leader>l <Plug>(go-metalinter)
au filetype go nnoremap <leader>ui :<C-u>call <SID>create_go_doc_comment()<CR>
