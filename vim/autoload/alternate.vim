function! alternate#alternate()
    let l:function_name = 'Alternate_' . &filetype
    if exists('*' . l:function_name)
        execute l:function_name
    else
        echo 'no alternate function defined for "' . &filetype . '"'
    endif
endfunction
