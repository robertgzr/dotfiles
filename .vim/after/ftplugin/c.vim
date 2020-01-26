setlocal cindent

setlocal foldmethod=syntax
setlocal foldlevel=10

if exists('g:loaded_gutentags')
    let g:gutentags_enabled = 1
endif

" toggle between header and implementation in c/cpp
function! Alternate_c()
    let file = expand('%')
    if match(file, '\.c') > 0
        exe ':e %<.h'
    elseif match(file, '\.h') > 0
        exe ':e %<.c'
    endif
endfunction

nmap <Leader>a :call alternate#alternate()

" source: https://github.com/igankevich/mesonic/blob/master/plugin/meson.vim
function! MesonProjectDir()
    let l:dir = getcwd()      " a starting directory to look for meson.build file
    let l:project_dir = l:dir " the top-most directory with meson.build file
    let l:nesting = 100       " maximal no. of subdirectories in a project

    " find top-most directory with readable meson.build file
    while fnamemodify(l:dir, ':p') !=# '/' && l:nesting > 0
	    if filereadable(l:dir . '/' . 'meson.build')
		    let l:project_dir = l:dir
	    endif
	    let l:dir = l:dir . '/..'
	    let l:nesting = l:nesting - 1
    endwhile

    " why one needs to do it two times?
    let l:project_dir = fnamemodify(l:project_dir, ':p')
    let l:project_dir = fnamemodify(l:project_dir, ':p')
    return l:project_dir
endfunction

if exists('g:loaded_neomake')
    function! s:ninja_InitForJob(_jobinfo) dict
	" set cwd to project dir
	if !has_key(self, 'cwd')
	    let self.cwd = MesonProjectDir()
	endif
	" generate new error format lines
	" source: https://github.com/igankevich/mesonic/blob/master/compiler/meson.vim#L67
	if !has_key(self, 'errorformat')
	    let g:meson_error_format = [
	    \ '%EMeson encountered an error in file ' . l:project_subdir . '%f\, line %l\, column %c:,%Z%m',
	    \ '%Dninja: Entering directory `%f''',
	    \ '%f:%l.%c-%[%^:]%#: %t%[%^:]%#: %m'
	    \ ]
	    let self.errorformat = join(g:meson_error_format, ',')
	endif
	return self
    endfunction
    function! s:ninja_postprocess(entry)
	if empty(a:entry.type)
	    let a:entry.type = 'E'
	endif
    endfunction
    let g:neomake_c_ninja_maker = {
    \ 'exe': 'ninja',
    \ 'args': ['-C', 'build'],
    \ 'append_file': 0,
    \ 'postprocess': function('s:ninja_postprocess'),
    \ 'InitForJob': function('s:ninja_InitForJob'),
    \ }
    let g:neomake_c_ninjaclean_maker = {
    \ 'exe': 'ninja',
    \ 'args': ['-C', 'build', 'clean'],
    \ 'append_file': 0,
    \ 'postprocess': function('s:ninja_postprocess'),
    \ 'InitForJob': function('s:ninja_InitForJob'),
    \ }
    let g:neomake_c_enabled_makers = ['ninja']
endif
