let g:racer_cmd = $HOME.'/.cargo/bin/racer'

" deoplete-rust
let g:deoplete#sources#rust#racer_binary = $HOME.'/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path = $RUST_SRC_DIR
let g:deoplete#sources#rust#disable_keymap = 1
let g:deoplete#sources#rust#documentation_max_height = 20

let g:neomake_rust_rustfmt_maker = {
\   'exe': 'rustfmt',
\   'args': ['--write-mode=overwrite'],
\   'append_file': 1,
\   'cwd': '%:h',
\ }
" '--skip-children'],
let g:neomake_rust_enabled_makers = ['cargo']

call lexima#add_rule({'filetype': ['rust'], 'char': "'", 'at': '<\%# | &\%#'})
nmap <Leader>d <Plug>(rust-doc)
nmap <Leader>j <Plug>(rust-def)
