" .vimrc#General settings
set title
set noshowmode
set autowrite
set inccommand=split
set noshowcmd

" !
set hidden

set encoding=utf-8 nobomb
" set nocompatible
set number
set showbreak=+++
set visualbell
set noerrorbells

set hlsearch
set smartcase
set ignorecase
set incsearch

" set code folding method
" setlocal foldmethod=syntax

set pumheight=10
set lazyredraw

set mouse=a

" share OSX clipboard
set clipboard+=unnamedplus
" allow backspace in INSERT mode
set backspace=indent,eol,start

set signcolumn=yes
" cursorlines
set cursorline
" set cursorcolumn

" For conceal markers.
if has('conceal')
  " set conceallevel=2 concealcursor=nv
  set conceallevel=2 concealcursor=
endif

" centralize vimfiles
set backupdir=/tmp
set directory=/tmp
if exists('&undodir')
    set undodir=~/.vim/undo
endif

" pane divider chars
set fillchars=fold:-,vert:\│

"" colorscheme options
if has("termguicolors")
  set termguicolors
endif

if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

set ts=8 sts=0 et sw=4 sta
" filetype plugin indent on
function! Retab()
    setlocal ts=8 sts=0 et sw=4 sta
    retab!
endfunction
