setlocal foldlevel=1

if exists('g:loaded_lexima')
  let g:lexima_enable_space_rules=0
endif

function! s:markdown_underline(bang)
  call append(line('.'), substitute(getline('.'), '.', (a:bang ? '-' : '='), 'g'))
endfunction
command! -nargs=0 -bang Underline call s:markdown_underline(<bang>0)

if exists('g:loaded_neomake')
  let g:neomake_markdown_shiba_maker = {
  \   'exe': 'shiba',
  \   'args': ['--detach', '%:p'],
  \   'append_file': 0,
  \ }
  let g:neomake_markdown_enabled_makers = []
endif

augroup Markdown
  au!
  " au FileType markdown NeomakeDisableBuffer

  " Make vim-markdown-folding ignore frontmatter blocks
  au BufNewFile,BufRead markdown syntax match Comment /\%^---\_.\{-}---$/
augroup END
