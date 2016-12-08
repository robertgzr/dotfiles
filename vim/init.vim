" rc Includes
source ~/.vim/general.vim
source ~/.vim/plug.vim
" source more vim settings
for s:plugin in split(glob('~/.vim/settings/*.vim'), '\n')
    exe 'source' s:plugin
endfor

" colorscheme options
syntax enable
let g:base16colorspace=256
set background=dark
colorscheme NeoSolarized

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
nnoremap <Leader>c :set cursorline!<CR>
" cursorcolumn!<CR>

set fillchars=fold:-,vert:\│

" centralize vimfiles
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists('&undodir')
    set undodir=~/.vim/undo
endif

" VimR options
if has('gui_vimr')
end
