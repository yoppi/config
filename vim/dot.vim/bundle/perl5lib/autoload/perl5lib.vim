" perl5lib.vim --- set path into PERL5LIB if its file path includes 'lib' directory

function! perl5lib#set_perl5lib()
  call s:set_perl5lib()
endfunction

let s:is_win = has('win32') || has('win64')

function! s:perllib_check_path(lst, lib_path)
  if empty(a:lst)
    return ""
  endif
  let l:dir = get(a:lst, 0)
  let l:_lib_path = a:lib_path . "/lib"
  if l:dir == "lib"
    return l:_lib_path
  elseif l:dir == "t" && filereadable(l:_lib_path)
    return l:_lib_path
  else
    return s:perllib_check_path(a:lst[1:-1], a:lib_path . '/' . l:dir)
  endif
endfunction

function! s:current_buffer_path_lst()
  let l:lst = []
  if s:is_win
    let l:lst = split(substitute(expand('%:p'), '\\', '/', 'g'), '/')
  else
    let l:lst = split(expand('%:p'), '/')
  endif
  return l:lst
endfunction

function! s:set_perl5lib()
  let l:current_buffer_path_l = s:current_buffer_path_lst()
  let l:lib_path = s:perllib_check_path(l:current_buffer_path_l, "")
  let l:current_perl5lib = $PERL5LIB

  if    (len(l:lib_path) && len(l:current_perl5lib) && (match(l:current_perl5lib, l:lib_path) < 0))
  \  || (len(l:lib_path) && !len(l:current_perl5lib))
    let $PERL5LIB = l:lib_path . ":" . l:current_perl5lib
    echomsg "Added " . l:current_perl5lib . "into PERL5LIB"
  endif
endfunction
