" not sure if I am using this 
finish

if exists('g:loaded_fasd')
  finish
endif
let g:loaded_fasd = 1
let g:fasd_path = '/home/robert/.dotfiles/zsh/.zplug/repos/sorin-ionescu/prezto/modules/fasd/external/fasd'

function! fasd#run(args) abort
  return system(g:fasd_path . ' -d -0 ' . a:args)
endfunction

function! fasd#cd(args) abort
  execute 'tcd' . fasd#run(a:args)
endfunction

command! -nargs=1 J :call fasd#cd(<f-args>)
