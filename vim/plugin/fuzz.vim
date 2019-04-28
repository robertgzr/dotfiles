if exists('g:loaded_fuzz')
  finish
endif
let g:loaded_fuzz = 1

function! s:prompt(str)
  let l:sign = exists('g:fuzz_prompt') ? g:fuzz_prompt : '❯'
  return a:str . l:sign
endfunction

function! s:skim(name, opts)
  call skim#run(skim#wrap(a:name, a:opts, 0))
endfunction

function! s:strip(str)
  return substitute(a:str, '^\s*\|\s*$', '', 'g')
endfunction


" -- files -- "
function! fuzz#files()
  call s:skim('files', {
  \ 'options': ['--prompt', s:prompt('Fs')]
  \ })
endfunction
nmap <silent> ff :call fuzz#files()<CR>


" -- buffers -- "
function! fuzz#buffers()
  function! s:buflist()
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

  function! s:bufopen(lines)
    if len(a:lines) < 1
      return
    endif
    let b = matchstr(a:lines[0], '\[\zs[0-9]*\ze\]')
    execute 'buffer' b
  endfunction

  call s:skim('buffers', {
  \ 'source': s:buflist(),
  \ 'sink*': function('s:bufopen'),
  \ 'options': ['--prompt', s:prompt('Buf')]
  \ })
endfunction
nmap <silent> fb :call fuzz#buffers()<CR>


" -- commands -- "
function! fuzz#commands()
  function! s:cmdlist()
    return sort(getcompletion('', 'command'))
  endfunction

  function! s:cmdsink(lines)
    if len(a:lines) < 1
      return
    endif
    execute a:lines[0]
  endfunction

  call s:skim('commands', {
  \ 'source': s:cmdlist(),
  \ 'sink*': function('s:cmdsink'),
  \ 'options': ['--prompt', s:prompt('Cmd')]
  \ })
endfunction
nmap <silent> fc :call fuzz#commands()<CR>
