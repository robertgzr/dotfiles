function! s:lightline_update(colors)
    if !exists('g:loaded_lightline')
        return
    endif
    try
        let g:lightline.colorscheme = a:colors
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    catch
    endtry
endfunction

function! daymode#switch(bang)
    if a:bang
        set background=dark
        execute 'colorscheme' get(g:, 'daymode_colorscheme_night', 'default')
        call s:lightline_update(get(g:, 'daymode_lightline_colorscheme_night', 'PaperColor'))
    else
        set background=light
        execute 'colorscheme' get(g:, 'daymode_colorscheme_day', 'default')
        call s:lightline_update(get(g:, 'daymode_lightline_colorscheme_day', 'PaperColor'))
    endif

    if exists("syntax_on")
        syntax reset
    endif
endfunction
