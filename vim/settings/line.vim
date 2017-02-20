" lightline
let g:lightline = {
    \ 'mode_map': { 'c': 'NORMAL' },
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'filename'], ['fugitive','ale'] ]
    \ },
    \ 'component_function': {
    \   'modified': 'LightLineModified',
    \   'readonly': 'LightLineReadonly',
    \   'fugitive': 'LightLineFugitive',
    \   'filename': 'LightLineFilename',
    \   'fileformat': 'LightLineFileformat',
    \   'filetype': 'LightLineFiletype',
    \   'fileencoding': 'LightLineFileencoding',
    \   'mode': 'LightLineMode',
    \   'ale': 'LightLineALE',
    \ },
    \ 'subseparator': { 'left': '', 'right': '' },
    \ 'separator': { 'left': '', 'right': '' },
\ }

" ========================================== "

function! LightLineUseSeperators(line, sepL, sepR, subsepL, subsepR)
  let a:line.separator.left = a:sepL
  let a:line.separator.right = a:sepR
  let a:line.subseparator.left = a:subsepL
  let a:line.subseparator.right = a:subsepR
endfunction

function! LightLineUsePowerline()
  call LightLineUseSeperators(g:lightline, '', '', '', '')
  let g:lightline.colorscheme = 'jellybeans'
endfunction

call LightLineUseSeperators(g:lightline, '', '', '|', '|')
let g:lightline.colorscheme = 'neodark'

" ========================================== "

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction
function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction
function! LightLineFugitive()
  if &filetype !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction
function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fileencoding) ? &fenc : &enc) : ''
endfunction
function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
function! LightLineALE()
  return ALEGetStatusLine()
endfunction
