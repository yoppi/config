setlocal makeprg=go\ build
setlocal errorformat=%f:%l:%m

if exists("g:loaded_go_errormarker")
  finish
endif
let g:loaded_go_errormarker = 1

autocmd BufWritePost *.go silent make! %
