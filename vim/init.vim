let g:mapleader = ' ' " <leader> key to <space>
let g:maplocalleader = '\'

source ~/.vim/general.vim
source ~/.vim/plug.vim

" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" nnoremap <Leader>cl :set cursorline!<CR>
" nnoremap <Leader>cc :set cursorcolumn!<CR>

" looks
set t_Co=256
set background=dark
let g:neodark#background = '#202020'
let g:neodark#use_256color = 1
let g:neodark#solid_vertsplit = 1
colorscheme neodark
let g:day_mode_colorscheme = 'PaperColor'
" make comments italic, no matter what the colorscheme does
highlight Comment cterm=italic gui=italic

" KEY BINDINGS {{{
" speed
noremap j gj
noremap k gk
" because this is annoying
cnoreabbrev W w
cnoreabbrev E e
cnoreabbrev Q q
map q: :q
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

nmap <silent> ga <Plug>(EasyAlign)
vmap <silent> <Enter> <Plug>(EasyAlign)
nmap <F1> :GitGutterToggle<CR>
nmap <F2> :GitGutterLineHighlightsToggle<CR>
nmap <leader>ph :GitGutterPrevHunk<CR>
nmap <leader>nh :GitGutterNextHunk<CR>
nmap <silent> gl <Plug>(OrgHyperlinkFollow)
" }}}

" PLUGIN CONFIG {{{
" obsession {{{
let g:session_extension = ".vim-session"
let g:session_autosave = "no"
let g:session_autoload = "no"
let g:session_autosave_periodic = 5
let g:session_command_aliases = 1
" }}}
let g:echodoc_enable_at_startup = 1
" matchtagalways {{{
let g:mta_use_matchparen_group = 1
let g:mta_filetypes = {
    \ 'html'  : 1,
    \ 'xhtml' : 1,
    \ 'xml'   : 1,
    \ 'jinja' : 1,
    \ 'vue'   : 1
\}
" }}}
" emmet
let g:user_emmet_leader_key = g:maplocalleader " followed by ,
" let g:user_emmet_mode = 'a'
" indentguides {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_color_change_percent = 2
" }}}
" gitgutter {{{
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▎'
let g:gitgutter_sign_removed_first_line = '▀'
let g:gitgutter_sign_modified_removed = '▎'
" }}}

let g:polyglot_disabled = ['go', 'markdown', 'org', 'latex', 'tex', 'vue']
let g:vue_disable_pre_processors = 1
let g:vim_json_syntax_conceal = 1

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T'] " quickscope
let g:utl_cfg_hdl_scm_http = 'silent !xdg-open %u'
let g:sneak#label = 1 

" vista {{{
let g:vista_icon_indent = ['>', '']
let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
\   'go': 'coc',
\   'json': 'coc',
\   'javascript': 'coc',
\  }
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   'function': '\uf794',
\   'variable': '\uf71b',
\  }
" }}}

" bufferline {{{
set showtabline=1
let g:bufferline_echo = 0
let g:bufferline_show_bufnr = 0
" let g:bufferline_separator = ' '
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
" let g:bufferline_unamed_buffer = '[no name]'
let g:bufferline_fname_mod = ':t:s?^$?[no name]?'
" }}}

" Enable color highlighting for all filetypes
let g:Hexokinase_ftAutoload = ['*']
let $SKIM_DEFAULT_COMMAND = ''

" vim-markdown {{{
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_folding_disabled = 1
" }}}

" }}}

" VIMR / VEONIM EXTRA CONFIG {{{
if has('gui_vimr')
  " VimR GUI options
  source ~/.vim/ginit.vim
elseif has('g:gonvim_running')
  exe ':GuiFont Iosevka:12'
else
  " Terminal vim options
  " hi Normal ctermbg=NONE guibg=NONE
endif

if exists('veonim')
  source ~/.vim/init_veonim.vim
endif
" }}}

" AUTOGROUPS {{{
augroup SpecialBuffers
    au!
    au  FileType vista,fzf,skim set laststatus=0 noshowmode noruler
      \| au BufLeave <buffer> set laststatus=2 ruler
    au FileType fzf,skim tnoremap <buffer> <esc> <c-c>
augroup END

augroup Init
    au!
    au BufEnter,CursorHold * rshada|wshada
    " au BufWritePre * Neoformat
    " au FileType dirvish call fugitive#detect(@%)

    au VimEnter * command! -bang DayMode call daymode#switch(<bang>0)
    au VimEnter * command! NumberToggle call numbertoggle#switch()
    au VimEnter * nmap <Leader>nt :call numbertoggle#switch()<CR>
    au VimEnter * command! Alternate call alternate#alternate()
    au VimEnter * command! Retab :call Retab()<CR>
augroup END
" }}}
