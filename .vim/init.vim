" vim: ts=2:sw=2:et:tw=99

" let g:daymode = 1

let g:mapleader = ' ' " <leader> key to <space>
let g:maplocalleader = '\'

runtime general.vim
runtime plug.vim

" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" nnoremap <Leader>cl :set cursorline!<CR>
" nnoremap <Leader>cc :set cursorcolumn!<CR>

" looks {{{
set background=dark
let g:PaperColor_Theme_Options = {
\   'theme': {
\     'default.dark': {
\       'allow_bold': 1,
\       'allow_italic': 1,
\       'transparent_background': 1,
\     }
\   }
\ }
colorscheme PaperColor
let g:day_mode_colorscheme = 'PaperColor'

" Make comments italic, no matter what the colorscheme does
hi Comment gui=italic
" Fix ugly looking grey when transparent_background=1
hi SignColumn guibg=none ctermbg=none
" }}}

" key bindings {{{
" speed
noremap j gj
noremap k gk
" because this is annoying
cnoreabbrev W w
cnoreabbrev E e
cnoreabbrev Q q
" Buffer commands
nmap <silent> gb :bnext<CR>
nmap <silent> gB :bprevious<CR>
" quickfix jumping
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>
nnoremap <leader>cl :clist<CR>
" loclist jumping
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>
nnoremap <leader>ll :llist<CR>
" escape terminal mode with <esc>
tnoremap <esc> <C-\><C-n>
tnoremap <leader>qq <C-\><C-n>:bdelete!<CR>
" delete and don't remember...
" nnoremap s "_d
" nnoremap ss "_dd
" vnoremap s "_d
" replace word under cursor
nmap <silent> riw :%s/\<<C-r><C-w>\>/

nmap <silent> ga <Plug>(EasyAlign)
vmap <silent> <Enter> <Plug>(EasyAlign)
nmap <silent> gl <Plug>(OrgHyperlinkFollow)
nmap <leader>gm <Plug>(git-messenger)
nmap <leader>v :Vista!!<CR>
nmap <leader>nt :call numbertoggle#switch()<CR>
nmap <leader>tn :rightbelow Tnew<CR>
vmap rt :call retab#do()<CR>
" }}}

" alternate -> plugin/alternate.vim
" daymode -> plugin/daymode.vim
" fasd -> plugin/fasd.vim
" fuzzy -> plugin/fuzz.vim
" hardmode -> plugin/hard.vim
" numbertoggle -> plugin/numbertoggle.vim
" writing -> after/plugin/tagbar.vim
" filetype configs -> after/ftplugin
" coc -> after/plugin/coc.vim
" neomake -> after/plugin/neomake.vim
" tagbar -> after/plugin/tagbar.vim
" lightline -> plugin/line.vim

" plugin config {{{
"
" obsession {{{2
let g:session_extension = ".vim-session"
let g:session_autosave = "no"
let g:session_autoload = "no"
let g:session_autosave_periodic = 5
let g:session_command_aliases = 1
" }}}2
let g:echodoc_enable_at_startup = 1
" matchtagalways {{{2
let g:mta_use_matchparen_group = 1
let g:mta_filetypes = {
      \ 'html'  : 1,
      \ 'xhtml' : 1,
      \ 'xml'   : 1,
      \ 'jinja' : 1,
      \ 'vue'   : 1
      \}
" }}}2
" emmet
let g:user_emmet_leader_key = g:maplocalleader " followed by ,
" let g:user_emmet_mode = 'a'
" indentguides {{{2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_color_change_percent = 2
let g:indent_guides_guide_size = 1
" }}}2
" indentline {{{2
" let g:indentLine_char = '▏'
" let g:indentLine_enabled = 1
" let g:indentLine_conceallevel = 1
" :set list lcs=tab:\▏\
" }}}2
" signify {{{2
" let g:signify_sign_add = '▎'
" let g:signify_sign_delete = '▎'
" let g:signify_sign_delete_first_line = '▀'
let g:signify_sign_change = '~'
" let g:signify_sign_changedelete = g:signify_sign_change
" let g:signify_sign_show_text = 0

hi SignifySignChange guibg=NONE ctermbg=NONE
hi SignifySignAdd guibg=NONE ctermbg=NONE
hi SignifySignDelete guibg=NONE ctermbg=NONE

nmap <silent> ]h <Plug>(signify-next-hunk)
nmap <silent> [h <Plug>(signify-prev-hunk)
" }}}2

let g:polyglot_disabled = ['markdown', 'org', 'latex', 'tex', 'vue']
let g:vue_disable_pre_processors = 1
let g:vim_json_syntax_conceal = 1

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T'] " quickscope
let g:utl_cfg_hdl_scm_http = 'silent !xdg-open %u'
let g:sneak#label = 1

" vista {{{2
let g:vista_icon_indent = ['> ', '* ']
let g:vista_default_executive = 'ctags'
" let g:vista_executive_for = {
" \ 'javascript': 'coc',
" \ 'python': 'coc',
" \ }
let g:vista#renderer#enable_icon = 0
let g:vista#renderer#icons = {
\    'func': "f",
\    'function': "f",
\    'functions': "fs",
\    'var': "v",
\    'variable': "v",
\    'variables': "vs",
\    'const': "c",
\    'constant': "c",
\    'method': "m",
\    'package': "p",
\    'packages': "ps",
\    'enum': "e",
\    'enumerator': "E",
\    'module': "m",
\    'modules': "ms",
\    'type': "t",
\    'typedef': "t",
\    'types': "ts",
\    'field': "fd",
\    'fields': "fds",
\    'macro': "mc",
\    'macros': "mcs",
\    'map': "mp",
\    'class': "cl",
\    'augroup': "au",
\    'struct': "st",
\    'union': "u",
\    'member': "mb",
\    'target': "ta",
\    'property': "pr",
\    'interface': "if",
\    'namespace': "ns",
\    'subroutine': "sr",
\    'implementation': "im",
\    'typeParameter': "tp",
\    'default': "_"
\ }
" }}}2

