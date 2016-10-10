" closes vim if last buffer is NERDTree
" autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
" let g:NERDTreeDirArrowExpandable = '+'
" let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapOpenSplit = 'x'
let g:NERDTreeMapCloseChildren = 'I'
let g:NERDTreeMapCloseDir = 'i'
let g:NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "Δ",
    \ "Staged"    : "+",
    \ "Untracked" : "?",
    \ "Renamed"   : "▷",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "†",
    \ "Dirty"     : "✘",
    \ "Clean"     : "✔",
    \ "Unknown"   : "¿"
    \ }
