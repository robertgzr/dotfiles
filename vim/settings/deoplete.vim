let g:deoplete#enable_at_startup = 1

let g:deoplete#disable_auto_complete = 0
let g:deoplete#enable_smart_case = 1

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

" deoplete-go
let g:deoplete#sources#go#gocode_binary = '' " $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#package_dot = 0
let g:deoplete#sources#go#pointer = 1
let g:deoplete#sources#go#sort_class = [] " ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 0
let g:deoplete#sources#go#json_directory = '' "$HOME.'/.cache/deoplete/go/'.$GOOS.'_'.$GOARCH
let g:deoplete#sources#go#align_class = 1
let g:deoplete#sources#go#cgo = 0
let g:deoplete#sources#go#goos = ''

" deoplete-rust
let g:deoplete#sources#rust#racer_binary = $HOME.'/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path = $RUST_SRC_DIR
let g:deoplete#sources#rust#disable_keymap = 1
let g:deoplete#sources#rust#documentation_max_height = 20

" deoplete-clang
let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/Library/Developer/CommandLineTools/usr/lib/clang'
" let g:deoplete#sources#clang#std
" let g:deoplete#sources#clang#flags

" deoplete-latex
let g:deoplete#omni#input_patterns.tex =
            \   '\\(?:'
            \  .   '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
            \  .  '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
            \  .  '|hyperref\s*\[[^]]*'
            \  .  '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \  .  '|(?:include(?:only)?|input)\s*\{[^}]*'
            \  .')'
