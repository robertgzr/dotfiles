if !(has('nvim') && exists('*nvim_win_set_config'))
    echoerr "floating window not supported"
    finish
endif

if exists('g:nvim_popup_loaded')
    finish
endif
let g:nvim_popup_loaded = 1

let s:popup = {}

function! s:popup__floating_win_opts(width, height) dict abort
    let bottom_line = line('w0') + winheight(0) - 1
    if self.opened_at[1] + a:height <= bottom_line
        let vert = 'N'
        let row = 1
    else
        let vert = 'S'
        let row = 0
    endif
    if self.opened_at[2] + a:width <= &columns
        let hor = 'W'
        let col = 0
    else
        let hor = 'E'
        let col = 1
    endif
    return {
    \ 'style': 'minimal',
    \ 'relative': 'cursor',
    \ 'anchor': vert.hor,
    \ 'row': row,
    \ 'col': col,
    \ 'width': a:width,
    \ 'height': a:height,
    \ }
endfunction
let s:popup.floating_win_opts = funcref('s:popup__floating_win_opts')

function! s:popup__window_size() dict abort
    let max_width = winwidth(0) / 2
    let max_height = winheight(0) / 3
    let width = 0
    let height = 0
    for line in self.contents
	let lw = strdisplaywidth(line)
	if lw > width
	    if lw > max_width
		let height += lw / popup_max_width + 1
		let width = popup_max_width
		continue
	    endif
	    let width = lw
	endif
        let height += 1
    endfor
    let width += 1

    if height > max_height
	let height = max_height
    endif

    return [width, height]
endfunction
let s:popup.window_size = funcref('s:popup__window_size')

function! s:popup__get_winnr() dict abort
    return win_id2win(self.win_id)
endfunction
let s:popup.get_winnr = funcref('s:popup__get_winnr')

function! s:popup__get_opener_winnr() dict abort
    let winnr = win_id2win(self.opener_winid)
    if winnr != 0
        return winnr
    endif
    let winnr = bufwinnr(self.opener_bufnr)
    if winnr > 0
        return winnr
    endif
    return 0
endfunction
let s:popup.get_opener_winnr = funcref('s:popup__get_opener_winnr')

function! s:popup_open() dict abort
    let self.opened_at = getpos('.')
    let self.opener_bufnr = bufnr('%')
    let self.opener_winid = win_getid()
    let self.type = 'floating'

    let [w, h] = self.window_size()

    if self.type ==# 'floating'
	let opts = self.floating_win_opts(w, h)
	let win_id = nvim_open_win(self.opener_bufnr, v:true, opts)
    endif

    enew!
    let popup_bufnr = bufnr('%')
    setlocal
        \ buftype=nofile bufhidden=hide nomodified nobuflisted noswapfile nonumber
        \ nocursorline wrap nonumber norelativenumber signcolumn=no nofoldenable
        \ nospell nolist nomodeline
    if has_key(self.opts, 'filetype')
	let &l:filetype = self.opts.filetype
    endif

    call setline(1, self.contents)
    setlocal nomodified nomodifiable

    if has('nvim')
	setlocal winhl=Normal:NormalFloat,NormalNC:NormalFloat
    endif

    nnoremap <buffer><silent><nowait><Esc> :<C-u>call b:__popup.close()<CR>
    nnoremap <buffer><silent><nowait>q :<C-u>call b:__popup.close()<CR>

    let b:__popup = self
    execute 'autocmd BufWipeout,BufLeave <buffer> call getbufvar(' . popup_bufnr . ', "__popup").close()'

    if has_key(self.opts, 'enter') && !self.opts.enter
	wincmd p
    endif
    
    let self.bufnr = popup_bufnr
    let self.win_id = win_id
endfunction
let s:popup.open = funcref('s:popup_open')

function! s:popup__close() dict abort
    if !has_key(self, 'bufnr')
	return
    endif

    let winnr = self.get_winnr()
    if winnr > 0
	noautocmd execute winnr . 'wincmd c'
    endif

    unlet self.bufnr
    unlet self.win_id
endfunction
let s:popup.close = funcref('s:popup__close')

function! s:popup__scroll(map) dict abort
    let winnr = self.get_winnr()
    if winnr == 0
        return
    endif
    execute winnr . 'wincmd w'
    sandbox let input = eval('"\<'.a:map.'>"')
    execute 'normal!' input
    wincmd p
endfunction
let s:popup.scroll = funcref('s:popup__scroll')

function! s:popup__update() dict abort
    " Note: `:noautocmd` to prevent BufLeave autocmd event (#13)
    " It should be ok because the cursor position is finally back to the first
    " position.

    let prev_winnr = winnr()

    let popup_winnr = self.get_winnr()
    if popup_winnr == 0
        return
    endif
    let opener_winnr = self.get_opener_winnr()
    if opener_winnr == 0
        return
    endif

    if opener_winnr != prev_winnr
        noautocmd execute opener_winnr . 'wincmd w'
    endif

    try
        let [width, height] = self.window_size()

        " Window must be configured in opener buffer since the window position
        " is relative to cursor
        if self.type ==# 'floating'
            let id = win_getid(popup_winnr)
            if id == 0
                return
            endif
            let opts = self.floating_win_opts(width, height)
            call nvim_win_set_config(id, opts)
        endif

        noautocmd execute popup_winnr . 'wincmd w'

        if self.type ==# 'preview'
            execute height . 'wincmd _'
        endif

        setlocal modifiable
        silent %delete _
        call setline(1, self.contents)
        setlocal nomodified nomodifiable
    finally
        if winnr() != prev_winnr
            noautocmd execute prev_winnr . 'wincmd w'
        endif
    endtry
endfunction
let s:popup.update = funcref('s:popup__update')

function! popup#new(opts) abort
    let p = deepcopy(s:popup)
    let opts = { 'floating': v:true }
    let p.opts = extend(opts, a:opts)
    return p
endfunction
