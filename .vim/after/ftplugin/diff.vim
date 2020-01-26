" disable annoying plugins
let b:coc_enabled = 0
silent NeomakeDisable

command! FindMergeMarker execute 'normal /^<<<<<<</<CR>'

" shortcuts for 3-way merges
command! DiffGetLocal :diffget LOCAL
command! DiffGetRemote :diffget REMOTE
" quicksave
command! DiffSave :wqa

cnoreabbrev fmm FindMergeMarker
cnoreabbrev dgl DiffGetLocal
cnoreabbrev dgr DiffGetRemote
cnoreabbrev ds DiffSave


let s:markers = {
      \ 'ours': '^<<<<<<< ',
      \ 'theirs': '^>>>>>>> ',
      \ 'base': '^||||||| ',
      \ 'delimiter': '^=======\r\?$',
      \ }

if &diff
    " set custom ctags in diff mode

    let _ft=&filetype
    let g:vista_ctags_cmd = {
    \ _ft: 'ctags --format=2 --excmd=pattern --fields=nksSaf --file-scope=yes --sort=no --append=no --output-format=json --fields=-PF -f-',
    \ }
endif
