set keywordprg=:GitShow
command! -nargs=1 -bar GitShow call s:git_show(<f-args>)

function! s:git_show(commit) abort
    let p = popup#new({ 'filetype': 'diff' })
    let p.contents = systemlist("git show ".a:commit)
    call p.open()
endfunction
