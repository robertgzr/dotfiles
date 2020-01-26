
func! retab#do()
    for lineno in range(a:firstline, a:lastline)
        normal! <<
        normal! >>
    endfor
endfunc
