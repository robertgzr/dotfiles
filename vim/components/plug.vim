function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

" starting to use vim a little more
"" Plugin Manager
call plug#begin('~/.vim/plugged')
    " colorschemes
    Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
    Plug 'mhinz/vim-janah'
    " interface
    Plug 'itchyny/lightline.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    " ux
    Plug 'godlygeek/tabular'
    Plug 'scrooloose/syntastic'
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-startify'
    Plug 'raimondi/delimitmate'
    " Shougo's neo stuff
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
    Plug 'zchee/deoplete-go', { 'do': 'make' }
    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neosnippet-snippets'
    " lang specific
    Plug 'fatih/vim-go', {'for': 'go'}
    Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}
    " TODO:
    " c/cpp
    " java
    " python
call plug#end()
