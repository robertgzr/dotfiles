let g:session_extension = ".vim-session"
let g:session_autosave = "no"
let g:session_autoload = "no"
let g:session_autosave_periodic = 5
let g:session_command_aliases = 1

let g:echodoc_enable_at_startup = 1
" let g:tagbar_autoclose = 1

" matchtagalways
let g:mta_use_matchparen_group = 1
let g:mta_filetypes = {
    \ 'html'  : 1,
    \ 'xhtml' : 1,
    \ 'xml'   : 1,
    \ 'jinja' : 1,
    \ 'vue'   : 1
\}
" emmet
let g:user_emmet_leader_key = g:maplocalleader " followed by ,
" let g:user_emmet_mode = 'a'

" Autoformat
" let g:formatterpath = [ '/usr/bin', '/usr/local/bin' ]
" let g:autoformat_autoindent = 0
" let g:autoformat_retab = 0
" let g:autoformat_remove_trailing_spaces = 0

" Neoformat
" let g:neoformat_try_formatprg = 1
" let g:neoformat_only_msg_on_error = 1
" let g:neoformat_basic_format_align = 0
" let g:neoformat_basic_format_retab = 1
" let g:neoformat_basic_format_trim = 1

" indentguides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_color_change_percent = 2
" indentline
" let g:indentline_setColors = 0
" let g:indentLine_color_color_term = 239
" let g:indentLine_color_color_gui = '#333333'
" let g:indentLine_color_color_dark = 1
" let g:indentLine_char = '┊'
" let g:indentLine_char = '.'

" gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_override_sign_column_highlight = 0

let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▎'
let g:gitgutter_sign_removed_first_line = '▀'
let g:gitgutter_sign_modified_removed = '▎'

" FZF
" let g:fzf_command_prefix = 'Fzf'
let g:fzf_buffers_jump = 1
let g:fzf_action = {
    \ 'ctrl-q': 'bdelete',
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }

" fzf + ripgrep => :Rg
" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
function! s:rg_find(args, bang)
    let l:exe = 'rg'
    \.  ' --column'
    \.  ' --line-number'
    \.  ' --no-heading'
    \.  ' --fixed-strings'
    \.  ' --ignore-case'
    \.  ' --no-ignore'
    \.  ' --hidden'
    \.  ' --follow'
    \.  ' --glob "!.git/*"'
    \.  ' --color "always"'
    \.  ' '.shellescape(a:args)

    call fzf#vim#grep(l:exe, 1,
    \ a:bang ? fzf#vim#with_preview('up:60%')
    \         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \ a:bang)
endfunction
augroup Rg
    au!
    au VimEnter * command! -nargs=* -bang Rg call s:rg_find(<q-args>, <bang>0)
augroup END

let g:polyglot_disabled = ['go', 'org', 'latex', 'tex', 'vue']
let g:vue_disable_pre_processors = 1
let g:vim_json_syntax_conceal = 1

" Disable ctags generation by default
let g:gutentags_enabled = 0
let g:gutentags_dont_load = 0
augroup Gutentags
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

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
    " au User NeomakeJobFinished call OnNeomakeJobFinished()
    " au BufWritePost * Neomake
augroup END

" (Neo)makers
let g:neomake_makeclean_maker = { 'exe': 'make', 'args': ['clean'], 'errorformat': '%f:%l:%c: %m' }
let g:neomake_make_maker = { 'exe': 'make', 'errorformat': '%f:%l:%c: %m' }
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

" ALE
" let g:ale_sign_column_always = 0
" let g:ale_sign_error = '✘'
" let g:ale_sign_warning = '‼'
" let g:ale_statusline_format = [g:ale_sign_error.' %d', g:ale_sign_warning.' %d', '✔']
" let g:ale_echo_msg_error_str = 'err'
" let g:ale_echo_msg_warning_str = 'warn'
" let g:ale_echo_msg_format = '[%linter%] %severity%: %s'
" let g:ale_open_list = 0
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
" let g:ale_set_signs = 1
" let g:ale_echo_cursor = 1
" let g:ale_lint_delay = 200
" let g:airline#extensions#ale#enabled = 0
" " let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_enter = 1
" nmap <C-k> <Plug>(ale_previous_wrap)
" nmap <C-j> <Plug>(ale_next_wrap)
" nmap <C-a>d <Plug>(ale_detail)
" let g:ale_linters = {
" \   'go':   ['go vet', 'golint', 'gotype'],
" \   'rust': ['rustc', 'cargo', 'rls'],
" \ }
" let g:ale_c_gcc_options = '-std=c99 -Wall'

" Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" orgmode
let g:org_todo_keywords = ['TODO', 'WIP', 'DONE', 'FEEDBACK']
let g:org_agenda_files = [ '~/org' ]

let g:utl_cfg_hdl_scm_http = 'silent !xdg-open %u'

let g:sneak#label = 1
