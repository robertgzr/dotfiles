" rc Includes
source ~/.vim/general.vim
source ~/.vim/plug.vim
" source more vim settings
for s:plugin in split(glob('~/.vim/settings/*.vim'), '\n')
    exe 'source' s:plugin
endfor

" colorscheme options
set termguicolors
set t_Co=256
let g:base16colorspace=256
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

let g:neodark#background='#272727'
let g:neodark#use_256color=0
set background=dark
colorscheme neodark

" share OSX clipboard
set clipboard=unnamed
" allow backspace in INSERT mode
set backspace=indent,eol,start
highlight Comment cterm=italic

" cursorlines
set cursorline
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

" VimR options
if has('gui_vimr')
  call LightLineUsePowerline()
else
  hi Normal ctermbg=NONE guibg=NONE
end
