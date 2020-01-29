" backup aerc mails to a draft directory
let g:mail_draft_dir = $HOME.'/.aerc/drafts'

function! SaveDraft()
    if !isdirectory(g:mail_draft_dir)
	call mkdir(g:mail_draft_dir, 'p')
    endif
    let draft = join([g:mail_draft_dir, expand('%:t')], '/')
    execute 'silent! write! '.draft
endfunction

function! RestoreFromDraft()
    let draft = join([g:mail_draft_dir, expand('%:t')], '/')
    echoerr 'todo'
endfunction

augroup vim_mail
    au!
    au CursorHold * call SaveDraft()
augroup END

set commentstring=>\ %s
set showtabline=0
