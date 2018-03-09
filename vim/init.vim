" rc Includes
 source ~/.vim/general.vim
 source ~/.vim/plug.vim

" source more vim settings
" for s:plugin in split(glob('~/.vim/user/*.vim'), '\n')
"     exe 'source' s:plugin
" endfor
" unrolled user config for debugging
 source ~/.vim/user/lint.vim
 " source ~/.vim/user/deoplete.vim
 source ~/.vim/user/completion.vim
 source ~/.vim/user/go.vim
 source ~/.vim/user/keys.vim
 source ~/.vim/user/indent.vim
 source ~/.vim/user/polyglot.vim
 source ~/.vim/user/line.vim
 source ~/.vim/user/numbertoggle.vim
 source ~/.vim/user/user.vim
 source ~/.vim/user/writing.vim

" share OSX clipboard
set clipboard=unnamed
" allow backspace in INSERT mode
set backspace=indent,eol,start

set signcolumn=yes
" cursorlines
" set cursorline
" set cursorcolumn
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" nnoremap <Leader>cl :set cursorline!<CR>
" nnoremap <Leader>cc :set cursorcolumn!<CR>

" For conceal markers.
if has('conceal')
  " set conceallevel=2 concealcursor=nv
  set conceallevel=2 concealcursor=
endif

" centralize vimfiles
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists('&undodir')
    set undodir=~/.vim/undo
endif

" pane divider chars
set fillchars=fold:-,vert:\│

"" colorscheme options
if has("termguicolors")
  set termguicolors
endif
" set t_Co=256
" let g:base16colorspace=256
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

let g:nihon#solid_vertsplit=1
let g:nihon#use_custom_terminal_theme=0
let g:nihon#terminal_transparent=1
let g:nihon#italics=1

colorscheme nihon
let g:lightline.colorscheme = 'nihon'

" make comments italic, no matter what the colorscheme does
" highlight Comment cterm=italic gui=italic

if has('gui_vimr')
  " VimR GUI options
  source ~/.vim/ginit.vim
elseif has('g:gonvim_running')
  exe ':GuiFont Iosevka:12'
else
  " Terminal vim options
  hi Normal ctermbg=NONE guibg=NONE
endif
