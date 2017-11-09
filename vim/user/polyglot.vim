"" Language options

" Language Server Protocol
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
\ }

    " \ 'go': ['go-langserver'],

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
augroup filetype_make
    autocmd!
    " Disable tabs->spaces for Makefiles
    au FileType make setlocal noexpandtab
augroup END
