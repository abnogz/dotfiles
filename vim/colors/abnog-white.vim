" Vim color file
" Maintainer:	Pablo Nogueira <pablonogueiracorzo@gmail.com>
" Last Change:	2020-07-23

" abnog-white (WIP) -- Color scheme ...

set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
set t_Co=256

let g:colors_name = "abnog-white"

" Color palette

let s:bg = "#eeeeee"
let s:fg = "#101010"

let s:red = "#bc2727"
let s:green = "#009b00"
let s:blue = "#0000ff"
let s:orange = "#ff8000"
let s:yellow = "#a0a000"
let s:teal = "#00ff80"
let s:cyan = "#00d0d0"
let s:dark_cyan = "#00a0a0"
let s:light_blue = "#3399ff"
let s:purple = "#cc99ff"
let s:light_green = "#33ff33"
let s:magenta = "#cc55cc"
let s:grey = "#808080"
let s:dark_grey = "#454545"
let s:pink = "#f0a0c0"

exe "hi Normal guifg=" . s:fg . " ctermbg=NONE guibg=" . s:bg . " gui=NONE"

" Identifiers
exe "hi String guifg=" . s:red . " guibg=NONE"
exe "hi Define gui=NONE guifg=" . s:blue . " guibg=NONE"
exe "hi Macro gui=NONE guifg=" . s:blue . " guibg=NONE"
exe "hi Include gui=bold guifg=" . s:blue . " guibg=NONE"
exe "hi Label gui=NONE guifg=" . s:blue . " guibg=NONE"
exe "hi Delimiter gui=bold guifg=" . s:blue . " guibg=NONE"
exe "hi Number gui=NONE guifg=" . s:blue . " guibg=NONE"
exe "hi Comment gui=italic guifg=" . s:green . " guibg=NONE"
exe "hi MatchParen gui=bold guifg=" . s:blue . " guibg=#26337D"
exe "hi Constant gui=bold guifg=" s:blue . " guibg=NONE"
exe "hi PreProc gui=NONE guifg=" . s:blue . " guibg=NONE"
exe "hi SpecialChar gui=NONE guifg=" . s:blue . " guibg=NONE"

" Keywords
exe "hi Type gui=NONE guifg=" . s:blue . " guibg=NONE"
exe "hi Identifier gui=NONE guifg=" . s:blue . " guibg=NONE"
exe "hi Repeat gui=NONE guifg=" . s:blue . " guibg=NONE"
exe "hi Conditional gui=NONE guifg=" . s:blue . " guibg=NONE"
exe "hi Statement gui=NONE guifg=" . s:blue . " guibg=NONE"
exe "hi Operator gui=NONE guifg=" . s:blue . " guibg=NONE"

exe "hi MyParens gui=NONE guifg=" . s:blue . " guibg=NONE"

" ToDos & Notes
exe "hi Todo gui=bold,underline guifg=Red guibg=NONE"
exe "hi MyNote gui=italic,bold,underline guifg=WebGreen guibg=#004000"

" UI
hi CursorLine guibg=#dddddd
hi LineNr guifg=#6c6c6c guibg=#dddddd
hi CursorLineNR gui=bold guifg=#ffffff guibg=#aaaaaa
hi StatusLine gui=bold guibg=#454545 guifg=#d2d2d2
hi StatusLineNC gui=italic guibg=#dddddd guifg=#6c6c6c
hi Search guibg=#2c88da guifg=#d2d2d2
exe "hi Visual gui=NONE guifg=black guibg=" . s:magenta
" eol, extends, precedes
hi NonText guifg=#7ed321 guibg=#1e2863
" nbsp, tab, trail
exe "hi SpecialKey gui=NONE guifg=" . s:grey . " guibg=NONE"
" end of buffer
exe "hi EndOfBuffer gui=bold guifg=" . s:light_blue . " guibg=NONE"

" Tabline
exe "hi TabLineSel gui=bold guifg=" . s:fg . " guibg=" . s:bg
exe "hi TabLine gui=NONE guifg=" . s:fg . " guibg=" . s:grey
exe "hi TabLineFill gui=NONE guifg=" . s:fg . " guibg=" . s:grey
exe "hi Title guifg=" . s:fg

"1 (red)
hi DiffText guifg=#fc4747 guibg=NONE
hi ErrorMsg guifg=#fc4747 guibg=NONE
hi WarningMsg guifg=#fc4747 guibg=NONE
hi Exception guifg=#fc4747 guibg=NONE
hi Error guifg=#fc4747 guibg=NONE
hi DiffDelete guifg=#fc4747 guibg=NONE
hi GitGutterDelete guifg=#fc4747 guibg=NONE
hi GitGutterChangeDelete guifg=#fc4747 guibg=NONE
hi cssIdentifier guifg=#fc4747 guibg=NONE
hi cssImportant guifg=#fc4747 guibg=NONE

"2 (teal)
hi PMenuSel guifg=#51fbb3 guibg=NONE
hi DiffAdd guifg=#51fbb3 guibg=NONE
hi GitGutterAdd guifg=#51fbb3 guibg=NONE
hi cssIncludeKeyword guifg=#51fbb3 guibg=NONE
hi Keyword guifg=#51fbb3 guibg=NONE

"3 (yellow)
hi IncSearch gui=bold guifg=#ffff44 guibg=#2e3873
hi PreCondit gui=bold guifg=#ffff44 guibg=#2e3873
hi Debug gui=bold guifg=#ffff44 guibg=#2e3873
hi Special gui=bold guifg=#ffff44 guibg=#2e3873
hi MoreMsg gui=bold guifg=#ffff44 guibg=#2e3873
hi Tag gui=bold guifg=#ffff44 guibg=#2e3873
hi DiffChange gui=bold guifg=#ffff44 guibg=#2e3873
hi GitGutterChange gui=bold guifg=#ffff44 guibg=#2e3873
hi cssColor gui=bold guifg=#ffff44 guibg=#2e3873

"4 (blue)
hi Function guifg=#4287f9 guibg=NONE

"5 (purple)
hi Directory guifg=#c382fc guibg=NONE
hi markdownLinkText guifg=#c382fc guibg=NONE
hi javaScriptBoolean guifg=#c382fc guibg=NONE
hi Storage guifg=#c382fc guibg=NONE
hi cssClassName guifg=#c382fc guibg=NONE
hi cssClassNameDot guifg=#c382fc guibg=NONE

"6 (cyan)
hi cssAttr gui=bold guifg=#52f0fc guibg=NONE

"Comments (green)
hi SpecialComment guifg=#7ed321 gui=italic guibg=#1e2863

hi Pmenu guifg=#d2d2d2 guibg=#454545
hi SignColumn guibg=#1e2863

hi VertSplit gui=NONE guifg=#454545 guibg=NONE
