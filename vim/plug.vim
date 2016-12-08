" Plugin Manager
" TODO: write plugin documentation
call plug#begin('~/.vim/plugged')

" Core
    Plug 'tpope/vim-commentary'
    Plug 'raimondi/delimitmate'
    Plug 'tpope/vim-surround'
    Plug 'itchyny/lightline.vim'
    Plug 'neomake/neomake'
    " completion
    Plug 'Shougo/deoplete.nvim',              { 'do': ':UpdateRemotePlugins' }
        Plug 'zchee/deoplete-go',             { 'for': 'go', 'do': 'make' }
        Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }
        Plug 'zchee/deoplete-clang',          { 'for': ['cpp', 'c'] }
    " snippets
    Plug 'sirver/UltiSnips'
    	Plug 'honza/vim-snippets'
    " git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/vim-easy-align'
    " search
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
        Plug 'junegunn/fzf.vim'
    " meta
    Plug 'mhinz/vim-startify'
    Plug 'justinmk/vim-dirvish'
    Plug 'xolox/vim-session'

" Misc
    Plug 'majutsushi/tagbar'
    Plug 'nathanaelkane/vim-indent-guides'
    " Plug 'yggdroot/indentline'
    " Plug 'chiel92/vim-autoformat'
    Plug 'godlygeek/tabular'
    Plug 'xolox/vim-misc'
    Plug 'tpope/vim-repeat'
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    Plug 'tpope/vim-sleuth'
    Plug 'valloric/matchtagalways'
    Plug 'tweekmonster/braceless.vim'
    Plug 'Shougo/echodoc.vim'

" WhoaDude
    Plug 'DrawIt', {'on': 'DIstart'} " draw ascii arrows/boxes

" Languages
    Plug 'fatih/vim-go',              { 'for': 'go', 'do': ':GoInstallBinaries'}
    Plug 'rust-lang/rust.vim',        { 'for': 'rust'}
    Plug 'gabrielelana/vim-markdown', { 'for': 'markdown'}
    " Plug 'junegunn/goyo.vim',         { 'for': 'markdown'}
    " Plug 'junegunn/limelight.vim',    { 'for': 'markdown'}
    Plug 'peterhoeg/vim-qml',         { 'for': 'qml'}
    Plug 'suoto/vim-hdl',             { 'for': 'vhdl'}
    Plug 'othree/html5.vim',          { 'for': 'html'}
    Plug 'posva/vim-vue',             { 'for': 'vue'}
    Plug 'lervag/vimtex',             { 'for': 'tex'}
    Plug 'cespare/vim-toml',          { 'for': 'toml'}
    Plug 'uarun/vim-protobuf',        { 'for': 'proto'}
    " TODO:
        " java
        " python

" Colorschemes
    Plug 'iCyMind/NeoSolarized'
    " Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
    " Plug 'trusktr/seti.vim'
    " Plug 'morhetz/gruvbox'
    " Plug 'shinchu/lightline-gruvbox.vim'
call plug#end()
