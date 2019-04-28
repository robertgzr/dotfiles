set completeopt=noinsert,menuone,noselect
set completeopt-=preview
set shortmess+=c
" set showmatch

" let g:coc_auto_copen = 1

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [c <Plug>(coc-diagnostics-prev)
nmap <silent> ]c <Plug>(coc-diagnostics-next)

imap <silent> <C-p> <Plug>(coc-complete-custom)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>f <Plug>(coc-format-selected)
vmap <leader>f <Plug>(coc-format-selected)

nmap <leader>o :CocList outline<CR>
nmap <leader>i :silent! call CocActionAsync('doHover')<CR>
" au CursorHold * silent call CocActionAsync('doHover')

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)

let g:lightline.component_function.coc = 'LightLineCocStatus'
function! LightLineCocStatus()
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '✘ ' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, '‼ ' . info['warning'])
  endif
  return '[coc ' . join(msgs, ' ') . ']'
endfunction
