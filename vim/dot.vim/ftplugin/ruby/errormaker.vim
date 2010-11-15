" Ruby syntax check configurations for errormaker.vim 

if exists("g:did_ruby_errormaker")
  finish
endif
let g:did_ruby_errormaker = 1

compiler ruby
setlocal errorformat=%f:%l:%m
autocmd BufWritePost *.rb silent make %
