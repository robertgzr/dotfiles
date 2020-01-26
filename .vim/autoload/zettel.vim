" note taking helpers
" to aide in practicing the zettelkasten.de system
"
" ref: https://vimways.org/2019/personal-notetaking-in-vim/

let g:zettel_dir = '~/wiki'
let g:zettel_ext = '.md'

func! zettel#is_zettel(fpath)
    if a:fpath =~ g:zettel_dir . '/.*' . g:zettel_ext . '$' | return 1 | en
    return 0
endfunc

func! zettel#set_filetype()
    silent exec 'setlocal filetype=zettel.' . &filetype
endfunc

func! zettel#edit(...)
    let l:sep = ''
    if len(a:000) > 0
        " argument is a title for the note
        let l:sep = '-'
    endif
    let l:fname = expand(g:zettel_dir) . '/'
        \ . strftime('%Y-%m-%dT%H-%M')
        \ . l:sep . join(a:000, l:sep) . g:zettel_ext

    silent exec 'e ' . l:fname

    " if len(a:000) > 0
    "     silent exec 'normal gg0\<c-r>=strftime("%Y-%m-%d %H:%M")\<cr> '
    "         \ . join(a:000)
    "         \ . '\<cr>\<esc>G'
    " else
    "     silent exec 'normal gg0\<c-r>=strftime("%Y-%m-%d %H:%M")\<cr>\<cr>\<esc>G'
    " endif
endfunc
