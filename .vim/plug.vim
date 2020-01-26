" get plug.vim if it's not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Core
  " Plug 'airblade/vim-gitgutter' " line status next to line nums
  Plug 'mhinz/vim-signify'      " git status in the sign column
  Plug 'tpope/vim-commentary'   " auto-comment using `gcc`
  Plug 'cohama/lexima.vim'      " auto-close parens, brackets, etc.
  Plug 'tpope/vim-surround'     " edit surroundings in pairs
  Plug 'itchyny/lightline.vim'  " lightweight status bar
  Plug 'neomake/neomake'        " async job runner
  Plug 'sbdchd/neoformat'       " async code formatter
  Plug 'justinmk/vim-dirvish'   " folder browser
  Plug 'justinmk/vim-sneak'     " powerful missing vim motions

  " Plug 'neovim/nvim-lsp'
  Plug 'SirVer/ultisnips'
    \| Plug 'honza/vim-snippets'

  " Plug 'neoclide/coc.nvim',
  "   \ { 'do': './install.sh nightly' }
  "   \| Plug 'neoclide/coc-snippets', { 'do': 'yarn install --frozen-lockfile' }
  "   \| Plug 'neoclide/coc-json',     { 'for': ['json'],   'do': 'yarn install --frozen-lockfile' }
  "   \| Plug 'neoclide/coc-rls',      { 'for': ['rust'],   'do': 'yarn install --frozen-lockfile' }
  "   \| Plug 'neoclide/coc-python',   { 'for': ['python'], 'do': 'yarn install --frozen-lockfile' }
  "   \| Plug 'neoclide/coc-yaml',     { 'for': ['yaml'],   'do': 'yarn install --frozen-lockfile' }
  "   \| Plug 'neoclide/coc-html',     { 'for': ['html'],   'do': 'yarn install --frozen-lockfile' }
  "   \| Plug 'neoclide/coc-css',      { 'for': ['css'],    'do': 'yarn install --frozen-lockfile' }
  "   \| Plug 'josa42/coc-go',         { 'for': ['go'],     'do': 'yarn install --frozen-lockfile' }
  "   \| Plug 'neoclide/coc-java',     { 'for': ['java'],   'do': 'yarn install --frozen-lockfile' }
  "   \| Plug 'neoclide/coc-emmet',    { 'for': ['html', 'css'],   'do': 'yarn install --frozen-lockfile' }
    " \| Plug '~/devel/upstream/github.com/microsoft/vscode-go', { 'for': ['go'] }

  " search
  " Plug 'junegunn/fzf',
  "   \ { 'dir': '~/.fzf', 'do': './install --all'}
    " \ |Plug 'junegunn/fzf.vim'
  " Plug 'lotabout/skim',
  "   \ { 'on': 'SK', 'dir': '~/.skim', 'do': './install'}

  Plug 'liuchengxu/vim-clap' " interactive finder / dispatcher

" Misc
  Plug 'junegunn/vim-easy-align',
    \ { 'on': ['EasyAlign', '<Plug>(EasyAlign)'] }
  Plug 'tpope/vim-sleuth'                " auto-set shiftwidth and expandtab options
  Plug 'nathanaelkane/vim-indent-guides' " show indentation levels
  Plug 'tpope/vim-repeat'                " extend '.' to plugins
  Plug 'liuchengxu/vista.vim'            " sidebar populated by coc, ctags, etc.
  Plug 'sgur/vim-editorconfig'           " implements editorconfig in vimscript
  Plug 'rhysd/conflict-marker.vim'
  Plug 'michaeljsmith/vim-indent-object' " adds indentation text-objects
  Plug 'kshenoy/vim-signature'           " toggle, display and navigate marks
  Plug 'RRethy/vim-hexokinase',
    \ { 'do': 'make hexokinase' }        " highlights color codes
  Plug 'rhysd/git-messenger.vim'         " git-blame in a popup
  Plug 'bling/vim-bufferline'            " needed to put buffers into tabline

  Plug 'kassio/neoterm',
    \ { 'on': ['T', 'Tnew'] }

" Languages
  " NOTE: these should only be loaded when they are required...
  " Plug 'fatih/vim-go',            { 'do': ':GoInstallBinaries' }
  " Plug 'rhysd/vim-grammarous',    { 'for': ['markdown', 'latex', 'tex'] }
  Plug 'lervag/vimtex',           { 'for': ['latex', 'tex'] }
  Plug 'plasticboy/vim-markdown', { 'for': ['markdown'] }
  Plug 'masukomi/vim-markdown-folding', { 'for': ['markdown'] }
  Plug 'mattn/emmet-vim',         { 'for': ['html', 'vue'] }        " super-fast HTML editing
  Plug 'valloric/matchtagalways', { 'for': ['html', 'vue', 'xml'] } " visually match HTML tags enclosing cursor location
  Plug 'ledger/vim-ledger',       { 'for': ['ledger'] }
  Plug 'jceb/vim-orgmode',        { 'for': ['org'] }
    \| Plug 'tpope/vim-speeddating'  " easy time/date incrementing
    \| Plug 'vim-scripts/utl.vim'    " follow links/urls
  Plug 'gentoo/gentoo-syntax',    { 'for': ['ebuild'] }

  " multi-language support with lazy loading
  " NOTE: put language specific plugs before this to avoid conflicsts
  Plug 'sheerun/vim-polyglot'

" Minimal UX
  Plug 'junegunn/goyo.vim',         { 'on': 'Goyo' }      " hide ui clutter
  Plug 'junegunn/limelight.vim',    { 'on': 'Limelight' } " dims colors
  " Plug 'equalsraf/neovim-gui-shim'

" Colorschemes
  " Plug 'deviantfero/wpgtk.vim'
  " Plug 'KeitaNakamura/neodark.vim'
  Plug 'NLKNguyen/papercolor-theme'
  " Plug 'crusoexia/vim-dracula'

" Local
  " Plug '~/devel/projects/nihon-theme/vim'
  Plug '~/devel/projects/vim-orgdown'

call plug#end()
