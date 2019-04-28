if !exists('g:loaded_neomake')
  finish
endif

" Neomake
cnoreabbrev Nm Neomake
cnoreabbrev Neomk Neomake
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

function! OnNeomakeJobFinished()
    let l:ctx = g:neomake_hook_context
    if l:ctx.jobinfo.exit_code != 0
        llist
    endif
endfunction
augroup neomake_hooks
    au!
    au User NeomakeJobFinished call OnNeomakeJobFinished()
    au BufWritePost * Neomake
augroup END

" let g:neomake_makeclean_maker = { 'exe': 'make', 'args': ['clean'], 'errorformat': '%f:%l:%c: %m' }
" let g:neomake_make_maker = { 'exe': 'make', 'errorformat': '%f:%l:%c: %m' }
" let g:neomake_proto_lint_maker = {
"     \ 'exe': 'protoc',
"     \ 'args': ['--lint_out=.'],
"     \ 'errorformat': '%f:%l:%c: %m',
"     \ }
" let g:neomake_proto_enabled_makers = ['lint']
" let g:neomake_javascript_enabled_makers = ['jscs', 'eslint']
" let g:neomake_css_fmt_maker = {
"     \ 'exe': 'css-beautify',
"     \ 'args': ['-r', '%:p', '--indent-size', '4']
"     \ }
" let g:neomake_css_enabled_makers = ['csslint', 'stylelint', 'fmt']

nmap <leader>l :Neomake<CR>
nmap <leader>L :Neomake! makeprg<CR>
nmap <leader>lt :NeomakeToggleBuffer<CR>
nmap <leader>ltt :NeomakeToggle<CR>

let g:lightline.component_function.neomake = 'LightLineNeomake'
function! LightLineNeomake()
  let l:msg = ''
  let l:msg .= neomake#statusline#get(bufnr('%'), {
    \ 'format_status_enabled': '[nmk %s]',
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
