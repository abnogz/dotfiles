" Location:     plugin/fancystatus.vim
" Maintainer:   Pablo Nogueira
" Version:      1.0

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
		"let stat .= "[%{mode()}]"
	else
	endif

	let stat .= "%*"
	let stat .= " %n:"
	let stat .= "%f"
	let stat .= " %m"
	let stat .= "%r"

	if exists( "g:project_name" )
		let stat .= "<P:" . g:project_name . ">"
	endif

	if ( active && ( mode =~# '^i' || mode =~# '^R' ) )
		let stat .= mode_color
	endif

	let stat .= "%="
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

