" <Leader> key
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
nmap <Leader>fh :FzfHistory<CR>
nmap <Leader>fl :FzfLines<CR>
nmap <Leader>fbl :FzfBLines<CR>
nmap <Leader>fll :FzfLocate<CR>
nmap <Leader>ft :FzfTags<CR>

nmap <Leader>tb :TagbarToggle<CR>
nmap ga <Plug>(EasyAlign)

" spotlight jumping
map <Leader>en :cnext<CR>
map <Leader>ep :cprevious<CR>
nnoremap <Leader>ea :cclose<CR>

" escape terminal mode with <esc>
tnoremap <Esc> <C-\><C-n>

nmap <F1> :GitGutterToggle<CR>
nmap <F2> :GitGutterLineHighlightsToggle<CR>
nmap <F3> :Goyo<CR>

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
