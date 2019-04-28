let g:go_echo_go_info = 0
let g:go_auto_type_info = 0
" let g:go_info_mode = 'gocode'
" let g:go_auto_sameids = 1
" let g:go_gocode_unimported_packages = 0
" let g:go_list_type = 'quickfix'

let g:go_mod_fmt_autosave = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_fmt_experimental = 1 " solves https://github.com/fatih/vim-go/issues/502

" let g:go_term_enabled = 0
" let g:go_term_mode = 'split'

let g:go_metalinter_autosave = 0
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = '2s'

" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_interfaces = 1
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_types = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_space_tab_error = 1
" let g:go_highlight_array_whitespace_error = 1
" let g:go_highlight_trailing_whitespace_error = 1

" nnoremap <leader>r <Plug>(go-run)
" nnoremap <leader>rt <Plug>(go-run-tab)
" nnoremap <leader>b <Plug>(go-build)
" nnoremap <leader>t <Plug>(go-test)
" nnoremap <leader>c <Plug>(go-coverage)
" nnoremap <leader>cb <Plug>(go-coverage-browser)
" nnoremap <leader>a <Plug>(go-alternate-edit)
" nnoremap <leader>av <Plug>(go-alternate-vertical)
" nnoremap <leader>i <Plug>(go-info)
" nnoremap <leader>db <Plug>(go-doc-browser)
" nnoremap <leader>d <Plug>(go-doc)
" nnoremap <leader>j <Plug>(go-def)
" nnoremap <leader>im <Plug>(go-implements)
" nnoremap <leader>rn <Plug>(go-rename)
" nnoremap <leader>f <Plug>(go-imports)
" nnoremap <leader>l <Plug>(go-metalinter)

function! Alternate_go()
  call <Plug>(go-alternate-edit)
endfunction

" Golang support (via gotags)
let g:tagbar_type_go = {
  \ 'ctagstype': 'go',
  \ 'kinds'    : [
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
  \ 'kind2scope': {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
  \ },
  \ 'scope2kind': {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
  \ },
  \ 'ctagsbin' : 'gotags',
  \ 'ctagsargs' : '-sort -silent'
\ }

let g:vista_ctags_cmd = {'go': 'gotags -sort -silent'}
augroup go
  au!
  au VimEnter go call vista#RunForNearestMethodOrFunction()
augroup END

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
nnoremap <Leader>ui :<C-u>call <SID>create_go_doc_comment()<CR>

" let b:deoplete_disable_auto_complete = 0
" let g:neoformat_enabled_go = []
