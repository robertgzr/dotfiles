set completeopt=longest,menuone
set completeopt-=preview
set shortmess+=c
" set showmatch

" deoplete-clang
" let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
" let g:deoplete#sources#clang#clang_header = '/Library/Developer/CommandLineTools/usr/lib/clang'
" let g:deoplete#sources#clang#std
" let g:deoplete#sources#clang#flags

" deoplete options
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" disable autocomplete by default
let b:deoplete_disable_auto_complete=1
let g:deoplete_disable_auto_complete=1
" call deoplete#custom#buffer_option('auto_complete', v:false)

" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" set sources
" let g:deoplete#sources = {}
call deoplete#custom#source('LanguageClient', 'filetypes', ['c', 'cpp', 'rust', 'python', 'python3', 'go'])
call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)
call deoplete#custom#source('LanguageClient', 'rank', 10)
call deoplete#custom#source('buffer', 'rank', 9999)
" call deoplete#custom#source('buffer', 'filetype', '*')

" call deoplete#custom#source('Rust', 'filetype', '')
" call deoplete#custom#source('racer', 'filetype', '')
" call deoplete#custom#source('Go', 'filetype', '')


let g:deoplete#sources#jedi#python_path = '/usr/local/bin/python3'

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
