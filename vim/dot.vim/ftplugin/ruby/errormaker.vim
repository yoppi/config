" Ruby syntax check configurations for errormaker.vim 

" syntax check only
"compiler ruby
setlocal makeprg=ruby\ -cw\ $*
setlocal errorformat=%f:%l:%m

if exists("g:did_ruby_errormaker")
  finish
endif
let g:did_ruby_errormaker = 1
autocmd BufWritePost *.rb silent make %
