" rc Includes
source ~/.vim/general.vim
source ~/.vim/plug.vim

" source plugin settings
for p in split(glob('~/.vim/components/plugin-settings/*.vim'), '\n')
    exe 'source' p
endfor

" centralize vimfiles
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" colorscheme options
syntax enable
let base16colorspace=256
set bg=dark
set termguicolors
colorscheme NeoSolarized

" cursorlines
set cursorline
" set cursorcolumn
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>c :set cursorline!<CR>
" cursorcolumn!<CR>

set fillchars=fold:-,vert:\│

" share OSX clipboard
set clipboard=unnamed
" allow backspace in INSERT mode
set backspace=indent,eol,start
highlight Comment cterm=italic

" integration stuff
if has("neovim-dot-app")
    set guifont=Iosevka Light:h13
end
if has("vimr")
    set guifont=Iosevka:h13
    set linespace=-1
    set guicursor+=a:blinkon0
end

source ~/.vim/autocommand.vim
source ~/.vim/line.vim
source ~/.vim/keys.vim
source ~/.vim/indent.vim
