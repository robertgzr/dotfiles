" language specific options

" Go
" --> in seperate go.vim file


" LaTeX

" let g:vimtex_view_general_viewer
"             \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
" let g:vimtex_view_general_options = '-r @line @pdf @tex'

" " This adds a callback hook that updates Skim after compilation
" let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
" function! UpdateSkim(status)
"     if !a:status | return | endif

"     let l:out = b:vimtex.out()
"     let l:tex = expand('%:p')
"     let l:cmd = [g:vimtex_view_general_viewer, '-r']
"     if !empty(system('pgrep Skim'))
"         call extend(l:cmd, ['-g'])
"     endif
"     if has('nvim')
"         call jobstart(l:cmd + [line('.'), l:out, l:tex])
"     elseif has('job')
"         call job_start(l:cmd + [line('.'), l:out, l:tex])
"     else
"         call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
"     endif
" endfunction


" Markdown
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
