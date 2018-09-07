source ~/.vim/user/writing.vim

let g:markdown_syntax_conceal = 1

if exists('g:loaded_lexima')
    call lexima#add_rule({'char': '<Space>', 'at': '* \[\%#]', 'insert_after': '', 'filetype': 'markdown'})
    call lexima#add_rule({'char': '<Space>', 'at': '\[ \%#]', 'insert_after': '<Space>', 'filetype': 'markdown'})
endif
