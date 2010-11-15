" Perl syntax check configurations for errormaker.vim

if exists("g:did_perl_errormaker")
  finish
endif
let g:did_perl_errormaker = 1

compiler perl
autocmd BufWritePost *.pl,*.pm silent make %

