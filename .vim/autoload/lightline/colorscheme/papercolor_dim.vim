" papercolor_dim : a less flashy statusline
"
" Adapted from the Papercolor_dark theme:
" =============================================================================
" Filename: autoload/lightline/colorscheme/PaperColor_dark.vim
" Author: TKNGUE
" License: MIT License
" Last Change: 2015-07-27 06:01
" =============================================================================

let s:red = '#af005f'
let s:green = '#5faf5f'
let s:blue = '#5fafd7'
let s:magenta = '#ff5faf'
let s:olive = '#dfaf5f'
let s:navy = '#df875f'
let s:orange = '#d7875f'
let s:purple = '#af87d7'
let s:aqua = '#00afaf'

let s:black = '#1c1c1c'
let s:grey_dim = '#3a3a3a'
let s:grey_dimmer = '#262626'

let s:white = '#d0d0d0'
let s:white_dim = '#bdc0ba'

" Tabline:
let s:tabline_bg = '#3a3a3a'
let s:tabline_active_fg = '#1c1c1c'
let s:tabline_active_bg = '#00afaf'
let s:tabline_inactive_fg = '#c6c6c6'
let s:tabline_inactive_bg = '#585858'

let s:p = {'command': {}, 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [[ s:white, s:grey_dim ], [ s:white_dim, s:grey_dimmer ], [ s:white_dim, 'none' ]]
let s:p.normal.right = [[ s:white, s:grey_dim ], [ s:white_dim, s:grey_dimmer ], [ s:white_dim, 'none' ]]
let s:p.normal.middle = [[ s:white_dim, 'none' ]]
let s:p.normal.error = [[ s:black, s:red ]]

let s:p.inactive.right = [[ s:white_dim, s:grey_dim ], [ s:white_dim, s:grey_dim ]]
let s:p.inactive.right = [[ s:white_dim, s:grey_dim ], [ s:white_dim, s:grey_dim ]]
let s:p.inactive.middle = [[ s:white_dim, s:grey_dim ]]

let s:p.insert.left = [[ s:black, s:blue ], copy(s:p.normal.left[1]), copy(s:p.normal.left[2])]
let s:p.replace.left = [[ s:black, s:orange ], copy(s:p.normal.left[1]), copy(s:p.normal.left[2])]
let s:p.visual.left = [[ s:black, s:purple ], copy(s:p.normal.left[1]), copy(s:p.normal.left[2])]
" let s:p.command.left = [[ s:black, s:green ], copy(s:p.normal.left[1]), copy(s:p.normal.left[2])]

let s:p.tabline.left = [[ s:grey_dim, 'none' ]]
let s:p.tabline.tabsel = [[ s:white_dim, 'none' ]]
let s:p.tabline.middle = [[ s:white_dim, 'none' ]]
let s:p.tabline.right = [[ s:white_dim, 'none' ]]

let g:lightline#colorscheme#papercolor_dim#palette = lightline#colorscheme#fill(s:p)
