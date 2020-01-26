set tags='./rusty-tags.vi/'

if exists('g:loaded_lexima')
    call lexima#add_rule({'filetype': ['rust'], 'char': "'", 'at': '<\%# | &\%#'})
endif

let g:racer_cmd = $HOME.'/.cargo/bin/racer'

" let g:gutentags_enabled = 0
" let g:gutentags_define_advanced_commands = 1
" let g:gutentags_ctags_executable_rust = 'rusty-tags'
" let g:gutentags_ctags_extra_args = ['--omit-deps', 'vi']
" let g:gutentags_ctags_tagfile = 'rusty-tags.vi'

" when using standard ctags
let g:tagbar_type_rust = {
            \ 'ctagstype' : 'rust',
            \ 'kinds' : [
            \'T:types,type definitions',
            \'f:functions,function definitions',
            \'g:enum,enumeration names',
            \'s:structure names',
            \'m:modules,module names',
            \'c:consts,static constants',
            \'t:traits',
            \'i:impls,trait implementations',
            \]
            \}

" when using universal-ctags
" let g:rust_use_custom_ctags_defs = 1  " if using rust.vim
" let g:tagbar_type_rust = {
"   \ 'ctagstype' : 'rust',
"   \ 'kinds' : [
"       \ 'n:modules',
"       \ 's:structures:1',
"       \ 'i:interfaces',
"       \ 'c:implementations',
"       \ 'f:functions:1',
"       \ 'g:enumerations:1',
"       \ 't:type aliases:1:0',
"       \ 'v:constants:1:0',
"       \ 'M:macros:1',
"       \ 'm:fields:1:0',
"       \ 'e:enum variants:1:0',
"       \ 'P:methods:1',
"   \ ],
"   \ 'sro': '::',
"   \ 'kind2scope' : {
"       \ 'n': 'module',
"       \ 's': 'struct',
"       \ 'i': 'interface',
"       \ 'c': 'implementation',
"       \ 'f': 'function',
"       \ 'g': 'enum',
"       \ 't': 'typedef',
"       \ 'v': 'variable',
"       \ 'M': 'macro',
"       \ 'm': 'field',
"       \ 'e': 'enumerator',
"       \ 'P': 'method',
"   \ },
" \ }

let g:neomake_rust_enabled_makers = ['cargo']

" augroup rust
"     au!
" augroup END

" nmap <Leader>d <Plug>(rust-doc)
" nmap <Leader>j <Plug>(rust-def)
