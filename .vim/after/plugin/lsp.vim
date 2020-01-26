" if !has('nvim-0.5.0')
"   echoerr 'nvim_lsp only works with neovim>=0.5.0'
"   finish
" endif
finish

silent LspInstall bashls
silent LspInstall cssls

" call nvim_lsp#setup("gopls", {})
call nvim_lsp#setup("pyls", {})
call nvim_lsp#setup("rust_analyzer", {})
call nvim_lsp#setup("texlab", {})

autocmd Filetype bash,shell,css,go,python,rust,tex,latex setl omnifunc=lsp#omnifunc

nnoremap <silent> gd  :call lsp#text_document_definition()<CR>
nnoremap <silent> gdc :call lsp#text_document_declaration()<CR>
nnoremap <silent> gt  :call lsp#text_document_type_definition()<CR>
nnoremap <silent> gi  :call lsp#text_document_implementation()<CR>
nnoremap <silent> ;h  :call lsp#text_document_hover()<CR>
nnoremap <silent> ;s  :call lsp#text_document_signature_help()<CR>
