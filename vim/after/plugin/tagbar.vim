if !exists('g:tagbar_loaded')
  finish
endif

" tagbar config
let g:tagbar_autoclose = 0

" auto commands
augroup Tagbar
  au!
  au VimEnter * nested :call tagbar#autoopen(0)
  au BufEnter * nested :call tagbar#autoopen(0)
augroup END

" binds
nmap <silent> <leader>tb :TagbarOpen fj<CR>

" lightline integration
let g:lightline.component.currentctag = '%{tagbar#currenttag("[tag %s]", "")}'
