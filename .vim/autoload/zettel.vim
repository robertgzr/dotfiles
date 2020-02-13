" note taking helpers
" to aide in practicing the zettelkasten.de system
"
" ref: https://vimways.org/2019/personal-notetaking-in-vim/

let g:zettel_dir = $HOME.'/wiki'
let g:zettel_ext = '.md'

func! zettel#is_zettel(fpath)
    if a:fpath =~ g:zettel_dir . '/.*' . g:zettel_ext . '$' | return 1 | en
    return 0
endfunc

func! zettel#set_filetype()
    silent exec 'setlocal filetype=zettel'
endfunc

func! zettel#edit(...)
    let l:fname = expand(g:zettel_dir) . '/'
        \ . strftime('%Y') . '/'
        \ . tolower(strftime('%m-%b')) . g:zettel_ext

    silent exec 'e ' . l:fname
endfunc


func! zettel#newday()
    let linenr = line('$')
    " backtrace to last non-empty line
    while empty(getline(linenr))
        let linenr -= 1
    endwhile
    let e = append(linenr, ['', '---', '', strftime('# %d/%m/%y')])
    if !e
        let &modified = 1
    endif
    silent execute 'normal ' . line('$'). 'gg2o'
endfunc
