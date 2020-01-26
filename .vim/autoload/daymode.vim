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

let s:day_mode_previous_colorscheme = ''
let s:day_mode_previous_lightline_colorscheme = ''

function! daymode#switch(bang)
    if a:bang
        set background=dark
        execute 'colorscheme' s:day_mode_previous_colorscheme
        call s:lightline_update(s:day_mode_previous_lightline_colorscheme)
    else
        let s:day_mode_previous_colorscheme = g:colors_name
        let s:day_mode_previous_lightline_colorscheme = g:lightline.colorscheme

        set background=light
        execute 'colorscheme' get(g:, 'day_mode_colorscheme', 'morning')
        call s:lightline_update(get(g:, 'day_mode_lightline_colorscheme', 'PaperColor_light'))
    endif

    if exists("syntax_on")
        syntax reset
    endif
endfunction
