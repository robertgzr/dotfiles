let g:lightline = {}
let g:lightline.colorscheme = 'neodark'
let g:lightline.enable = { 'statusline': 1, 'tabline': 1 }
let g:lightline.mode_map = { 'c': 'CMD' }
let g:lightline.active = {
\   'left': [
\       ['mode', 'paste'],
\       ['filename'],
\       ['neomake', 'coc', 'ctags', 'obsession'],
\   ],
\   'right': [
\       ['filetype', 'fileencoding', 'fileformat'],
\       ['lineinfo', 'percent'],
\       ['vista', 'currentctag', 'tabstatus', 'dir'],
\   ]
\ }
let g:lightline.tabline = {
\   'left': [['bufferline']],
\   'right': [['tabs']],
\ }
let g:lightline.tab = {
\   'active': ['tabnum'], 'inactive': ['tabnum'] }

let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.tabline_subseparator = { 'left': '', 'right': '' }
" let g:lightline.tabline_separator = { 'left': '', 'right': '' }

let g:lightline.component = {
\   'lineinfo': ' '.'%l:%v',
\ }
let g:lightline.component_function = {
\   'modified': 'LightLineModified',
\   'readonly': 'LightLineReadonly',
\   'filename': 'LightLineFilename',
\   'fileformat': 'LightLineFileformat',
\   'filetype': 'LightLineFiletype',
\   'fileencoding': 'LightLineFileencoding',
\   'mode': 'LightLineMode',
\   'dir': 'LightLineDir',
\   'vista': 'NearestMethodOrFunction',
\ }
let g:lightline.component_expand = {
\   'tabstatus': 'LightLineTabchar',
\ }
let g:lightline.component_type = {}

" UseSeparators {{{
function! LightLineUseSeparators(line, sepL, sepR, subsepL, subsepR)
  let a:line.separator.left = a:sepL
  let a:line.separator.right = a:sepR
  let a:line.subseparator.left = a:subsepL
  let a:line.subseparator.right = a:subsepR
  " let a:line.tabline_separator.left = a:sepL
  " let a:line.tabline_separator.right = a:sepR
  " let a:line.tabline_subseparator.left = a:subsepL
  " let a:line.tabline_subseparator.right = a:subsepR
endfunction

function! LightLineUsePowerline()
  call LightLineUseSeparators(g:lightline, '', '', '', '')
endfunction
call LightLineUseSeparators(g:lightline, '', '', '', '')
" }}}

" Modified {{{
function! LightLineModified()
  return &filetype =~? 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
" }}}

" Readonly {{{
function! LightLineReadonly()
  return &filetype !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction
" }}}

" Filename {{{
function! LightLineFilename()
  return ('' !=? LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \  &filetype ==# 'unite' ? unite#get_status_string() :
        \  &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ '' !=? expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' !=? LightLineModified() ? ' ' . LightLineModified() : '')
endfunction
" }}}

" Fileformat {{{
function! LightLineFileformat()
  if (&fileformat == 'unix')
    return ''
  endif
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
" }}}

" Filetype {{{
function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
" }}}

" Fileencoding {{{
function! LightLineFileencoding()
  if (&fileencoding == 'utf-8')
    return ''
  endif
  return winwidth(0) > 70 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction
" }}}

" Mode {{{
function! LightLineMode()
  return winwidth(0) > 60 ? (
          \ expand('%:t') ==# '__Tagbar__' ? 'Tagbar':
          \ &filetype ==# 'vimfiler' ? 'VimFiler' :
          \ &filetype ==# 'vimshell' ? 'VimShell' :
          \ &filetype ==# 'dirvish' ? 'DIRVISH' :
          \ lightline#mode() )
          \ : ''
endfunction
" }}}

" Tabchar {{{
function! LightLineTabchar()
  return '[' 
    \   . &tabstop
    \   . (&expandtab == 1 ? '->' : '<>')
    \   . &shiftwidth
    \ . ']'
endfunction
" }}}

" Dir {{{
function! LightLineDir()
  if empty(&buftype)
    return substitute(getcwd(), $HOME, '~', '')
  endif
  return &buftype
endfunction
" }}}
