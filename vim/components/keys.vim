" because this is annoying
command! W write

" Hardmode
let g:hardmode_msg = 'You are pathetic!'
nnoremap <Left> :echo g:hardmode_msg<CR>
vnoremap <Left> :echo g:hardmode_msg<CR>
inoremap <Left> :echo g:hardmode_msg<CR>
nnoremap <Right> :echo g:hardmode_msg<CR>
vnoremap <Right> :echo g:hardmode_msg<CR>
inoremap <Right> :echo g:hardmode_msg<CR>
nnoremap <Up> :echo g:hardmode_msg<CR>
vnoremap <Up> :echo g:hardmode_msg<CR>
inoremap <Up> :echo g:hardmode_msg<CR>
nnoremap <Down> :echo g:hardmode_msg<CR>
vnoremap <Down> :echo g:hardmode_msg<CR>
inoremap <Down> :echo g:hardmode_msg<CR>

" Buffer commands
command! Wb write|bdelete
command! Qb bdelete
nmap gb :bnext<CR>
nmap gB :bprevious<CR>

map <Leader>ff :FzfFiles<CR>
map <Leader>fb :FzfBuffers<CR>
map <Leader>fh :FzfHistory<CR>
map <Leader>fl :FzfLines<CR>
map <Leader>fbl :FzfBLines<CR>
map <Leader>fL :FzfLocate<CR>

noremap <M-g> :Goyo<CR>
map <C-n> :NERDTreeToggle<CR>

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

au FileType go nmap <Leader>rt <Plug>(go-run-tab)
au FileType go map <Leader>ga :GoAlternate<CR>

map <Leader>en :cnext<CR>
map <Leader>ep :cprevious<CR>
nnoremap <Leader>ea :cclose<CR>


" completion
" inoremap <expr> <CR> pumvisible() ? '\<C-y>' : '\<C-g>u\<CR>'
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? '\<lt>Down>' : ''<CR>'
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-p><C-r>=pumvisible() ? '\<lt>Down>' : ''<CR>'

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" expand snippets with ENTER
imap <expr><CR> pumvisible() ?
      \ neosnippet#expandable_or_jumpable() ?
      \     "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>" : "\<CR>"

" use TAB key for neosnippet and deoplete
let g:vcm_default_maps = 0
imap <S-Tab> <Plug>vim_completes_me_backward
imap <expr><Tab> pumvisible() ? 
      \ "\<Plug>vim_completes_me_forward" :
      \ neosnippet#expandable_or_jumpable() ?
      \     "\<Plug>(neosnippet_expand_or_jump)" :
      \     "\<Tab>"
" imap <expr><Tab> neosnippet#expandable_or_jumpable() ? 
"       \ "\<Plug>(neosnippet_expand_or_jump)" :
"       \ pumvisible() ?
"       \     "\<Plug>vim_completes_me_forward" :
"       \     "\<Tab>"
smap <expr><Tab> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" :
  \ "\<Tab>"
xmap <expr><Tab> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_target)" :
  \ "\<Tab>"
