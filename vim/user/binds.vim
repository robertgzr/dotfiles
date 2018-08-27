" <Leader> key to <space>
let g:mapleader = ' '
let g:maplocalleader = '\'
" speed
noremap j gj
noremap k gk
" because this is annoying
cnoreabbrev W w
cnoreabbrev E e
cnoreabbrev Q q
map q: :q

" keep <C-CR> unmapped
" unmap <C-<CR>

" Buffer commands
nmap gb :bnext<CR>
"
nmap gB :bprevious<CR>

" FZF
nmap <Leader>ff :Files<CR>
nmap <Leader>fb :Buffers<CR>
nmap <Leader>fr :Rg<CR>

nmap <Leader>tb :TagbarToggle<CR>
nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)

" langserv
nmap <Leader>lc :call LanguageClient_contextMenu()<CR>
nmap <Leader>i :call LanguageClient_textDocument_hover()<CR>
nmap <Leader>j :call LanguageClient_textDocument_definition()<CR>
nmap <Leader>r :call LanguageClient_textDocument_references()<CR>
nmap <Leader>rn :call LanguageClient_textDocument_rename()<CR>
nmap <Leader>f :call LanguageClient_textDocument_formatting()<CR>

" default runners
" nmap <Leader>F :Neoformat! &filetype<CR>

nmap <Leader>l :Neomake<CR>
nmap <Leader>L :Neomake! makeprg<CR>
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

nmap <F1> :GitGutterToggle<CR>
nmap <F2> :GitGutterLineHighlightsToggle<CR>
nmap <Leader>ph :GitGutterPrevHunk<CR>
nmap <Leader>nh :GitGutterNextHunk<CR>

nmap <Leader>ws :ToggleWorkspace<CR>
" defined in indent.vim
nmap <Leader>tt :call Tabthis()<CR>

" Hardmode = not using arrow keys
let g:hardmode_error = "Don't use arrow keys!"
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
