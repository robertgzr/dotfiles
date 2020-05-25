if !has('nvim-0.5.0')
  " echoerr 'nvim_lsp only works with neovim>=0.5.0'
  finish
endif

lua << EOF
local lsp   = require 'nvim_lsp'
local util  = require 'nvim_lsp/util'
local compl = require 'completion'

lsp.gopls.setup{
  on_attach = compl.on_attach;
  root_dir = util.root_pattern("go.mod");
}
EOF

" autocmd Filetype bash,shell,css,go,python,rust,tex,latex setl omnifunc=lsp#omnifunc
" au Filetype lua setl omnifunc=v:lua.vim.lsp.omnifunc

nnoremap <silent> gd  :call lsp#text_document_definition()<CR>
nnoremap <silent> gdc :call lsp#text_document_declaration()<CR>
nnoremap <silent> gt  :call lsp#text_document_type_definition()<CR>
nnoremap <silent> gi  :call lsp#text_document_implementation()<CR>
nnoremap <silent> ;h  :call lsp#text_document_hover()<CR>
nnoremap <silent> ;s  :call lsp#text_document_signature_help()<CR>
