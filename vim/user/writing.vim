" Configuration for writing text in vim

" Markdown
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1

" Grammer checker
let g:grammarous#languagetool_cmd = 'languagetool'

" writing autocommands
function! s:writing_mode_enter()
    set textwidth=120
    " ALEToggle
    " Grammarous keymaps
    nmap <Leader>c :GrammarousCheck --lang=de
    nmap <Leader>gi <Plug>(grammarous-move-to-info-window)
    nmap <Leader>gr <Plug>(grammarous-remove-error)
    nmap <Leader>gd <Plug>(grammarous-disable-rule)
    nmap <Leader>gf <Plug>(grammarous-fixit)
    nmap <Leader>gn <Plug>(grammarous-move-to-next-error)
    nmap <Leader>gp <Plug>(grammarous-move-to-previous-error)
endfunction

augroup writing
    autocmd!
    au FileType markdown,tex nested call <SID>writing_mode_enter()
augroup END

" Minimal UX for concentration
let g:goyo_width = 120
let g:goyo_height = 90
let g:goyo_linenr = 0

let g:limelight_default_coefficient = 0.5
let g:limelight_paragraph_span = 1
" let g:limelight_default_coefficient = 0.5
" let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

function! s:goyo_enter()
    if has('gui_running') || has('gui_vimr')
        " set linespace = 7

    elseif exists('$TMUX')
        silent !tmux set status off
    endif

    " set noshowmode
    " set noshowcmd
    set scrolloff=999
    Limelight

    " make sure :q in the last buffer, in Goyo also quits vim
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction
function! s:goyo_leave()
    if has('gui_running') || has('gui_vimr')
        " set linespace = 0

    elseif exists('$TMUX')
        silent !tmux set status on
    endif

    " set showmode
    " set showcmd
    set scrolloff=5
    Limelight!

    " make sure :q in the last buffer, in Goyo also quits vim
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
          qa!
        else
          qa
        endif
    endif
endfunction

" goyo autocommands
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nmap <F3> :Goyo<CR>
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
