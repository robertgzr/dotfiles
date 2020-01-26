if !exists('g:loaded_bufferline')
  finish
endif

if !exists('g:lightline.tabline.left')
  let g:lightline.tabline.left = []
endif
let g:lightline.tabline.left += [['bufferline']]
let g:lightline.component_expand.bufferline = 'LightLineBufferline'
let g:lightline.component_type.bufferline = 'tabsel'

function! LightLineBufferline()
  call bufferline#refresh_status()
  let l:buffers = [
  \ g:bufferline_status_info.before,
  \ g:bufferline_status_info.current,
  \ g:bufferline_status_info.after
  \ ]

  function! s:fmt(key, val)
    let limit = 25
    if strlen(a:val) > limit
      return trim(a:val)[:limit] . '..'
    endif
    return trim(a:val)
  endfunction

  call map(l:buffers, function('s:fmt'))
  return l:buffers
endfunction
