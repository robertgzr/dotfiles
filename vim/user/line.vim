" turn off bufferline
let g:bufferline_echo = 0
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
" lightline
let g:lightline = {}
let g:lightline.enable = { 'statusline': 1, 'tabline': 1 }
let g:lightline.mode_map = { 'c': 'CMD' }
let g:lightline.active = {
\   'left': [
\       ['mode', 'paste'],
\       ['fugitive'],
\       ['filename', 'coc', 'ale', 'neomake', 'gutentags', 'obsession'],
\   ],
\   'right': [
\       ['lineinfo', 'percent'],
\       ['in_progress', 'tabstatus'],
\       ['fileformat', 'fileencoding', 'filetype'],
\   ]
\ }
let g:lightline.tabline = {
\   'left': [ ['bufferline'] ],
\   'right': [ ['close'] ],
\ }
let g:lightline.component = {
\   'lineinfo': ' '.'%l:%v',
\ }
let g:lightline.component_function = {
\   'modified': 'LightLineModified',
\   'readonly': 'LightLineReadonly',
\   'fugitive': 'LightLineFugitive',
\   'filename': 'LightLineFilename',
\   'fileformat': 'LightLineFileformat',
\   'filetype': 'LightLineFiletype',
\   'fileencoding': 'LightLineFileencoding',
\   'mode': 'LightLineMode',
\   'gutentags': 'LightLineGutentags',
\   'neomake': 'LightLineNeomake',
\   'obsession': 'LightLineSession',
\   'coc': 'LightLineCocStatus',
\ }
let g:lightline.component_expand = {
\   'tabstatus': 'LightLineTabStatus',
\   'ale': 'ALEGetStatusLine',
\   'bufferline': 'LightLineBufferline',
\ }
let g:lightline.component_type = {
\   'ale': 'error',
\   'bufferline': 'tabsel',
\ }
let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.tabline_subseparator = { 'left': '', 'right': '' }
" let g:lightline.tabline_separator = { 'left': '', 'right': '' }

" ========================================== "

function! LightLineUseSeperators(line, sepL, sepR, subsepL, subsepR)
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
  call LightLineUseSeperators(g:lightline, '', '', '', '')
endfunction
call LightLineUseSeperators(g:lightline, '', '', '|', '|')

function! LightLineModified()
  return &filetype =~? 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &filetype !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightLineFilename()
  return ('' !=? LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \  &filetype ==# 'unite' ? unite#get_status_string() :
        \  &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ '' !=? expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' !=? LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
if !exists('g:loaded_fugitive')
    return ''
endif
  if &filetype !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    let l:_ = fugitive#head()
    return strlen(l:_) ? ' '.l:_ : ''
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
  return winwidth(0) > 70 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? (
          \ expand('%:t') ==# '__Tagbar__' ? 'Tagbar':
          \ &filetype ==# 'vimfiler' ? 'VimFiler' :
          \ &filetype ==# 'vimshell' ? 'VimShell' :
          \ &filetype ==# 'dirvish' ? 'DIRVISH' :
          \ lightline#mode() )
          \ : ''
endfunction

function! LightLineTabStatus()
  return &tabstop
    \   . (&expandtab == 1 ? '->' : '<>')
    \   . &shiftwidth
endfunction

function! LightLineSession()
  let l:indicator = ObsessionStatus('active', 'paused')
  return l:indicator ? '[obsession:'.l:indicator.']' : ''
endfunction

function! LightLineNeomake()
  if !exists('g:loaded_neomake')
    return ''
  endif
  let l:msg = ''
  let l:msg .= neomake#statusline#get(bufnr('%'), {
    \ 'format_status_enabled': 'jobs: %s',
    \ 'format_running': '… ({{running_job_names}})',
    \ 'format_loclist_ok': '✔',
    \ 'format_loclist_issues': '',
    \ 'format_loclist_type_E': '✘ {{count}}',
    \ 'format_loclist_type_W': '‼ {{count}}',
    \ 'format_loclist_type_I': 'i {{count}}',
    \ 'format_quickfix_ok': '',
    \ 'format_quickfix_issues': '%s',
  \ })
  return l:msg
endfunction

function! s:get_gutentags_status(mods) abort
  let l:msg = ''
  if index(a:mods, 'ctags') > 0
     let l:msg .= '♨'
   endif
   if index(a:mods, 'cscope') > 0
     let l:msg .= '♺'
   endif
   return l:msg
endfunction

function! LightLineGutentags()
  if !exists('g:loaded_gutentags')
    return ''
  endif
  return gutentags#statusline_cb(function('<SID>get_gutentags_status'))
endfunction

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

function! LightLineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after ]
endfunction
