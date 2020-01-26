" hardmode == not using arrow keys

function! s:bail()
    let l:msg = 'E0X: Use hjkl'
    echohl ErrorMsg | echo l:msg | echohl None
endfunction

function! s:enable_hardmode(bang)
  if !a:bang
    try
      " map arrow keys to more useful actions
      " https://coderoncode.com/posts/vim-is-the-perfect-ide
      nmap r<up> :resize +2<CR>
      nmap r<down> :resize -2<CR>
      nmap r<left> :vertical resize +2<CR>
      nmap r<right> :vertical resize +2<CR>

      nmap w<up> :wincmd k<CR>
      nmap w<down> :wincmd j<CR>
      nmap w<left> :wincmd h<CR>
      nmap w<right> :wincmd l<CR>

      nmap wm<up> :wincmd K<CR>
      nmap wm<down> :wincmd J<CR>
      nmap wm<left> :wincmd H<CR>
      nmap wm<right> :wincmd L<CR>

      " or bail on them altogether
      nmap <up> :call <SID>bail()<CR>
      nmap <down> :call <SID>bail()<CR>
      nmap <left> :call <SID>bail()<CR>
      nmap <right> :call <SID>bail()<CR>

      vmap <up> :call <SID>bail()<CR>
      vmap <down> :call <SID>bail()<CR>
      vmap <left> :call <SID>bail()<CR>
      vmap <right> :call <SID>bail()<CR>

      imap <up> <esc>:call <SID>bail()<CR>
      imap <down> <esc>:call <SID>bail()<CR>
      imap <left> <esc>:call <SID>bail()<CR>
      imap <right> <esc>:call <SID>bail()<CR>
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

call s:enable_hardmode(0)
command! -bang Hardmode call s:enable_hardmode(<bang>0)
