let g:echodoc_enable_at_startup = 1

" easy window splitting
command! -nargs=0 SplitVertical vspl|wincmd l|enew
command! -nargs=0 SplitHorizontal spl|wincmd j|enew
nmap <C-w>\| :SplitVertical<CR>
nmap <C-w>- :SplitHorizontal<CR>

" matchtagalways
let g:mta_use_matchparen_group = 1
let g:mta_filetypes = {
    \ 'html'  : 1,
    \ 'xhtml' : 1,
    \ 'xml'   : 1,
    \ 'jinja' : 1,
    \ 'vue'   : 1
\}

call lexima#add_rule({'char': '<Space>', 'at': '* \[\%#]', 'insert_after': '', 'filetype': 'markdown'})
call lexima#add_rule({'char': '<Space>', 'at': '\[ \%#]', 'insert_after': '<Space>', 'filetype': 'markdown'})

" fzf
let g:fzf_command_prefix = 'Fzf'
let g:fzf_buffers_jump = 1
let g:fzf_action = {
    \ 'ctrl-q': 'bdelete',
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }

" fzf + ripgrep => :Find
" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
command! -bang -nargs=* Find call fzf#vim#grep('rg'
    \ . ' --column'
    \ . ' --line-number'
    \ . ' --no-heading'
    \ . ' --fixed-strings'
    \ . ' --ignore-case'
    \ . ' --no-ignore'
    \ . ' --hidden'
    \ . ' --follow'
    \ . ' --glob "!.git/*"'
    \ . ' --color "always"'
    \ . ' '.shellescape(<q-args>), 1, <bang>0)

" VIM-HDL
let g:vimhdl_conf_file = ''

" Autoformat
" let g:formatterpath = [ '/usr/bin', '/usr/local/bin' ]
" let g:autoformat_autoindent = 0
" let g:autoformat_retab = 0
" let g:autoformat_remove_trailing_spaces = 0

" Neoformat
let g:neoformat_only_msg_on_error = 1
let g:neoformat_basic_format_align = 0
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

" gruvbox config
" let g:gruvbox_contrast_dark = 'medium'
" let g:gruvbox_italicize_comments = 1
" let g:gruvbox_invert_selection = 0

" gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_column_always = 1

let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▎'
let g:gitgutter_sign_removed_first_line = '▀'
let g:gitgutter_sign_modified_removed = '▎'

" Minimal UX
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 2
let g:goyo_height = 85
let g:goyo_width = 80
let g:goyo_linenr = 1

" tagbar - gotags
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
        \ }
