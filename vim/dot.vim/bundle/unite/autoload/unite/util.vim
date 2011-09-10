let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#of('unite')
call s:V.load('Data.List')
function! unite#util#truncate_smart(...)
  return call(s:V.truncate_smart, a:000)
endfunction
function! unite#util#truncate(...)
  return call(s:V.truncate, a:000)
endfunction
function! unite#util#strchars(...)
  return call(s:V.strchars, a:000)
endfunction
function! unite#util#strwidthpart(...)
  return call(s:V.strwidthpart, a:000)
endfunction
function! unite#util#strwidthpart_reverse(...)
  return call(s:V.strwidthpart_reverse, a:000)
endfunction
function! unite#util#wcswidth(...)
  return call(s:V.wcswidth, a:000)
endfunction
function! unite#util#wcswidth(...)
  return call(s:V.wcswidth, a:000)
endfunction
function! unite#util#is_win(...)
  return call(s:V.is_windows, a:000)
endfunction
function! unite#util#is_mac(...)
  return call(s:V.is_mac, a:000)
endfunction
function! unite#util#print_error(...)
  return call(s:V.print_error, a:000)
endfunction
function! unite#util#smart_execute_command(...)
  return call(s:V.smart_execute_command, a:000)
endfunction
function! unite#util#escape_file_searching(...)
  return call(s:V.escape_file_searching, a:000)
endfunction
function! unite#util#escape_pattern(...)
  return call(s:V.escape_pattern, a:000)
endfunction
function! unite#util#set_default(...)
  return call(s:V.set_default, a:000)
endfunction
function! unite#util#set_dictionary_helper(...)
  return call(s:V.set_dictionary_helper, a:000)
endfunction
function! unite#util#substitute_path_separator(...)
  return call(s:V.substitute_path_separator, a:000)
endfunction
function! unite#util#path2directory(...)
  return call(s:V.path2directory, a:000)
endfunction
function! unite#util#path2project_directory(...)
  return call(s:V.path2project_directory, a:000)
endfunction
function! unite#util#has_vimproc(...)
  return call(s:V.has_vimproc, a:000)
endfunction
function! unite#util#system(...)
  return call(s:V.system, a:000)
endfunction
function! unite#util#get_last_status(...)
  return call(s:V.get_last_status, a:000)
endfunction
function! unite#util#sort_by(...)
  return call(s:V.Data.List.sort_by, a:000)
endfunction
function! unite#util#uniq(...)
  return call(s:V.Data.List.uniq, a:000)
endfunction
function! unite#util#input_yesno(message)"{{{
  let l:yesno = input(a:message . ' [yes/no] : ')
  while l:yesno !~? '^\%(y\%[es]\|n\%[o]\)$'
    redraw
    if l:yesno == ''
      echo 'Canceled.'
      break
    endif

    " Retry.
    call unite#print_error('Invalid input.')
    let l:yesno = input(a:message . ' [yes/no] : ')
  endwhile

  return l:yesno =~? 'y\%[es]'
endfunction"}}}
function! unite#util#input_directory(message)"{{{
  echo a:message
  let l:dir = input('', '', 'dir')
  while !isdirectory(l:dir)
    redraw
    if l:dir == ''
      echo 'Canceled.'
      break
    endif

    " Retry.
    call unite#print_error('Invalid path.')
    echo a:message
    let l:dir = input('', '', 'dir')
  endwhile

  return l:dir
endfunction"}}}

function! unite#util#alternate_buffer()"{{{
  if bufnr('%') != bufnr('#') && buflisted(bufnr('#'))
    buffer #
    return
  endif

  let l:listed_buffer_len = len(filter(range(1, bufnr('$')),
        \ 'buflisted(v:val) && getbufvar(v:val, "&filetype") !=# "unite"'))
  if l:listed_buffer_len <= 1
    enew
    return
  endif

  let l:cnt = 0
  let l:pos = 1
  let l:current = 0
  while l:pos <= bufnr('$')
    if buflisted(l:pos)
      if l:pos == bufnr('%')
        let l:current = l:cnt
      endif

      let l:cnt += 1
    endif

    let l:pos += 1
  endwhile

  if l:current > l:cnt / 2
    bprevious
  else
    bnext
  endif
endfunction"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

