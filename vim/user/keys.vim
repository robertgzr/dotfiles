" <Leader> key to <space>
let g:mapleader = ' '
let g:maplocalleader = '\'

" speed
noremap j gj
noremap k gk

" because this is annoying
command! W write
map q: :q

" keep <C-CR> unmapped
" unmap <C-<CR>>

" Buffer commands
nmap gb :bnext<CR>
nmap = gb
"
nmap gB :bprevious<CR>
nmap + gB

" FZF
nmap <Leader>ff :Files<CR>
nmap <Leader>fb :Buffers<CR>
nmap <Leader>fr :Rg<CR>

nmap <Leader>tb :TagbarToggle<CR>
nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)

" default runners
nmap <Leader>f :Neoformat<CR>
nmap <Leader>F :Neoformat! &filetype<CR>

nmap <Leader>l :Neomake<CR>
nmap <Leader>L :Neomake!<CR>
nmap <Leader>lt :NeomakeToggleBuffer<CR>
nmap <Leader>ltt :NeomakeToggle<CR>

" quickfix jumping
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprevious<CR>
nnoremap <Leader>cl :clist<CR>
" loclist jumping
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprevious<CR>
nnoremap <Leader>ll :llist<CR>

" escape terminal mode with <esc>
tnoremap <Esc> <C-\><C-n>
tnoremap <Leader>qq <C-\><C-n>:bdelete!<CR>
" nvimux
let g:nvimux_prefix='<C-a>'
let g:nvimux_custom_bindings = [
  \['-', ':NvimuxHorizontalSplit<CR>', ['n', 'v', 'i', 't']],
  \['\|', ':NvimuxVerticalSplit<CR>', ['n', 'v', 'i', 't']]
\]

nmap <F1> :GitGutterToggle<CR>
nmap <F2> :GitGutterLineHighlightsToggle<CR>
nmap <Leader>ph :GitGutterPrevHunk<CR>
nmap <Leader>nh :GitGutterNextHunk<CR>

nmap <Leader>ws :ToggleWorkspace<CR>

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
