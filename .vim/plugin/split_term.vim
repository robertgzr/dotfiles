" SplitTerm: quickly pop out a terminal

" skip this while were testing kassio/neoterm
finish

" lua require('split_term')
" command! LuaTerm :lua spt_toggle()<CR>

command! -bang -nargs=* SplitTerm call s:split_term_toggle(<bang>0, <f-args>)
cnoreabbrev spt SplitTerm
cnoreabbrev st SplitTerm
