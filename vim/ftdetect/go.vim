if exists('g:loaded_go')
  let g:go_echo_go_info = 1
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
  let g:go_highlight_types = 1
  let g:go_highlight_extra_types = 0
  let g:go_highlight_operators = 0
  let g:go_highlight_space_tab_error = 1
  let g:go_highlight_array_whitespace_error = 1
  let g:go_highlight_trailing_whitespace_error = 1

  nnoremap <Leader>r <Plug>(go-run)
  nnoremap <Leader>rt <Plug>(go-run-tab)
  nnoremap <Leader>b <Plug>(go-build)
  nnoremap <Leader>t <Plug>(go-test)
  nnoremap <Leader>c <Plug>(go-coverage)
  nnoremap <Leader>cb <Plug>(go-coverage-browser)
  nnoremap <Leader>a <Plug>(go-alternate-edit)
  nnoremap <Leader>av <Plug>(go-alternate-vertical)
  nnoremap <Leader>i <Plug>(go-info)
  nnoremap <Leader>db <Plug>(go-doc-browser)
  nnoremap <Leader>d <Plug>(go-doc)
  nnoremap <Leader>j <Plug>(go-def)
  nnoremap <Leader>im <Plug>(go-implements)
  nnoremap <Leader>rn <Plug>(go-rename)
  nnoremap <Leader>f <Plug>(go-imports)
  " nmap <Leader>l <Plug>(go-metalinter)

  function! Alternate_go()
    call <Plug>(go-alternate-edit)
  endfunction
endif

if exists('g:loaded_tagbar')
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
endif

if exists('g:loaded_neomake')
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
  let g:neomake_go_enabled_makers = ['fast']
  let makeprg = 'full'
endif

" https://github.com/fatih/dotfiles/blob/master/vimrc#L380
" create a go doc comment based on the word under the cursor
function! s:create_go_doc_comment()
  norm "zyiw
  execute ":put! z"
  execute ":norm I// \<Esc>$"
endfunction
nnoremap <leader>ui :<C-u>call <SID>create_go_doc_comment()<CR>

if exists('g:loaded_deoplete')
  let b:deoplete_disable_auto_complete = 0
endif

if exists('g:loaded_neoformat')
  let g:neoformat_enabled_go = []
endif

