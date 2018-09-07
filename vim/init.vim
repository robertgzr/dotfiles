" rc Includes
source ~/.vim/general.vim
source ~/.vim/plug.vim

" source more vim settings
source ~/.vim/user/lint.vim
source ~/.vim/user/completion.vim
source ~/.vim/user/binds.vim
source ~/.vim/user/indent.vim
source ~/.vim/user/polyglot.vim
source ~/.vim/user/line.vim
source ~/.vim/user/user.vim
source ~/.vim/user/hard.vim

" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" nnoremap <Leader>cl :set cursorline!<CR>
" nnoremap <Leader>cc :set cursorcolumn!<CR>

set t_Co=256
set background=dark
let g:neodark#background = '#202020'
let g:neodark#use_256color = 1
let g:neodark#solid_vertsplit = 1
colorscheme neodark
let g:lightline.colorscheme = 'neodark'
let g:day_mode_colorscheme = 'PaperColor'

" make comments italic, no matter what the colorscheme does
highlight Comment cterm=italic gui=italic

if has('gui_vimr')
  " VimR GUI options
  source ~/.vim/ginit.vim
elseif has('g:gonvim_running')
  exe ':GuiFont Iosevka:12'
else
  " Terminal vim options
  " hi Normal ctermbg=NONE guibg=NONE
endif

augroup Init
    au!
    au BufEnter,CursorHold * rshada|wshada
    " au BufWritePre * Neoformat
    " au FileType dirvish call fugitive#detect(@%)

    au VimEnter * command! -bang DayMode call daymode#switch(<bang>0)
    au VimEnter * command! NumberToggle call numbertoggle#switch()
    au VimEnter * nmap <Leader>nt :call numbertoggle#switch()<CR>
    au VimEnter * command! Alternate call alternate#alternate()
augroup END
