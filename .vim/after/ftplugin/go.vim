setlocal noexpandtab
setlocal shiftwidth=8
setlocal tabstop=8

let g:go_echo_go_info = 0
let g:go_auto_type_info = 0
" let g:go_info_mode = 'gocode'
" let g:go_auto_sameids = 1
" let g:go_gocode_unimported_packages = 0
" let g:go_list_type = 'quickfix'
let g:go_template_autocreate = 0

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

function! Alternate_go()
  call <Plug>(go-alternate-edit)
endfunction

" augroup go
"   au!
"   au VimEnter go call vista#RunForNearestMethodOrFunction()
" augroup END

if exists('g:loaded_neomake')
  let g:neomake_go_build_maker = {
  \ 'exe': 'go',
  \ 'args': 'build',
  \ 'append_file': 0,
  \ }
  " let g:neomake_go_golangci_lint_args = ['run', '--out-format=line-number', '--print-issued-lines=false']
  let g:neomake_go_enabled_makers = ['go', 'golangci_lint']
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
"

if exists('g:did_coc_loaded')
  augroup CoC
    au!
    au BufWritePre * CocCommand editor.action.organizeImport
  augroup END
endif
