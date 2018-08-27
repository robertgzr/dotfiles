set completeopt=noinsert,menuone,noselect
set completeopt-=preview
set shortmess+=c
" set showmatch

let g:coc_auto_copen = 0
let g:neosnippet#enable_completed_snippet = 1

" " completion window
" augroup completion_window
"     autocmd!
"     " au InsertLeave * if pumvisible() == 0|pclose|endif
"     " au CompleteDone * if pumvisible() == 0|pclose|endif
" augroup END

" neosnippet
" Note: It must be "imap" and "smap".
imap <C-s>     <Plug>(neosnippet_expand_or_jump)
smap <C-s>     <Plug>(neosnippet_expand_or_jump)
xmap <C-s>     <Plug>(neosnippet_expand_target)
