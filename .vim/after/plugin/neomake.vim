if !exists('g:loaded_neomake')
  finish
endif

" Neomake
cnoreabbrev neom Neomake
cnoreabbrev nm Neomake
call neomake#configure#automake('w')

" \ 'BufWritePost': {'delay': 0},
let g:neomake_error_sign = {'text': '✘', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '‼', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '☛', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': 'i', 'texthl': 'NeomakeInfoSign'}
" let g:neomake_error_sign = {'text': '✘', 'texthl': 'ALEErrorSign'}
" let g:neomake_warning_sign = {'text': '‼', 'texthl': 'ALEWarningSign'}
" let g:neomake_message_sign = {'text': '☛', 'texthl': 'ALEInfoSign'}
" let g:neomake_info_sign = {'text': 'i', 'texthl': 'ALEInfoSign'}
" let g:neomake_serialize = 1

let g:neomake_highlight_columns = 1
let g:neomake_highlight_lines = 1
let g:neomake_open_list = 0

" function! OnNeomakeJobFinished()
"   let l:ctx = g:neomake_hook_context
"   if l:ctx.jobinfo.exit_code != 0
"     echoerr l:ctx.jobinfo.maker.name . ' failed'
"   endif
" endfunction
augroup neomake_hooks
  au!
  " au User NeomakeJobFinished call OnNeomakeJobFinished()
  au BufWritePost * Neomake
augroup END

" generic makers
let g:neomake_makeclean_maker = { 'exe': 'make', 'args': ['clean'], 'errorformat': '%f:%l:%c: %m' }
let g:neomake_make_maker = { 'exe': 'make', 'errorformat': '%f:%l:%c: %m' }

nmap <leader>nm :Neomake<space>

let g:lightline.component_function.neomake = 'LightLineNeomake'
function! LightLineNeomake()
  let l:msg = neomake#statusline#get(bufnr('%'), {
    \ 'format_status_disabled': '{{disabled_info}} %s',
    \ 'format_status_enabled': '%s',
    \ 'format_running': '… {{running_job_names}}',
    \ 'format_loclist_ok': ' ✔',
    \ 'format_loclist_issues': '%s',
    \ 'format_loclist_unknown': '',
    \ 'format_loclist_type_E': ' ✘ {{count}}',
    \ 'format_loclist_type_W': ' ‼ {{count}}',
    \ 'format_loclist_type_I': ' i {{count}}',
    \ 'format_quickfix_type_E': '✘ {{count}}',
    \ 'format_quickfix_type_W': '‼ {{count}}',
    \ 'format_quickfix_type_I': 'i {{count}}',
  \ })
  return l:msg ? 'nm:'.l:msg : ''
endfunction
