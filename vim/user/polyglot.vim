let g:polyglot_disabled = ['go', 'org', 'latex', 'tex', 'vue']
let g:vue_disable_pre_processors = 1

" Disable ctags generation by default
let g:gutentags_enabled = 0
let g:gutentags_dont_load = 0
augroup Gutentags
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

let g:neomake_error_sign = {'text': '✘', 'texthl': 'ALEErrorSign'}
let g:neomake_warning_sign = {'text': '‼', 'texthl': 'ALEWarningSign'}
let g:neomake_message_sign = {'text': '☛', 'texthl': 'ALEInfoSign'}
let g:neomake_info_sign = {'text': 'i', 'texthl': 'ALEInfoSign'}

" Neomake
" let g:neomake_serialize = 1
" augroup neomake_activate
    " autocmd! BufWritePost * Neomake
" augroup end

" JSON
let g:vim_json_syntax_conceal = 1
