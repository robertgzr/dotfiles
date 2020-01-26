let s:spt = {}

function! s:spt_open() dict abort
    botright new
    exec "resize " . self.opts.height
    try
        exec "buffer " . self.bufnr
    catch
        call termopen(self.opts.exec, {"detach": 0})
        let self.bufnr = bufnr('%')
        " term style
        set nonumber
        set norelativenumber
        set signcolumn=no
        " garbage collect after closing
        let b:__split_term = self
        execute 'autocmd BufWipeout <buffer> call getbufvar(' . self.bufnr . ', "__split_term").close()'
    endtry
    startinsert!
    let self.winid = win_getid()
endfunction
let s:spt.open = funcref('s:spt_open')

function! s:spt_hide() dict abort
    if win_gotoid(self.winid)
        hide
    else
        echoerr 'split term window not found'
    endif
endfunction
let s:spt.hide = funcref('s:spt_hide')

function! s:spt_close() dict abort
    if win_gotoid(self.winid)
        close
    endif
    unlet self.bufnr
    unlet self.winid
endfunction
let s:spt.close = funcref('s:spt_close')

function! split_term#new(opts) abort
    let spt = deepcopy(s:spt)
    let opts = { 
    \ 'exec': $SHELL,
    \ 'height': 20,
    \ }
    let spt.opts = extend(opts, a:opts)
    return spt
endfunction

function! s:split_term_new(args) abort
    if len(a:args) > 0
        let opts = {'exec': join(a:args, ' ')}
    endif
    let g:split_term = split_term#new(exists('opts') ? opts : {})
endfunction
function! s:split_term_toggle(bang, ...) abort
    if !a:bang
        if !exists('g:split_term')
            call s:split_term_new(a:000)
        endif
        call g:split_term.open()
    else
        if exists('g:split_term')
            call g:split_term.hide()
        endif
    endif
endfunction
