let g:ale_sign_column_always = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚡'
let g:ale_statusline_format = [g:ale_sign_error.' %d', g:ale_sign_warning.'%d', '✔']
let g:ale_echo_msg_error_str = 'err'
let g:ale_echo_msg_warning_str = 'warn'
let g:ale_echo_msg_format = '[%linter%] %severity%: %s'
