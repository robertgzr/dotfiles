function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

" starting to use vim a little more
"" Plugin Manager
call plug#begin('~/.vim/plugged')
    " colorschemes
    " Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
    Plug 'mhinz/vim-janah'
    Plug 'trusktr/seti.vim'
    Plug 'morhetz/gruvbox'
    " interface
    Plug 'itchyny/lightline.vim'
    Plug 'shinchu/lightline-gruvbox.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'junegunn/goyo.vim', {'for': 'markdown'}
    Plug 'junegunn/limelight.vim', {'for': 'markdown'}
    " ux
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'tpope/vim-commentary'
    Plug 'chiel92/vim-autoformat'
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/syntastic'
    Plug 'godlygeek/tabular'
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-startify'
    Plug 'raimondi/delimitmate'
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-session'
    Plug 'DrawIt'
    " neo stuff
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neosnippet-snippets'
    " lang specific
    Plug 'zchee/deoplete-go'
""    Plug 'zchee/deoplete-clang'
    Plug 'fatih/vim-go', {'for': 'go'}
    Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}
    Plug 'peterhoeg/vim-qml', {'for': 'qml'}
    Plug 'rust-lang/rust.vim', {'for': 'rust'}
    Plug 'suoto/vim-hdl', {'for': 'vhdl'}
    Plug 'othree/html5.vim', {'for': 'html'}
    Plug 'posva/vim-vue', {'for': 'vue'}
    " TODO:
    " c/cpp
    " java
    " python
    Plug 'equalsraf/neovim-gui-shim'
call plug#end()
