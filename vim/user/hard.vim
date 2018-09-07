" hardmode == not using arrow keys

function! s:enable_hardmode(bang)
  if !a:bang
    try
      nmap <up> :echoerr 'use hjkl'<CR>
      nmap <down> :echoerr 'use hjkl'<CR>
      nmap <left> :echoerr 'use hjkl'<CR>
      nmap <right> :echoerr 'use hjkl'<CR>
      vmap <up> :echoerr 'use hjkl'<CR>
      vmap <down> :echoerr 'use hjkl'<CR>
      vmap <left> :echoerr 'use hjkl'<CR>
      vmap <right> :echoerr 'use hjkl'<CR>
      imap <up> <esc>:echoerr 'use hjkl'<CR>
      imap <down> <esc>:echoerr 'use hjkl'<CR>
      imap <left> <esc>:echoerr 'use hjkl'<CR>
      imap <right> <esc>:echoerr 'use hjkl'<CR>
    catch
    endtry
  else
    try
      nunmap <up>
      nunmap <down>
      nunmap <left>
      nunmap <right>
      vunmap <up>
      vunmap <down>
      vunmap <left>
      vunmap <right>
      iunmap <up>
      iunmap <down>
      iunmap <left>
      iunmap <right>
    catch
    endtry
  endif
endfunction

augroup Hardmode
  au VimEnter * call s:enable_hardmode(0)
  au VimEnter * command! -bang Hardmode call s:enable_hardmode(<bang>0)
augroup END
