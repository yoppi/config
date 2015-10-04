setlocal makeprg=gofmt
setlocal errorformat=%f:%l:%c:%m

if exists("g:loaded_go_errormarker")
  finish
endif
let g:loaded_go_errormarker = 1

function! s:go_check_syntax()
  silent make! %
endfunction

autocmd BufWritePost *.go call s:go_check_syntax()
