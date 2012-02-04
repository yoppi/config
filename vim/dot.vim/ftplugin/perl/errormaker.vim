" Perl syntax check configurations for errormaker.vim

compiler perl
call perl5lib#set_perl5lib()

if exists("g:did_perl_errormaker")
  finish
endif
let g:did_perl_errormaker = 1
autocmd BufWritePost *.pl,*.pm silent make! %
