if !exists('g:loaded_obsession')
  finish
endif

let g:lightline.component_function.obsession = 'LightLineSession'

function! LightLineSession()
  let l:indicator = ObsessionStatus('active', 'paused')
  return l:indicator ? '[obs '.l:indicator.']' : ''
endfunction
