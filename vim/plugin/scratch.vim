" scratch.vim - Scratch buffer management
" Maintainer:   Pablo Nogueira
" Version:      1.0

if exists("g:loaded_scratch") || v:version < 700 || &cp
	finish
endif
let g:loaded_scratch = 1

function StartScratch()
	if argc() == 0
		setlocal buftype=nofile
		setlocal bufhidden=hide
		setlocal noswapfile
	endif
endfunction

function scratch#MakeScratch()
	if g:scratch_on
		if ( expand('%:t') == '' ) && ( &buftype == '' )
			"echom "scratch - No File"
			setlocal buftype=nofile
			setlocal bufhidden=hide
			setlocal noswapfile
		else
			"echom "scratch - File"
		endif
	endif
endfunction

function scratch#SaveAs( name )
	"echom "scratch - scratch#SaveAs( " . a:name . " )"
	"let filename=a:name
	setlocal buftype=
	setlocal bufhidden=
	setlocal swapfile
	exe "file " . a:name
	write
endfunction

augroup MyScratch
	"autocmd VimEnter * call StartScratch()
	autocmd BufWinEnter * call scratch#MakeScratch()
augroup END

command -nargs=1 -complete=dir SsaveAs call scratch#SaveAs(<f-args>)
