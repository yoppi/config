" JavaScript syntax check configurations for errormaker.vim

setlocal makeprg=js\ -s\ -w\ -C\ %\ $*
setlocal errorformat=%f:%l:%m

if exists("g:dit_javascript_errormaker")
  finish
endif
let g:dit_javascript_errormaker = 1
autocmd BufWritePost *.js silent make!
