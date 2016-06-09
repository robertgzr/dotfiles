" Buffer commands
command Wb write|bdelete
command Qb bdelete
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
