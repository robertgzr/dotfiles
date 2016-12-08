" <Leader> key
" set mapleader = ','

" because this is annoying
command! W write

" Buffer commands
command! Wb write|bdelete
command! Qb bdelete
nmap gb :bnext<CR>
nmap gB :bprevious<CR>

" FZF
map <Leader>ff :FzfFiles<CR>
map <Leader>fb :FzfBuffers<CR>
map <Leader>fh :FzfHistory<CR>
map <Leader>fl :FzfLines<CR>
map <Leader>fbl :FzfBLines<CR>
map <Leader>fll :FzfLocate<CR>

noremap <M-g> :Goyo<CR>

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" spotlight jumping
map <Leader>en :cnext<CR>
map <Leader>ep :cprevious<CR>
nnoremap <Leader>ea :cclose<CR>

" escape terminal mode with <esc>
tnoremap <Esc> <C-\><C-n>

nmap <F8> :TagbarToggle<CR>

" deoplete rust mappings
augroup filetype_rust
    au FileType rust nmap <Leader>gd <plug>DeopleteRustGoToDefinitionDefault
    au FileType rust nmap <Leader>d  <plug>DeopleteRustShowDocumentation
augroup END

" Hardmode = not using arrow keys
let g:hardmode_error = "Don't use the arrow keys!"
nnoremap <Left> :echoerr g:hardmode_error<CR>
nnoremap <Right> :echoerr g:hardmode_error<CR>
nnoremap <Up> :echoerr g:hardmode_error<CR>
nnoremap <Down> :echoerr g:hardmode_error<CR>

vnoremap <Left> :echoerr g:hardmode_error<CR>
vnoremap <Right> :echoerr g:hardmode_error<CR>
vnoremap <Up> :echoerr g:hardmode_error<CR>
vnoremap <Down> :echoerr g:hardmode_error<CR>

inoremap <Left> <Esc>:echoerr g:hardmode_error<CR>
inoremap <Right> <Esc>:echoerr g:hardmode_error<CR>
inoremap <Up> <Esc>:echoerr g:hardmode_error<CR>
inoremap <Down> <Esc>:echoerr g:hardmode_error<CR>
