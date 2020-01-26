function! s:prompt(str)
  return a:str . g:fuzz_prompt . ' '
endfunction

function! s:fuzz(name, opts)
  " call skim#run(skim#wrap(a:name, a:opts, 0))
  call fzf#run(fzf#wrap(a:name, a:opts, 0))
endfunction

function! s:strip(str)
  return substitute(a:str, '^\s*\|\s*$', '', 'g')
endfunction

function! s:open(cmd, target)
  if stridx('edit', a:cmd) == 0 && fnamemodify(a:target, ':p') ==# expand('%:p')
    return
  endif
  execute a:cmd fnameescape(a:target)
endfunction


" rg {{{
function s:map_rg_output(line)
  let parts = split(a:line, ':')
  return {'filename': &acd ? fnamemodify(parts[0], ':p') : parts[0], 'lnum': parts[1], 'text': join(parts[2:], ':')}
endfunction

function s:rg_handler(lines)
  if len(a:lines) < 1
    return
  endif
  let first = map(filter(a:lines, 'len(v:val)'), 's:map_rg_output(v:val)')[0]
  call s:open('edit', first.filename)
  execute first.lnum
  normal! zz
endfunction

function s:rg(prompt, ...)
  if !executable('rg')
    echoerr 'rg not found'
    return
  endif
  if len(a:000) < 1 || len(a:000[0]) < 1
    echoerr 'no arguments'
    return
  endif

  call s:fuzz(!empty(a:prompt) ? tolower(a:prompt) : 'rg', {
  \ 'source': 'rg --line-number --no-heading --color=always --smart-case '.join(a:000[0], ' '),
  \ 'sink*': function('s:rg_handler'),
  \ 'options': ['--prompt', s:prompt(!empty(a:prompt) ? a:prompt : 'Rg'),
  \             '--ansi', '--multi']
  \ })
endfunction

function! fuzz#rg(args) abort
  call s:rg('', a:args)
endfunction
" }}}

" files {{{
function! fuzz#files() abort
  call s:fuzz('files', {
  \ 'options': ['--prompt', s:prompt('Fs')]
  \ })
endfunction
" }}}

" buffers {{{
function! s:buffers_list()
  function! s:buflisted()
    return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
  endfunction

  function! s:format_buffer(b)
    let name = bufname(a:b)
    let name = empty(name) ? '[No Name]' : fnamemodify(name, ":p:~:.")
    let flag = a:b == bufnr('')  ? '%' :
            \ (a:b == bufnr('#') ? '#' : ' ')
    let modified = getbufvar(a:b, '&modified') ? ' [+]' : ''
    let readonly = getbufvar(a:b, '&modifiable') ? '' : ' [RO]'
    let extra = join(filter([modified, readonly], '!empty(v:val)'), '')
    return s:strip(printf("[%s] %s\t%s\t%s", a:b, flag, name, extra))
  endfunction

  return map(sort(s:buflisted()), 's:format_buffer(v:val)')
endfunction

function! s:buffers_handler(lines)
  if len(a:lines) < 1
    return
  endif
  let b = matchstr(a:lines[0], '\[\zs[0-9]*\ze\]')
  execute 'buffer' b
endfunction

function! fuzz#buffers() abort
  call s:fuzz('buffers', {
  \ 'source': s:buffers_list(),
  \ 'sink*': function('s:buffers_handler'),
  \ 'options': ['--prompt', s:prompt('Buf')]
  \ })
endfunction
" }}}

" commands {{{
function! s:command_handler(lines)
  if len(a:lines) < 1
    return
  endif
  call feedkeys(':'.a:lines[0])
endfunction

function! fuzz#commands() abort
  call s:fuzz('commands', {
  \ 'source': sort(getcompletion('', 'command')),
  \ 'sink*': function('s:command_handler'),
  \ 'options': ['--prompt', s:prompt('Cmd')]
  \ })
endfunction
" }}}

function! fuzz#cmdoptions(...) abort
  let opts = sort(['files', 'buffers', 'commands', 'rg'])
  return join(opts, "\n")
endfunction

function! fuzz#exec(cmd, ...) abort
  if a:cmd == 'files'
    call fuzz#files()
  elseif a:cmd == 'buffers'
    call fuzz#buffers()
  elseif a:cmd == 'commands'
    call fuzz#commands()
  elseif a:cmd == 'rg'
    call fuzz#rg(a:000)
  else
    echoerr 'Unknown command ' . a:cmd
  endif
endfunction
