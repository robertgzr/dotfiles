let g:racer_cmd = $HOME.'/.cargo/bin/racer'

setlocal tags='./rusty-tags.vi/'
" let g:gutentags_enabled = 0
" let g:gutentags_define_advanced_commands = 1
" let g:gutentags_ctags_executable_rust = 'rusty-tags'
" let g:gutentags_ctags_extra_args = ['--omit-deps', 'vi']
" let g:gutentags_ctags_tagfile = 'rusty-tags.vi'

if exists('g:loaded_neomake')
    let g:neomake_rust_rustfmt_maker = {
    \   'exe': 'rustfmt',
    \   'args': ['--write-mode=overwrite'],
    \   'append_file': 1,
    \   'cwd': '%:h',
    \ }
    " '--skip-children'],
    let g:neomake_rust_enabled_makers = []
endif

if exists('g:loaded_lexima')
    call lexima#add_rule({'filetype': ['rust'], 'char': "'", 'at': '<\%# | &\%#'})
endif

" nmap <Leader>d <Plug>(rust-doc)
" nmap <Leader>j <Plug>(rust-def)
