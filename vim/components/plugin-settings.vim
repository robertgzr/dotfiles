" plugins - various options
let g:NumberToggleTrigger = "<Leader>ln"
" vim-session
"
let g:session_extension = ".vim-session"
let g:session_autosave = "no"
let g:session_autoload = "no"
let g:session_autosave_periodic = 5
let g:session_command_aliases = 1
" MatchTagsAlways
let g:mta_use_matchparen_group = 1
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'vue': 1 
    \}

" fzf
"
let g:fzf_command_prefix = "Fzf"
" vim-go
"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 1
let g:go_fmt_experimental = 1
let g:go_term_enabled = 1
let g:go_list_type = "quickfix"
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"
" syntastic
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_go_checkers = ['govet', 'gofmt', 'go']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_vhdl_checkers = ['ghdl']
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': [] }
"
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 0
let g:deoplete#enable_smart_case = 1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd CompleteDone * if pumvisible() == 0|pclose|endif

" deoplete-go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#package_dot = 1
let g:deoplete#sources#go#pointer = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/$GOOS_$GOARCH'
let g:deoplete#sources#go#align_class = 1
" deoplete-clang
let g:deoplete#sources#clang#libclang_path = "/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
let g:deoplete#sources#clang#clang_header = "/Library/Developer/CommandLineTools/usr/lib/clang"
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
" neosnippet
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_completed_snippet = 1
"
" indent guides
let g:indent_guides_start_level=2
let g:indent_guides_auto_color=1
" let g:indent_guides_guide_size=2
" hi IndentGuidesOdd guibg=grey
" hi IndentGuidesEven guibg=darkgrey
"
" indentline config
" let g:indentLine_color_color_term = 239
" let g:indentLine_color_color_gui = '#333333'
" let g:indentLine_color_color_dark = 1
let g:indentLine_char = '┊'
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
" autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
" let g:NERDTreeDirArrowExpandable = '+'
" let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapOpenSplit = 'x'
let g:NERDTreeMapCloseChildren = 'I'
let g:NERDTreeMapCloseDir = 'i'
let g:NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "Δ",
    \ "Staged"    : "+",
    \ "Untracked" : "?",
    \ "Renamed"   : "▷",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "†",
    \ "Dirty"     : "✘",
    \ "Clean"     : "✔",
    \ "Unknown"   : "¿"
    \ }
" VIM-HDL
let g:vimhdl_conf_file = ''
" Autoformat
let g:formatterpath = ['/usr/bin/tidy', '/usr/local/bin/js-beautify', '/usr/local/bin/gofmt']

" Colorscheme
" gruvbox config
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_italicize_comments = 1
let g:gruvbox_invert_selection = 0

" LaTeX
let g:vimtex_view_general_viewer
            \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

" This adds a callback hook that updates Skim after compilation
let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status)
    if !a:status | return | endif

    let l:out = b:vimtex.out()
    let l:tex = expand('%:p')
    let l:cmd = [g:vimtex_view_general_viewer, '-r']
    if !empty(system('pgrep Skim'))
        call extend(l:cmd, ['-g'])
    endif
    if has('nvim')
        call jobstart(l:cmd + [line('.'), l:out, l:tex])
    elseif has('job')
        call job_start(l:cmd + [line('.'), l:out, l:tex])
    else
        call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
    endif
endfunction
