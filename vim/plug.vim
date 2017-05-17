" Plugin Manager
call plug#begin('~/.vim/plugged')

" Core
    Plug 'tpope/vim-fugitive' " integration
    Plug 'airblade/vim-gitgutter' " line status next to line nums
    Plug 'tpope/vim-commentary' " auto-comment using `gcc`
    Plug 'cohama/lexima.vim' " auto-close parens, brackets, etc.
    Plug 'tpope/vim-surround' " edit surroundings in pairs
    Plug 'itchyny/lightline.vim' " lightweight status bar
    " Plug 'neomake/neomake'
    " Plug 'sbdchd/neoformat' " async code formatter
    Plug 'w0rp/ale' " linter framework
    " Language Server Client
    " Plug 'autozimu/LanguageClient-neovim',    { 'do': ':UpdateRemotePlugins' }
    " completion
    Plug 'Shougo/deoplete.nvim',              { 'do': ':UpdateRemotePlugins' }
        Plug 'Shougo/deoplete-rct',           { 'for': 'ruby' }
        Plug 'zchee/deoplete-go',             { 'for': 'go', 'do': 'make' }
        " Plug 'zchee/deoplete-clang',          { 'for': ['cpp', 'c', 'objc'] }
        Plug 'tweekmonster/deoplete-clang2',  { 'for': ['cpp', 'c', 'objc'] }
        Plug 'zchee/deoplete-jedi',           { 'for': 'python' }
        Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }
    Plug 'Shougo/echodoc.vim' " print completed documentation into command line
    " snippets
    Plug 'Shougo/neosnippet'
        Plug 'Shougo/neosnippet-snippets'
    " git
    " search
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
        Plug 'junegunn/fzf.vim'

    Plug 'justinmk/vim-dirvish' " folder browser
    Plug 'easymotion/vim-easymotion' " sophisiticated vim motions

" Misc
    Plug 'junegunn/vim-easy-align' " auto-align code
    Plug 'tpope/vim-sleuth' " auto-set shiftwidth and expandtab options
    Plug 'nathanaelkane/vim-indent-guides' " show indentation levels
    " Plug 'yggdroot/indentLine' " show indentation levels
    Plug 'valloric/matchtagalways' " visually match HTML tags enclosing cursor location
    " Plug 'tpope/vim-repeat' " extend .-repeat to plugins
    " Plug 'ludovicchabant/vim-gutentags' " manage tags files
    Plug 'majutsushi/tagbar' " code minimap via ctags
    " Plug 'chiel92/vim-autoformat', { 'on': 'Autoformat' } " Format code with one button press!
    " Plug 'tweekmonster/braceless.vim' " text objects and folding for braceless languages
    Plug 'mattn/emmet-vim', { 'for': 'html' } " super-fast HTML editing
    Plug 'tpope/vim-ragtag', { 'for': ['html', 'xml', 'markdown'] } " auto-close HTML/XML tags
    Plug 'editorconfig/editorconfig-vim'

" WhoaDude
    Plug 'lilydjwg/colorizer' " set background of colour to that colour
    " Plug 'DrawIt', {'on': 'DIstart'} " draw ascii arrows/boxes
    " Plug 'hkupty/nvimux'

" Languages
    " multi-language support with lazy loading
    Plug 'sheerun/vim-polyglot'
    Plug 'fatih/vim-go',         { 'for': 'go'}
    Plug 'racer-rust/vim-racer', { 'for': 'rust' }
    Plug 'timonv/vim-cargo',     { 'for': 'rust' }
    Plug 'posva/vim-vue',        { 'for': 'vue' }
    " Plug 'suoto/vim-hdl',        { 'for': 'vhdl'}

" Minimal UX
    Plug 'junegunn/goyo.vim',         { 'on': 'Goyo' }
    Plug 'junegunn/limelight.vim',    { 'on': 'Limelight' }

" Colorschemes
    " Plug 'sonph/onehalf', { 'rtp': 'vim/' }
    " Plug 'aereal/vim-colors-japanesque', { 'branch': 'robertgzr' }
    Plug 'KeitaNakamura/neodark.vim'
    " Plug 'iCyMind/NeoSolarized'
    " Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
    " Plug 'trusktr/seti.vim'
    " Plug 'morhetz/gruvbox'
    " Plug 'shinchu/lightline-gruvbox.vim'
call plug#end()
