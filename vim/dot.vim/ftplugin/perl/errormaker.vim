" Perl syntax check configurations for errormaker.vim

compiler perl
autocmd BufWritePost *.pl,*.pm silent make %

let current_file_path = expand('%')
let lib_path = substitute(current_file_path, '\/lib\/.*', '/lib', '')
" TODO: check already $PERL5LIB exists
let $PERL5LIB=$PERL5LIB . ':' . lib_path

if exists("g:did_perl_errormaker")
  finish
endif
let g:did_perl_errormaker = 1
