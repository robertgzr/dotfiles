if !exists('g:loaded_clap')
  finish
endif

let g:clap_selected_sign = { 'text': '* ', 'texthl': "WarningMsg", "linehl": "ClapSelected" }

nnoremap <leader>cc :Clap<CR>
nmap <leader>cg :Clap grep<CR>
