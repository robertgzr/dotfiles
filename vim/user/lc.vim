" Language Server Client stuff
let g:LanguageClient_serverCommands = {
\   'rust': ['rustup', 'run', 'nightly', 'rls'],
\   'go': ['go-langserver'],
\   'c': ['/usr/local/opt/llvm/bin/clangd'],
\   'cpp': ['/usr/local/opt/llvm/bin/clangd'],
\ }
" \   'javascript': ['/usr/local/bin/javascript-typescript-langserver'],
" \   'javascript.jsx': ['/usr/local/bin/javascript-typescript-langserver'],
" \   'typescript': ['/usr/local/bin/javascript-typescript-langserver'],
let g:LanguageClient_autoStart = 1
let g:LanguageClient_rootMarkers = {
\   'go': ['go.mod', 'main.go'],
\   'rust': ['Cargo.toml'],
\   'c': ['compile_commands.json'],
\   'cpp': ['compile_commands.json'],
\   'javascript': ['package.json'],
\   'javascript.jsx': ['package.json'],
\   'typescript': ['package.json'],
\ }
let g:LanguageClient_diagnosticsDisplay = {
    \1: { 'name': 'Error','texthl': 'ALEError','signText': '✘','signTexthl': 'ALEErrorSign' },
    \2: { 'name': 'Warning','texthl': 'ALEWarning','signText': '‼','signTexthl': 'ALEWarningSign' },
    \3: { 'name': 'Information','texthl': 'ALEInfo','signText': 'i','signTexthl': 'ALEInfoSign' },
    \4: { 'name': 'Hint','texthl': 'ALEInfo','signText': '☛','signTexthl': 'ALEInfoSign' },
\ }

set completefunc=LanguageClient#complete
set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
