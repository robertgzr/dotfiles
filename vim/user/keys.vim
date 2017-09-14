" <Leader> key to <space>
let g:mapleader = ' '

" speed
noremap j gj
noremap k gk

" because this is annoying
command! W write
map q: :q

" Buffer commands
command! Wb write|bdelete
command! Qb bdelete
nmap gb :bnext<CR>
nmap gB :bprevious<CR>

" FZF
nmap <Leader>ff :FzfFiles<CR>
nmap <Leader>fb :FzfBuffers<CR>

nmap <Leader>tb :TagbarToggle<CR>
nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)

" spotlight jumping
map <Leader>en :cnext<CR>
map <Leader>ep :cprevious<CR>
nnoremap <Leader>ea :cclose<CR>

" escape terminal mode with <esc>
tnoremap <Esc> <C-\><C-n>

nmap <F1> :GitGutterToggle<CR>
nmap <F2> :GitGutterLineHighlightsToggle<CR>

nmap <Leader>f :Neoformat<CR>

" easy window splitting
command! -nargs=0 SplitVertical vspl|wincmd l|enew
command! -nargs=0 SplitHorizontal spl|wincmd j|enew
nmap <C-w>\| :SplitVertical<CR>
nmap <C-w>- :SplitHorizontal<CR>

nmap <Leader>ct :call deoplete#toggle()<CR>
" neosnippet mappings
" imap <C-s> <Plug>(neosnippet_expand_or_jump)
" smap <C-s> <Plug>(neosnippet_expand_or_jump)
" xmap <C-s> <Plug>(neosnippet_expand_or_jump)

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
