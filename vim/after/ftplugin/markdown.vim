if exists('g:loaded_lexima')
    call lexima#add_rule({'char': '<Space>', 'at': '* \[\%#]', 'insert_after': '', 'filetype': 'markdown'})
    call lexima#add_rule({'char': '<Space>', 'at': '\[ \%#]', 'insert_after': '<Space>', 'filetype': 'markdown'})
endif

function! s:markdown_underline()
    yank 1
    put
    substitute/./=/g
endfunction
command! -nargs=0 Underline call s:markdown_underline()
