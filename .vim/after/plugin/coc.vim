" coc json config -> ../../coc-settings.json
finish

if !exists('g:did_coc_loaded')
  finish
endif

set completeopt=noinsert,menuone,noselect
set completeopt-=preview
set shortmess+=c
" set showmatch

" let g:coc_auto_copen = 1
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" inoremap <silent><expr> <Tab>
"     \ pumvisible() ? "\<C-n>" :
"     \ <SID>check_back_space() ? "\<Tab>" :
"     \ coc#refresh()
inoremap <silent><expr> <Tab>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <C-Space> coc#refresh()

vmap <Tab> <Plug>(coc-snippets-select)

nmap <silent> [c <Plug>(coc-diagnostic-next)
nmap <silent> ]c <Plug>(coc-diagnostic-prev)
nmap <leader>lc :CocList diagnostics<CR>

imap <silent> <C-p> <Plug>(coc-complete-custom)
nmap <leader>d <Plug>(coc-definition)
nmap <leader>t <Plug>(coc-type-definition)
nmap <leader>i <Plug>(coc-implementation)
nmap <leader>r <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>qf <Plug>(coc-fix-current)
nmap <leader>ac <Plug>(coc-codeaction)

xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

xmap <leader>a <Plug>(coc-codeaction-current)
nmap <leader>a <Plug>(coc-codeaction-current)
nmap <leader>ac <Plug>(coc-codeaction)

nmap <Leader>o :CocList outline<CR>

function! s:show_doc()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h ' . expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nmap <Leader>i :silent! call <SID>show_doc()<CR>

au CursorHold * silent call CocActionAsync('highlight')

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
  return 'coc: ' . join(msgs, ' ')
endfunction
