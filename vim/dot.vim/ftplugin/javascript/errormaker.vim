" JavaScript syntax check configurations for errormaker.vim
"
if exists("g:dit_javascript_errormaker")
  finish
endif
let g:dit_javascript_errormaker = 1

setlocal makeprg=js\ -s\ -w\ -C\ %\ $*
setlocal errorformat=%f:%l:%m
au BufWritePost *.js silent make
