let b:deoplete_disable_auto_complete = 0

let g:racer_cmd = $HOME.'/.cargo/bin/racer'

setlocal tags='./rusty-tags.vi/'
" let g:gutentags_enabled = 0
" let g:gutentags_define_advanced_commands = 1
" let g:gutentags_ctags_executable_rust = 'rusty-tags'
" let g:gutentags_ctags_extra_args = ['--omit-deps', 'vi']
" let g:gutentags_ctags_tagfile = 'rusty-tags.vi'

" deoplete-rust
" let g:deoplete#sources#rust#racer_binary = $HOME.'/.cargo/bin/racer'
" let g:deoplete#sources#rust#rust_source_path = $RUST_SRC_DIR
" let g:deoplete#sources#rust#disable_keymap = 1
" let g:deoplete#sources#rust#documentation_max_height = 20

let g:neomake_rust_rustfmt_maker = {
\   'exe': 'rustfmt',
\   'args': ['--write-mode=overwrite'],
\   'append_file': 1,
\   'cwd': '%:h',
\ }
" '--skip-children'],
let g:neomake_rust_enabled_makers = []

call lexima#add_rule({'filetype': ['rust'], 'char': "'", 'at': '<\%# | &\%#'})

" nmap <Leader>d <Plug>(rust-doc)
" nmap <Leader>j <Plug>(rust-def)
