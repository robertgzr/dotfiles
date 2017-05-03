" IDE like completion:
" <http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE>

" popup behavior
set completeopt=longest,menuone
" set showmatch

" change the behavior of the <Enter> key when the popup menu is visible. 
" In that case the Enter key will simply select the highlighted menu item, just as <C-Y> does.
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" make <C-N> work the way it normally does; however, when the menu appears, the <Down> key will be simulated. 
" What this accomplishes is it keeps a menu item always highlighted. This way you can keep typing characters to narrow the matches, 
" and the nearest match will be selected so that you can hit Enter at any time to insert it.
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" simulates <C-X><C-O> to bring up the omni completion menu, 
" then it simulates <C-N><C-P> to remove the longest common text, 
" and finally it simulates <Down> again to keep a match highlighted. 
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"   \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

function! s:tab_complete()
  " is completion menu open? cycle to next item
  if pumvisible()
    return "\<C-n>"
  endif

  " is there a snippet that can be expanded?
  " is there a placholder inside the snippet that can be jumped to?
  if neosnippet#expandable_or_jumpable() 
    return "\<Plug>(neosnippet_expand_or_jump)"
  endif

  " if none of these match just use regular tab
  return "\<Tab>"
endfunction

inoremap <silent><expr><TAB> <SID>tab_complete()

" navigate popupu with Ctl-[J,K]
inoremap <expr><C-k> ((pumvisible())?("\<C-p>"):("\<C-k>"))
inoremap <expr><C-j> ((pumvisible())?("\<C-n>"):("\<C-j>"))

" C-Tab goes backwards
" inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>"
"     \ : "\<S-Tab>"

" expand/jump snippets with Tab
smap <expr> <Tab> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" :
    \ "\<Tab>"

" Insert and reload popup
" inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-g> deoplete#undo_completion()
" inoremap <expr><C-l> deoplete#refresh()

