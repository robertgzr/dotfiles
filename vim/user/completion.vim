set completeopt=noinsert,menuone,noselect
set completeopt-=preview
set shortmess+=c
" set showmatch

" popup behavior
let g:neosnippet#enable_completed_snippet = 1
" let g:cm_sources_override = {
"     \ 'cm-gocode': {'enable':1}
" \ } 

inoremap <expr> <Tab> (pumvisible() ? "\<C-n>" : "\<Tab>")
inoremap <expr> <S-Tab> (pumvisible() ? "\<C-p>" : "\<S-Tab>")

inoremap <expr> <C-j> (pumvisible() ? "\<C-n>" : "\<C-j>")
inoremap <expr> <C-k> (pumvisible() ? "\<C-p>" : "\<C-k>")

" handle non-insert cases
smap <expr> <Tab> "\<Plug>(neosnippet_expand_or_jump)"
xmap <expr> <Tab> "\<Plug>(neosnippet_expand_target)"

inoremap <expr> <CR> (pumvisible() ? "\<C-y>\<CR>" : "\<CR>")

" completion window
augroup completion_window
    autocmd!
    " au InsertLeave * if pumvisible() == 0|pclose|endif
    " au CompleteDone * if pumvisible() == 0|pclose|endif
augroup END

" neosnippet
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-s>     <Plug>(neosnippet_expand_or_jump)
smap <C-s>     <Plug>(neosnippet_expand_or_jump)
xmap <C-s>     <Plug>(neosnippet_expand_target)
