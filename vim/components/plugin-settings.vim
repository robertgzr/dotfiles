" plugins - various options
" vim-session
"
let g:session_extension = '.vim-session'
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:session_autosave_periodic = 5
let g:session_command_aliases = 1
" fzf
"
let g:fzf_command_prefix = 'Fzf'
" vim-go
"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 1
" syntastic
"
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:syntastic_vhdl_checkers = ['ghdl']
" deoplete
"
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" tab complete
inoremap <silent><expr> <Leader><Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
" deoplete-go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#align_class = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
" deoplete-clang
let g:deoplete#sources#clang#libclang_path = "/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
let g:deoplete#sources#clang#clang_header = "/Library/Developer/CommandLineTools/usr/lib/clang"
" let g:deoplete#sources#clang#std
" let g:deoplete#sources#clang#flags
" neosnippet
"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "<Plug>(neosnippet_expand_or_jump)" : :\<TAB>"
" indent guides
"
let g:indent_guides_start_level=2
let g:indent_guides_auto_color=1
" let g:indent_guides_guide_size=2
" hi IndentGuidesOdd guibg=grey
" hi IndentGuidesEven guibg=darkgrey
" vim-markdown
"
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
" Limelight
"
let g:limelight_default_coefficient = 0.5
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1
" DISTRACTION FREE MODE FOR VIM
" autocmd! User GoyoEnter Limelight
" autocmd! User GoyoLeave Limelight!
" Goyo
"
augroup goyo_markdown
  autocmd!
  autocmd BufNewFile,BufRead * call s:auto_goyo()
augroup END
" Activate Goyo on Markdown
function! s:auto_goyo()
  if &ft == 'markdown'
    Goyo 80
  elseif exists('#goyo')
    let bufnr = bufnr('%')
    Goyo!
    execute 'b '.bufnr
  endif
endfunction
" NERDTree
"
" closes vim if last buffer is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" let g:NERDTreeDirArrowExpandable = '+'
" '▸'
" let g:NERDTreeDirArrowCollapsible = '-'
" '▾'
let NERDTreeIgnore = ['\.pyc$']
" VIM-HDL
let g:vimhdl_conf_file = ''
" Autoformat
let g:formatterpath = ['/usr/bin/tidy', '/usr/local/bin/js-beautify']
" gruvbox config
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_italicize_comments = 1
let g:gruvbox_invert_selection = 0
