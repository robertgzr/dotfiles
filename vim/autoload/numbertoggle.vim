function! s:relative_linenumbers()
  set number
  set relativenumber
endfunc

function! s:absolute_linenumbers()
  set number
  set norelativenumber
endfunc

function! numbertoggle#switch()
  if &relativenumber
    call s:absolute_linenumbers()
  else
    call s:relative_linenumbers()
  endif
endfunc
