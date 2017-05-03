let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!'
let g:ale_statusline_format = [g:ale_sign_error.' %d', g:ale_sign_warning.' %d', '✔']
let g:ale_echo_msg_error_str = 'err'
let g:ale_echo_msg_warning_str = 'warn'
let g:ale_echo_msg_format = '[%linter%] %severity%: %s'

let g:ale_open_list = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:airline#extensions#ale#enabled = 0
" let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1

nmap <C-k> <Plug>(ale_previous_wrap)
nmap <C-j> <Plug>(ale_next_wrap)

let g:ale_linters = {
\   'go':   ['go vet', 'golint', 'gofmt'],
\   'javascript': ['eslint'],
\ }
