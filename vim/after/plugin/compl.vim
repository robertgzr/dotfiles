" " completion window
" augroup completion_window
"     autocmd!
"     " au InsertLeave * if pumvisible() == 0|pclose|endif
"     " au CompleteDone * if pumvisible() == 0|pclose|endif
" augroup END

if exists('g:loaded_neosnippet')
  let g:neosnippet#enable_completed_snippet = 1
  " Note: It must be "imap" and "smap".
  imap <C-s>     <Plug>(neosnippet_expand_or_jump)
  smap <C-s>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-s>     <Plug>(neosnippet_expand_target)
endif
