let g:nvimux_open_term_by_default=1

" override mappings
let g:nvimux_custom_bindings = [
    \['\|', ':NvimuxVerticalSplit<CR>', ['n', 'v', 'i', 't']],
    \['\-', ':NvimuxHorizontalSplit<CR>', ['n', 'v', 'i', 't']]
\]
