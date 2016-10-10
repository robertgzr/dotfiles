let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
" Limelight
"
let g:limelight_default_coefficient = 0.5
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1
" DISTRACTION FREE MODE FOR VIM
" autocmd! User GoyoEnter Limelight
" autocmd! User GoyoLeave Limelight!
" Goyo
"
" augroup goyo_markdown
"     autocmd!
"     autocmd BufNewFile,BufRead * call s:auto_goyo()
" augroup END
" " Activate Goyo on Markdown
" function! s:auto_goyo()
"     if &ft == 'markdown'
"         Goyo 80
"     elseif exists('#goyo')
"         let bufnr = bufnr('%')
"         Goyo!
"         execute 'b '.bufnr
"     endif
" endfunction
