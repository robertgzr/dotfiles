" vim: ts=2:sw=2:et:tw=99

let g:mapleader = ' ' " <leader> key to <space>
let g:maplocalleader = '\'

runtime general.vim
runtime plug.vim

" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" nnoremap <Leader>cl :set cursorline!<CR>
" nnoremap <Leader>cc :set cursorcolumn!<CR>

" looks {{{
let g:daymode = 1
let g:daymode_colorscheme_day = 'yui'
let g:daymode_colorscheme_night = 'PaperColor'
let g:daymode_lightline_colorscheme_day = 'ayu_light'
let g:daymode_lightline_colorscheme_night = 'papercolor_dim'

let g:PaperColor_Theme_Options = {
\   'theme': {
\     'default.dark': {
\       'allow_bold': 1,
\       'allow_italic': 1,
\       'transparent_background': 0,
\     }
\   }
\ }

au VimEnter * if exists('g:daymode') && g:daymode
  \ | call daymode#switch(0)
  \ | else
  \ | call daymode#switch(1)
  \ | endif

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
nmap <silent> <leader>cb :Clap buffers<CR>
nmap <silent> <leader>cg :Clap grep2<CR>
nmap <silent> <leader>cl :Clap blines<CR>
" quickfix jumping
" nnoremap <leader>cn :cnext<CR>
" nnoremap <leader>cp :cprevious<CR>
nnoremap <leader>cl :Clap quickfix<CR>
" loclist jumping
" nnoremap <leader>ln :lnext<CR>
" nnoremap <leader>lp :lprevious<CR>
nnoremap <leader>ll :Clap loclist<CR>
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
nmap <leader>gm <Plug>(git-messenger)
nmap <silent> <leader>v :Vista!!<CR>
nmap <silent> <leader>nt :call numbertoggle#switch()<CR>
nmap <silent> <leader>tn :rightbelow Tnew<CR>
vmap rt :call retab#do()<CR>
" }}}

" alternate        -> plugin/alternate.vim
" daymode          -> plugin/daymode.vim
" fasd             -> plugin/fasd.vim
" fuzzy            -> plugin/fuzz.vim
" hardmode         -> plugin/hard.vim
" numbertoggle     -> plugin/numbertoggle.vim
" writing          -> after/plugin/writing.vim
" filetype configs -> after/ftplugin
" neomake          -> after/plugin/neomake.vim
" lightline        -> plugin/line.vim

let g:netrw_browsex_viewer = 'url-launcher'

" plugin config {{{
"
let g:easy_align_ignore_groups = []
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
let g:vista_go_executive = 'nvim_lsp'
let g:vista_rust_executive = 'nvim_lsp'
let g:vista_ctags_cmd = {
\ 'vimwiki': $HOME . '/.vim/vwtags.py markdown',
\ }

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

" Enable color highlighting for all filetypes
let g:Hexokinase_ftAutoload = ['*']

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

" let g:clap_insert_mode_only = v:true
let g:clap_popup_border = 'sharp'
let g:clap_layout = {
\ 'relative': 'editor',
\ 'row': '2%', 'col': '0%',
\ 'width': '100%', 'height': '10%',
\ }
let g:clap_multi_selection_warning_silent = 1

let g:neoterm_size = 20
let g:neoterm_autoinsert = 1

let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-n>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"

let g:vimwiki_main = {}
let g:vimwiki_main.path = '~/wiki/'
let g:vimwiki_main.syntax = 'markdown'
let g:vimwiki_main.ext = '.md'
let g:vimwiki_main.name = 'wiki'
let g:vimwiki_main.index = '_index'
let g:vimwiki_list = [vimwiki_main]
let g:vimwiki_folding = 'list'
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
  nnoremap <silent> gd <cmd> lua vim.lsp.buf.declaration()<CR>
  nnoremap <silent> gD <cmd> lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> gT <cmd> lua vim.lsp.buf.type_definition()<CR>
  nnoremap <silent> gI <cmd> lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> gr <cmd> lua vim.lsp.buf.references()<CR>
  nnoremap <silent> g0 <cmd> lua vim.lsp.buf.document_symbol()<CR>
  nnoremap <silent> gW <cmd> lua vim.lsp.buf.workspace_symbol()<CR>
  nnoremap <silent> ;h <cmd> lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> ;s <cmd> lua vim.lsp.buf.signature_help()<CR>
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
  au FileType help,qf,vista nmap <buffer>q <c-w><c-q>
  au FileType vimwik if filereadable(expand('%')) | read !zet new | endif
augroup END

" augroup AutoSaveFolds
"   autocmd!
"   autocmd BufWinLeave * mkview
"   autocmd BufWinEnter * silent loadview
" augroup END

augroup Init
  au!
  " au VimEnter * call vista#RunForNearestMethodOrFunction()
  " au VimEnter * Vista!!

  " vim was opened as diff tool, load the 'diff' ftplugin conf
  au VimEnter * if &diff | runtime after/ftplugin/diff.vim | endif

  au BufEnter,BufLeave,BufWritePost * rshada|wshada
  " au FileType dirvish call fugitive#detect(@%)
  au BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
	\ |   exe "normal! g`\""
	\ | endif
augroup END

augroup ClapFix
  au!
  " see https://github.com/liuchengxu/vim-clap/issues/374#issuecomment-608272245
  au User ClapOnExit call lightline#update()
augroup END
" }}}

command! -bang DayMode call daymode#switch(<bang>0)
command! -range Retab <line1>,<line2>call retab#do()
command! NumberToggle call numbertoggle#switch()
command! Alternate call alternate#alternate()
