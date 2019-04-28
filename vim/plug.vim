" get plug.vim if it's not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Core
    " Plug 'tpope/vim-fugitive' " integration
    Plug 'airblade/vim-gitgutter' " line status next to line nums
    Plug 'tpope/vim-commentary' " auto-comment using `gcc`
    Plug 'cohama/lexima.vim' " auto-close parens, brackets, etc.
    Plug 'tpope/vim-surround' " edit surroundings in pairs
    Plug 'itchyny/lightline.vim' " lightweight status bar
    Plug 'neomake/neomake'
    " Plug 'sbdchd/neoformat', { 'on': 'Neoformat' } " async code formatter
    " Plug 'tpope/vim-obsession'

    " completion
    Plug 'neoclide/coc.nvim', { 'do': {-> coc#util#install()} }

    " snippets
    Plug 'Shougo/neosnippet'
      \ | Plug 'Shougo/neosnippet-snippets'

    " search
    " Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
      " \ |Plug 'junegunn/fzf.vim'
    Plug 'lotabout/skim', {'dir': '~/.skim', 'do': './install'}

    Plug 'justinmk/vim-dirvish' " folder browser
    " Plug 'easymotion/vim-easymotion' " sophisiticated vim motions
    " Plug 'bling/vim-bufferline' " needed to put buffers into tabline
    Plug 'justinmk/vim-sneak' " powerful missing vim motions

" Misc
    Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' } " auto-align code
    " Plug 'tpope/vim-sleuth' " auto-set shiftwidth and expandtab options
    Plug 'nathanaelkane/vim-indent-guides' " show indentation levels
    " Plug 'yggdroot/indentLine' " show indentation levels
    " visually match HTML tags enclosing cursor location
    Plug 'valloric/matchtagalways', { 'for': ['html', 'vue', 'xml'] }
    Plug 'tpope/vim-repeat' " extend '.' to plugins
    " Plug 'ludovicchabant/vim-gutentags' " manage tags files

    " Plug 'majutsushi/tagbar' " code minimap via ctags
    Plug 'liuchengxu/vista.vim'

    " Plug 'chiel92/vim-autoformat', { 'on': 'Autoformat' } " Format code with one button press!
    " Plug 'tweekmonster/braceless.vim' " text objects and folding for braceless languages
    Plug 'mattn/emmet-vim', { 'for': ['html', 'vue'] } " super-fast HTML editing
    " Plug 'tpope/vim-ragtag', { 'for': ['html', 'xml', 'markdown'] } " auto-close HTML/XML tags
    Plug 'editorconfig/editorconfig-vim'
    " Plug 'tweekmonster/nvimdev.nvim'
    Plug 'rhysd/conflict-marker.vim'

" WhoaDude
    " Plug 'lilydjwg/colorizer' " set background of colour to that colour
    Plug 'RRethy/vim-hexokinase'
    " Plug 'DrawIt', {'on': 'DIstart'} " draw ascii arrows/boxes
    " Plug 'hkupty/nvimux', { 'branch': 'lua' }
    " Plug 'christoomey/vim-tmux-navigator'
    " Plug 'edkolev/tmuxline.vim'
    Plug 'jceb/vim-orgmode'
      \ | Plug 'tpope/vim-speeddating'
      \ | Plug 'vim-scripts/utl.vim'
    " Plug 'spolu/dwm.vim'
    Plug 'robertgzr/vim-orgdown'

" Languages
    Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
    Plug 'rhysd/vim-grammarous', { 'for': ['markdown', 'latex', 'tex' ] }
    Plug 'lervag/vimtex', {'for': ['latex', 'tex']}
    Plug 'plasticboy/vim-markdown', {'for': 'markdown'}

    " multi-language support with lazy loading
    " NOTE: put language specific plugs before this to avoid conflicsts
    Plug 'sheerun/vim-polyglot'


" Minimal UX
    Plug 'junegunn/goyo.vim',         { 'on': 'Goyo' }
    Plug 'junegunn/limelight.vim',    { 'on': 'Limelight' }

    Plug 'equalsraf/neovim-gui-shim'

" Colorschemes
    Plug 'deviantfero/wpgtk.vim'
    Plug 'KeitaNakamura/neodark.vim'
    Plug 'NLKNguyen/papercolor-theme'
    " Plug 'crusoexia/vim-dracula'

" Local
    " Plug '~/devel/projects/nihon-theme/vim'
    Plug '~/devel/projects/vim-orgdown'
    Plug '~/devel/projects/vim-fuzz'

call plug#end()
