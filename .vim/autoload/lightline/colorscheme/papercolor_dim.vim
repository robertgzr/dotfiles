" papercolor_dim : a less flashy statusline
"
" Adapted from the Papercolor_dark theme:
" =============================================================================
" Filename: autoload/lightline/colorscheme/PaperColor_dark.vim
" Author: TKNGUE
" License: MIT License
" Last Change: 2015-07-27 06:01
" =============================================================================

" colors
let s:color00 = '#1c1c1c'
let s:color01 = '#af005f'
let s:color02 = '#5faf00'
let s:color03 = '#d7af5f'
let s:color04 = '#5fafd7'
let s:color05 = '#808080'
let s:color06 = '#d7875f'
let s:color07 = '#d0d0d0'
let s:color08 = '#585858'
let s:color09 = '#5faf5f'
let s:color10 = '#afd700'
let s:color11 = '#af87d7'
let s:color12 = '#ffaf00'
let s:color13 = '#ff5faf'
let s:color14 = '#00afaf'
let s:color15 = '#5f8787'
let s:color16 = '#5fafd7'
let s:color17 = '#d7af00'

let s:black = '#1c1c1c'
let s:grey_dim = '#3a3a3a'
let s:grey_dimmer = '#262626'
let s:white = '#d0d0d0'
let s:white_dim = '#bdc0ba'

" palette
let s:p = {'command': {}, 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [[ s:white, s:grey_dim ], [ s:white_dim, s:grey_dimmer ], [ s:white_dim, 'none' ]]
let s:p.normal.right = [[ s:white, s:grey_dim ], [ s:white_dim, s:grey_dimmer ], [ s:white_dim, 'none' ]]
let s:p.normal.middle = [[ s:white_dim, 'none' ]]
let s:p.normal.error = [[ s:black, s:color01 ]]

let s:p.inactive.right = [[ s:white_dim, s:grey_dim ], [ s:white_dim, s:grey_dim ]]
let s:p.inactive.middle = [[ s:white_dim, s:grey_dim ]]
let s:p.inactive.right = [[ s:white_dim, s:grey_dim ], [ s:white_dim, s:grey_dim ]]

let s:p.insert.left = [[ s:black, s:color04 ], copy(s:p.normal.left[1]), copy(s:p.normal.left[2])]
let s:p.replace.left = [[ s:black, s:color06 ], copy(s:p.normal.left[1]), copy(s:p.normal.left[2])]
let s:p.visual.left = [[ s:black, s:color11 ], copy(s:p.normal.left[1]), copy(s:p.normal.left[2])]
let s:p.command.left = [[ s:color03, s:grey_dim, 'italic' ], copy(s:p.normal.left[1]), copy(s:p.normal.left[2])]

let s:p.tabline.tabsel = [[ s:white, s:color08 ]]
let s:p.tabline.left = [[ s:white_dim, s:grey_dimmer ]]
let s:p.tabline.middle = copy(s:p.normal.middle)
let s:p.tabline.right = copy(s:p.normal.right)

let g:lightline#colorscheme#papercolor_dim#palette = lightline#colorscheme#fill(s:p)