" bufferline {{{2
let g:bufferline_echo = 0
let g:bufferline_show_bufnr = 0
" let g:bufferline_separator = ' '
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
" let g:bufferline_unamed_buffer = '[no name]'
let g:bufferline_fname_mod = ':t:s?^$?[no name]?'
" }}}2

" Enable color highlighting for all filetypes
let g:Hexokinase_ftAutoload = ['*']
let $SKIM_DEFAULT_COMMAND = ''

" vim-markdown {{{2
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_folding_level = 2
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_auto_insert_bullets = 1
let g:vim_markdown_new_list_item_indent = 0
" }}}2

" let g:git_messenger_include_diff = v:false
let g:git_messenger_always_into_popup = v:true
let g:git_messenger_close_on_cursor_moved = v:true

" Neoformat {{{2
let g:neoformat_basic_format_align = 0
let g:neoformat_basic_format_retab = 0
let g:neoformat_basic_format_trim = 0
let g:neoformat_only_msg_on_error = 1
" }}}2

let g:neoterm_size = 20
let g:neoterm_autoinsert = 1

let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-n>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
" }}}1

" lsp + compl {{{1
if has('nvim-0.5.0')
lua << EOF
local lsp   = require 'nvim_lsp'
local util  = require 'nvim_lsp/util'
local compl = require 'completion'

lsp.gopls.setup{
  on_attach = compl.on_attach;
  root_dir = util.root_pattern("go.mod");
}
lsp.rust_analyzer.setup{
  on_attach = compl.on_attach;
}
EOF
  " autocmd Filetype bash,shell,css,go,python,rust,tex,latex setl omnifunc=lsp#omnifunc
  " au Filetype lua setl omnifunc=v:lua.vim.lsp.omnifunc
  nnoremap <silent> gd  :call lsp#text_document_definition()<CR>
  nnoremap <silent> gdc :call lsp#text_document_declaration()<CR>
  nnoremap <silent> gt  :call lsp#text_document_type_definition()<CR>
  nnoremap <silent> gi  :call lsp#text_document_implementation()<CR>
  nnoremap <silent> ;h  :call lsp#text_document_hover()<CR>
  nnoremap <silent> ;s  :call lsp#text_document_signature_help()<CR>
else
  echoerr 'nvim_lsp only works with neovim>=0.5.0'
endif

set complete=.,w,b,u
set completeopt=menuone,noinsert,noselect
" set completeopt-=preview
set shortmess+=c

let g:completion_enable_auto_popup = 1
let g:completion_enable_auto_signature = 1
let g:completion_enable_auto_paren = 0
let g:completion_confirm_key = "\<tab>"
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_auto_change_source = 1
let g:completion_chain_complete_list = [
  \ {'complete_items': ['lsp', 'snippet']},
  \ {'mode': '<c-p>'},
  \ {'mode': '<c-n>'}
  \ ]

inoremap <silent><expr> <c-n>
  \ pumvisible() ? "\<c-n>" : completion#trigger_completion()
" }}}1

" gui extra config {{{
" probably obsolete...
if exists('veonim')
  " set linespace=5
  set guifont=Iosevka\ R:h17
  runtime init_veonim.vim
endif
" }}}

function! s:fmt() abort
  if exists('g:nofmt') || exists('b:nofmt')
    return
  endif
  try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
endfunction

augroup DoFmt
  au!
  au BufWritePre * :call <SID>fmt()
augroup END

" autogroups {{{
augroup SpecialBuffers
  au!
  " au  FileType vista,fzf,skim set laststatus=0 noshowmode noruler
        " \| au BufLeave <buffer> set laststatus=2 ruler
  au FileType fzf,skim tnoremap <buffer><esc> <c-c>
  au FileType gitmessengerpopup nmap <buffer><esc> <Plug>(git-messenger-close)
  au FileType vista nmap <buffer><space> :wincmd p<CR>
  au FileType help,qf nmap <buffer>q <c-w><c-q>
augroup END

" augroup AutoSaveFolds
"   autocmd!
"   autocmd BufWinLeave * mkview
"   autocmd BufWinEnter * silent loadview
" augroup END

augroup Init
  au!
  au VimEnter * set iskeyword-=-
  " au VimEnter * call vista#RunForNearestMethodOrFunction()
  " au VimEnter * Vista!!
  au VimEnter * if exists('g:daymode') && g:daymode | call daymode#switch(0) | endif

  " vim was opened as diff tool, load the 'diff' ftplugin conf
  au VimEnter * if &diff | runtime after/ftplugin/diff.vim | endif

  au BufEnter,BufLeave,BufWritePost * rshada|wshada
  " au FileType dirvish call fugitive#detect(@%)
  au BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
	\ |   exe "normal! g`\""
	\ | endif
augroup END
" }}}

command! -bang DayMode call daymode#switch(<bang>0)
command! -range Retab <line1>,<line2>call retab#do()
command! NumberToggle call numbertoggle#switch()
command! Alternate call alternate#alternate()

command! -nargs=* Zet call zettel#edit(<f-args>)
command! ZetDay call zettel#newday()
