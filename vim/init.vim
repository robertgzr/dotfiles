" rc Includes
source ~/.vim/general.vim
source ~/.vim/plug.vim
" source more vim settings
for s:plugin in split(glob('~/.vim/user/*.vim'), '\n')
    exe 'source' s:plugin
endfor

" colorscheme options
set termguicolors
" set t_Co=256
" let g:base16colorspace=256
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

let g:neodark#background='#202020'
" let g:neodark#use_256color=1
let g:neodark#solid_vertsplit=1
let g:neodark#use_custom_terminal_theme=1
" VimR GUI options
if has('gui_vimr')
  call LightLineUsePowerline()
else
  let g:neodark#terminal_transparent=1
  " hi Normal ctermbg=NONE guibg=NONE
endif
colorscheme neodark

" share OSX clipboard
" set clipboard=unnamed
" allow backspace in INSERT mode
set backspace=indent,eol,start

highlight Comment cterm=italic gui=italic

" cursorlines
" set cursorline
" set cursorcolumn
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>cl :set cursorline!<CR>
nnoremap <Leader>cc :set cursorcolumn!<CR>

set fillchars=fold:-,vert:\│

" centralize vimfiles
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists('&undodir')
    set undodir=~/.vim/undo
endif

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=nv
endif

