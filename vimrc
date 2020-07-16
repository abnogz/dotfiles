if &compatible | set nocompatible | endif " Avoid side effects if `nocp` already set

""" Basic options

filetype plugin indent on		" Filetype detection
syntax enable					" Syntax highlighting
set mouse=a						" Enable the mouse on all modes
set hidden						" Hide buffer instead of closing when opening new file
set autowrite					" Automatically save before commands like :next and :make
set history=200					" Number of commands remembered	
set backspace=indent,eol,start  " Make backspace work like most other programs
set confirm                     " 
set encoding=utf-8

""" GUI

if has('gui_running')
	set guioptions=acgi
	set background=dark
	colorscheme abnog-dark
	set lines=46 columns=180
    set guicursor=a:blinkon0    " no blinking cursor
    set mousehide               " hide mouse cursor when typing
    if has('win32') || has('win64')
        set guifont=Consolas:h11
    else
        set guifont=Ubuntu\ Mono\ 14
    endif
else
	if &term == "linux"
	else
		set background=dark
		colorscheme Tomorrow-Night
	endif
endif

""" UI

set number						" Show line numbers
set cursorline					" Highlight cursor line
set lazyredraw                  " Redraw only when we need to
set wildmenu					" Enhanced command-line completion
set wildmode=list:full
set wildcharm=<TAB>
set wildignore+=.*
set showmatch					" Show matching brackets.
set showcmd						" Show (partial) command in status line.
set nowrap
set listchars=tab:→_,space:·,nbsp:␣,trail:•,eol:$,precedes:«,extends:»
set fillchars+=vert:│
highlight VertSplit guibg=NONE ctermbg=NONE
set ttymouse=xterm2             " To allow dragging statusline with the mouse inside tmux
autocmd VimResized * :wincmd =
set switchbuf=useopen,split     " Existing open buffers would be used in preference and do a split if the file isn't already visible. 

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" highlight last inserted text
nnoremap gV `[v`]

" Allow color schemes to do bright colors without forcing bold.
"if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    "set t_Co=16
"endif

""" Tabs and indentation

set tabstop=4					" Number of spaces that a <Tab> counts for
set softtabstop=4				" Affects what happens when you press the <TAB> or <BS> keys
set shiftwidth=4				" When indenting with '>', use 4 spaces width
set shiftround					" Indent always on multiples of 'shiftwidth'
set noexpandtab
set smarttab
set autoindent
set smartindent

""" Hard mode :-)

for key in ['<Up>', '<Down>', '<Left>', '<Right>', '<Home>', '<End>', '<PageUp>', '<PageDown>']
	exec 'noremap' key '<Nop>'
	exec 'inoremap' key '<Nop>'
	exec 'cnoremap' key '<Nop>'
endfor

""" Searching

set incsearch					" Search as characters are entered
set hlsearch					" Highlight matches
set ignorecase					" Ignore case on searches
set smartcase					" Search case sensitive when at least on uppercase character is used

" Clear search highlighting when press <CR> in normal mode
nnoremap <CR> :noh<CR><CR>
" clear search highlighting when press <ESC> in normal mode
"nnoremap <silent> <ESC> :noh<CR><ESC>

""" Swap and backup files locations

set backup
set writebackup
set undofile

if has("win32") || has("win64")
    set directory=~/vimfiles/tmp//      " Swap files
    set backupdir=~/vimfiles/backup//   " backups
    set undodir=~/vimfiles/undo//       " Undo files
    set viminfo+=n~/vimfiles/viminfo    " Viminfo file
else
    set directory=~/.vim/tmp//          " Swap files
    set backupdir=~/.vim/backup//       " backups
    set undodir=~/.vim/undo//           " Undo files
    set viminfo+=n~/.vim/viminfo        " Viminfo file
endif
" The trailing slashes are for vim to create each file with their full path
" converting slashes to percent symbols

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif

"""" Custom key mappings
let mapleader = "ç"

" Assign F2 to toggle paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
"set showmode

" Assign F3 to toggle view invisible chars
nnoremap <F3> :set list! list?<CR>
inoremap <F3> <ESC>:set list! list?<CR>a

" Switch buffer
"nnoremap <F5> :buffers<CR>:buffer<Space>
"inoremap <F5> <ESC>:buffers<CR>:buffer<Space>
nnoremap <Leader>b :buffer <TAB>

" Map C-w, C-b to move to next/previous word in insert mode
inoremap <silent> <C-w>         <C-O>w
inoremap <silent> <C-b>         <C-O>b

" Convert to uppercase last inserted text (useful for macros in C for example)
nnoremap <Leader>u `[v`]U

""" Annoyances

" To avoid entering REPLACE mode from INSERT mode
""inoremap <Insert> <Nop>
"inoremap <S-Insert> <Insert>

" To avoid entering ex mode
nnoremap Q <nop>

" To avoid hitting U instead of u
nnoremap U <nop>

""" Custom highlights for TODOs and NOTEs
" TODO
" NOTE
" FIXME(bb):

