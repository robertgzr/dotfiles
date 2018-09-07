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
let g:user_emmet_leader_key = '<C-x>' " followed by ,
let g:user_emmet_mode = 'a'

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

" Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
