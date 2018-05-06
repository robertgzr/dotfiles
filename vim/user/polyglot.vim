" Disable ctags generation by default
let g:gutentags_enabled = 0
let g:gutentags_dont_load = 1

" let g:polyglot_disabled = ['go']

" Language Server Protocol
let g:LanguageClient_serverCommands = {
\   'rust': ['rustup', 'run', 'nightly', 'rls'],
\   'go': ['go-langserver'],
\ }

" \   'c': ['/usr/local/opt/llvm/bin/clangd'],
" \   'cpp': ['/usr/local/opt/llvm/bin/clangd'],

let g:LanguageClient_diagnosticsDisplay = {
    \1: { 'name': 'Error','texthl': 'ALEError','signText': '✘','signTexthl': 'ALEErrorSign' },
    \2: { 'name': 'Warning','texthl': 'ALEWarning','signText': '‼','signTexthl': 'ALEWarningSign' },
    \3: { 'name': 'Information','texthl': 'ALEInfo','signText': 'i','signTexthl': 'ALEInfoSign' },
    \4: { 'name': 'Hint','texthl': 'ALEInfo','signText': '☛','signTexthl': 'ALEInfoSign' },
    \}

let g:neomake_error_sign = {'text': '✘', 'texthl': 'ALEErrorSign'}
let g:neomake_warning_sign = {'text': '‼', 'texthl': 'ALEWarningSign'}
let g:neomake_message_sign = {'text': '☛', 'texthl': 'ALEInfoSign'}
let g:neomake_info_sign = {'text': 'i', 'texthl': 'ALEInfoSign'}

let g:LanguageClient_autoStart = 1
nmap <Leader>i :call LanguageClient_textDocument_hover()<CR>
nmap <Leader>j :call LanguageClient_textDocument_definition()<CR>
nmap <Leader>r :call LanguageClient_textDocument_rename()<CR>

" Neomake 
" let g:neomake_serialize = 1
" augroup neomake_activate
    " autocmd! BufWritePost * Neomake
" augroup end

" JSON
let g:vim_json_syntax_conceal = 1
