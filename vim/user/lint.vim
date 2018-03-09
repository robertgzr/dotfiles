" using Neomake
cnoreabbrev Nm Neomake
cnoreabbrev Neomk Neomake
" call neomake#configure#automake({
" \   'TextChanged': {},
" \   'InsertLeave': {},
" \   'BufWritePost': {'delay': 0},
" \   'BufWinEnter': {},
" \ }, 500)
let g:neomake_error_sign = {'text': '✘', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '‼', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '☛', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': 'i', 'texthl': 'NeomakeInfoSign'}

let g:neomake_highlight_columns = 1
let g:neomake_highlight_lines = 1
let g:neomake_open_list = 0

function! OnNeomakeJobFinished()
    " let l:ctx = g:neomake_hook_context
    " if l:ctx.jobinfo.exit_code != 0
    "     llist
    " endif
endfunction

augroup neomake_hooks
    au!
    " au User NeomakeJobFinished call OnNeomakeJobFinished()
augroup END

" (Neo)makers

let g:neomake_go_fast_maker = {
\   'exe': 'gometalinter',
\   'args': ['--vendor', '--fast'],
\   'append_file': 0,
\   'cwd': '%:h',
\   'errorformat': '%f:%l:%c:%t%*[^:]: %m',
\ }
let g:neomake_go_full_maker = g:neomake#makers#ft#go#gometalinter()
let g:neomake_go_full_exe = 'gometalinter'
let g:neomake_go_full_append_file = 0
let g:neomake_go_enabled_makers = ['go', 'fast']

let g:neomake_rust_rustfmt_maker = {
\   'exe': 'rustfmt',
\   'args': ['--write-mode=overwrite'],
\   'append_file': 1,
\   'cwd': '%:h',
\ }
" '--skip-children'],
let g:neomake_rust_enabled_makers = ['cargo']

let g:neomake_makeclean_maker = { 'exe': 'make', 'args': ['clean'] }

let g:neomake_proto_lint_maker = {
    \ 'exe': 'protoc',
    \ 'args': ['--lint_out=.'],
    \ 'errorformat': '%f:%l:%c: %m',
    \ }
let g:neomake_proto_enabled_makers = ['lint']

let g:neomake_javascript_enabled_makers = ['jscs', 'eslint']
let g:neomake_css_fmt_maker = {
    \ 'exe': 'css-beautify',
    \ 'args': ['-r', '%:p', '--indent-size', '4']
    \ }
let g:neomake_css_enabled_makers = ['csslint', 'stylelint', 'fmt']

" using ALE
let g:ale_sign_column_always = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!'
let g:ale_statusline_format = [g:ale_sign_error.' %d', g:ale_sign_warning.' %d', '✔']
let g:ale_echo_msg_error_str = 'err'
let g:ale_echo_msg_warning_str = 'warn'
let g:ale_echo_msg_format = '[%linter%] %severity%: %s'

let g:ale_open_list = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_set_signs = 1
let g:ale_echo_cursor = 1

let g:ale_lint_delay = 200

let g:airline#extensions#ale#enabled = 0

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0

nmap <C-k> <Plug>(ale_previous_wrap)
nmap <C-j> <Plug>(ale_next_wrap)
nmap <C-a>d <Plug>(ale_detail)

let g:ale_linters = {
\   'go':   ['go vet', 'golint', 'gotype'],
\   'rust': ['rustc', 'cargo', 'rls'],
\ }

let g:ale_c_gcc_options = '-std=c99 -Wall'
