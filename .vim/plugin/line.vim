let g:lightline = {}

let g:lightline.enable = { 'statusline': 1, 'tabline': 0 }

let g:lightline.mode_map = {
\   'n' : 'N',
\   'i' : 'I',
\   'R' : 'R',
\   'v' : 'V',
\   'V' : 'V-LINE',
\   "\<C-v>": 'V-BLOCK',
\   'c' : '>',
\   's' : 'SELECT',
\   'S' : 'S-LINE',
\   "\<C-s>": 'S-BLOCK',
\   't': 'T',
\ }

let g:lightline.active = {
\   'left': [
\       ['mode', 'paste'],
\       ['filename', 'vista'],
\       ['neomake', 'coc', 'ctags', 'obsession'],
\   ],
\   'right': [
\       ['filetype', 'fileencoding', 'fileformat'],
\       ['indent', 'bufnum', 'lineinfo', 'percent'],
\   ],
\ }

set showtabline=0
let g:bufferline_echo = 0
let g:bufferline_show_bufnr = 0
" let g:bufferline_separator = ' '
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
" let g:bufferline_unamed_buffer = '[no name]'
let g:bufferline_fname_mod = ':t:s?^$?[no name]?'
let g:lightline.tabline = {
\   'right': [
\       ['tabs'],
\       ['porcelain'],
\   ],
\ }
let g:lightline.tab = {
\   'active': ['tabnum'],
\   'inactive': ['tabnum'],
\ }

let g:lightline.component = {
\   'lineinfo': ' %l:%v',
\   'filetype': "%{winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''}",
\   'dir': "%{substitute(expand('%:p:h'), $HOME, '~', '')}",
\ }

let g:lightline.component_function = {
\   'filename': 'LightLineFilename',
\   'bufnum': 'LightLineBufnum',
\   'fileformat': 'LightLineFileformat',
\   'fileencoding': 'LightLineFileencoding',
\   'mode': 'LightLineMode',
\   'vista': 'LightLineVista',
\   'o': 'LightLineO',
\   'porcelain': 'LightLinePorcelain',
\   'indent': 'LightLineIndent',
\ }

" \ 'separator': { 'left': "\ue0b8", 'right': "\ue0be" },
" \ 'subseparator': { 'left': "\ue0b9", 'right': "\ue0b9" },
" \ 'tabline_separator': { 'left': "\ue0bc", 'right': "\ue0ba" },
" \ 'tabline_subseparator': { 'left': "\ue0bb", 'right': "\ue0bb" },
" \

let g:lightline.component_expand = {}
let g:lightline.component_type = {}


" Modified {{{
hi ModifiedColor ctermfg=196 guifg=#ff0000 gui=bold
function! LightLineModified()
  return &modified ? '+' : &modifiable ? '' : '-'
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

" Bufnum {{{
function! LightLineBufnum()
  let l:nbufs = len(getbufinfo({'buflisted':1}))
  return '% '. bufnr('%') . '('.l:nbufs.')' . (tabpagenr() != 1 ? ':'. tabpagenr() : '')
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

" Indent {{{
function! LightLineIndent()
  return '' .
       \ (&expandtab == 1 ? '␣' : '→') . ' ' .
       \ 'ts=' . &tabstop .
       \ ' ' .
       \ 'sw=' . &shiftwidth
endfunction
" }}}

" Vista {{{
function! LightLineVista()
  let l:sym = get(b:, 'vista_nearest_method_or_function', '')
  return empty(l:sym) ? '' : g:vista#renderer#icons.function . ' ' . l:sym
endfunction
" }}}

" Porcelain {{{
function! LightLinePorcelain()
  if &buftype !=# 'terminal'
    let gitinfo = system('porcelain -no-color -path=' . expand('%:h'))
    return (v:shell_error ? '' : gitinfo)
  endif
endfunction
" }}}

function! LightLineO()
  let l:circ_empty="\u25CB"
  let l:circ_quart="\u25D4"
  let l:circ_half="\u25D1"
  let l:circ_threequart="\u25D5"
  let l:circ_full="\u25CF"
  return ('' != LightLineModified() ? l:circ_full : l:circ_empty)
endfunction
