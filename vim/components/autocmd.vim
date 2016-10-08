"" Some Autocommands
"" For more see the components/plugin-settings.vim
" toggle spell-check if filetype is markdown
autocmd FileType markdown setlocal spell
" Disable tabs->spaces for Makefiles
autocmd FileType make setlocal noexpandtab
autocmd FileType c setlocal foldmethod=syntax

" autocmd BufWrite * :Autoformat
autocmd TextChanged,TextChangedI <buffer> silent write

" completion window
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd CompleteDone * if pumvisible() == 0|pclose|endif

" enable fugitive in dirvish
" autocmd FileType dirvish call fugitive#detect(@%)
