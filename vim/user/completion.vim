" IDE like completion:
" <http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE>

" popup behavior
set completeopt=longest,menuone
" set showmatch

" change the behavior of the <Enter> key when the popup menu is visible. 
" In that case the Enter key will simply select the highlighted menu item, just as <C-Y> does.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" change the behavior of the <Tab> key in relation to the completion menu and
" neosnippet objects. When popup is open & it is a neosnippet object we
" expand, if not we just go down the list. If the popup window is closed and
" we have a neosnippet obj under the cursor we expand/jump or insert <Tab>
imap <expr><Tab> pumvisible() ? (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>") : (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_jump_or_expand)" : "\<Tab>")
" handle non-insert cases
smap <expr><Tab> "\<Plug>(neosnippet_expand_or_jump)"
xmap <expr><Tab> "\<Plug>(neosnippet_expand_target)"

" inverted popup scrolling
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" navigate popupu with Ctl-[J,K]
inoremap <expr><C-k> ((pumvisible())?("\<C-p>"):("\<C-k>"))
inoremap <expr><C-j> ((pumvisible())?("\<C-n>"):("\<C-j>"))

" Insert and reload popup
" inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-g> deoplete#undo_completion()
" inoremap <expr><C-l> deoplete#refresh()

" completion window
augroup completion_window
    autocmd!
    au InsertLeave * if pumvisible() == 0|pclose|endif
    au CompleteDone * if pumvisible() == 0|pclose|endif
augroup END