function! s:MyCustomSyntax()
	"syntax keyword MyNote containedin=.*Comment.* contained NOTE
	highlight Todo term=bold,underline ctermfg=Red ctermbg=52 gui=bold,underline guifg=Red guibg=#640000
	highlight MyNote term=bold,underline ctermfg=Green ctermbg=22 gui=italic,bold,underline guifg=WebGreen guibg=#004000
endfunction

call s:MyCustomSyntax()

augroup MyCustomSyntax
	autocmd Syntax * syntax keyword MyNote containedin=.*Comment.* contained NOTE
	autocmd Syntax * syntax match MyParens /[(){}]-+*=/
	autocmd Syntax,ColorScheme * call s:MyCustomSyntax()
augroup END

""" Fancy Status line

set noshowmode
set laststatus=2

let g:currentmode={ 'n'  : 'NORMAL', 'no' : 'N·Operator Pending',
	\ 'niI': 'NORMAL·INS', 'niR': 'NORMAL·REP', 'niV': 'NORMAL·V-REP',
	\ 'v'  : 'VISUAL', 'V'  : 'V·Line', '' : 'V·Block',
	\ 's'  : 'Select', 'S'  : 'S·Line', '' : 'S·Block',
	\ 'i'  : 'INSERT', 'ic': 'INSERT·Compl', 'ix' : 'INSERT·C-X',
	\ 'R'  : 'REPLACE', 'Rv' : 'V·Replace',
	\ 'c'  : 'Command', 'cv' : 'Vim Ex', 'ce' : 'Ex',
	\ 'r'  : 'Prompt', 'rm' : 'More', 'r?' : 'Confirm',
	\ '!'  : 'Shell', 't'  : 'Terminal' }

function! StatusLineSetColors()
	highlight SLModeNormal cterm=None ctermfg=0 ctermbg=103 gui=None guifg=#000000 guibg=#8197bf
	highlight SLModeInsert ctermfg=0 ctermbg=107 guifg=#000000 guibg=#99ad6a
	highlight SLModeVisual cterm=None ctermfg=0 ctermbg=217 gui=None guifg=#000000 guibg=#f0a0c0
	highlight SLModeReplace cterm=None ctermfg=0 ctermbg=167 gui=None guifg=#000000 guibg=#cf6a4c
	highlight SLModeSelect cterm=None ctermfg=0 ctermbg=167 gui=None guifg=#000000 guibg=#cf6a4c
	highlight SLModeCommand ctermfg=0 ctermbg=107 guifg=#000000 guibg=#cccc44
	highlight SLModeTerminal cterm=None ctermfg=0 ctermbg=167 gui=None guifg=#000000 guibg=#ffff00
endfunction

call StatusLineSetColors()

function! Status( winnr )
	let stat = ''
	let mode_color = ''
	let active = winnr() == a:winnr
	let mode = mode()

	" Set color and mode text for the active window
	if ( active )
		if ( mode =~# '^n' )
			let mode_color .= "%#SLModeNormal#"
    	elseif ( mode =~ '^v' || mode == '')
			let mode_color .= "%#SLModeVisual#"
    	elseif ( mode =~ '^s' || mode == '')
			let mode_color .= "%#SLModeSelect#"
    	elseif ( mode =~# '^i' )
			let mode_color .= "%#SLModeInsert#"
    	elseif ( mode =~# '^R' )
			let mode_color .= "%#SLModeReplace#"
    	elseif ( mode =~# '^c' )
			let mode_color .= "%#SLModeCommand#"
    	elseif ( mode =~# '^t' )
			let mode_color .= "%#SLModeTerminal#"
		endif

		let stat .= mode_color
		let stat .= " %{g:currentmode[mode(1)]} "

		if ( &paste == 1 ) && ( mode ==# 'i' )
			let stat .= "· PASTE "
		endif

		" For debugging purposes
		let stat .= "[%{mode()}]"
	else
	endif

	let stat .= "%*"
	let stat .= " %n:"
	let stat .= "%f"
	let stat .= " %m"
	let stat .= "%r"
	let stat .= "%="

	if ( active && ( mode =~# '^i' || mode =~# '^R' ) )
		let stat .= mode_color
	endif

	let stat .= "%<"
	let stat .= "%y"
	let stat .= "[%{&fileformat}:"
	let stat .= "%{&fileencoding?&fileencoding:&encoding}]"
	let stat .= " %l/%L:%c"
	"let stat .= " %p%%"
	let stat .= " "
	let stat .= "%*"

	return stat
endfunction

function! s:RefreshStatus()
	for nr in range(1, winnr('$'))
		call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
	endfor
endfunction

augroup StatusLine
	autocmd!
	"autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatus()
	autocmd VimEnter,WinEnter,BufWinEnter,CmdwinEnter * call s:RefreshStatus()
	autocmd ColorScheme * call StatusLineSetColors()
augroup END
