" quickrun - run a command and show its result quickly
" Author: ujihisa <http://ujihisa.nowa.jp/>
" ModifiedBy: kana <http://whileimautomaton.net/>
" ModifiedBy: Sixeight <http://d.hatena.ne.jp/Sixeight/>

if exists('g:loaded_quickrun')
  finish
endif


function! s:quicklaunch(no)
  if !exists('g:quicklaunch_commands[a:no]')
    echoerr 'quicklaunch has no such command:' a:no
    return
  endif
  let quicklaunch_command = g:quicklaunch_commands[a:no]
  call s:open_result_buffer(quicklaunch_command)
  setlocal modifiable
    silent % delete _
    call append(0, ':-<')
    redraw
    silent % delete _
    call append(0, '')
    execute 'silent! read !' quicklaunch_command
    silent 1 delete _
  setlocal nomodifiable
endfunction


function! s:quickrun()
  if !exists('b:quickrun_command')
    echoerr 'quickrun is not available for filetype:' string(&l:filetype)
    return
  endif
  let quickrun_command = b:quickrun_command

  let existent_file_p = filereadable(expand('%'))
  if existent_file_p
    silent update
    let file = expand('%')
  else
    let file = tempname() . expand('%:e')
    let original_bufname = bufname('')
    let original_modified = &l:modified
      silent keepalt write `=file`
      if original_bufname == ''
        " Reset the side effect of ":write {file}" - it sets {file} as the
        " name of the current buffer if it is unnamed buffer.
        silent 0 file
      endif
    let &l:modified = original_modified
  endif

  call s:open_result_buffer(quickrun_command)
  setlocal modifiable
    silent % delete _
    call append(0, ':-)')
    redraw
    silent % delete _
    call append(0, '')
    execute 'silent! read !' quickrun_command file
    silent 1 delete _
  setlocal nomodifiable

  if existent_file_p
    " nop.
  else
    call delete(file)
  endif
endfunc


function! s:open_result_buffer(quickrun_command)
  let bufname = printf('*quickrun* %s', a:quickrun_command)

  if !bufexists(bufname)
    execute g:quickrun_direction 'vnew'
    setlocal bufhidden=unload
    setlocal nobuflisted
    setlocal buftype=nofile
    setlocal nomodifiable
    setlocal noswapfile
    setfiletype quickrun
    silent file `=bufname`

    nnoremap <buffer> <silent> q  <C-w>c
  else
    let bufnr = bufnr(bufname)  " FIXME: escape.
    let winnr = bufwinnr(bufnr)
    if winnr == -1
      execute g:quickrun_direction 'vsplit'
      execute bufnr 'buffer'
    else
      execute winnr 'wincmd w'
    endif
  endif
endfunction


function! s:set_quickrun_command(command)
  " Use user's settings if they exist.
  if !exists('b:quickrun_command')
    let b:quickrun_command = a:command
  endif
endfunction





if !exists('g:quickrun_direction')
  let g:quickrun_direction = 'rightbelow'
endif




nnoremap <silent> <Plug>(quickrun)  :<C-u>call <SID>quickrun()<Return>
silent! nmap <unique> <Leader>r  <Plug>(quickrun)
for i in range(10)
  execute "nnoremap <silent> <Plug>(quicklaunch-" . i . ") :<C-u>call <SID>quicklaunch(" . i . ")<Return>"
  execute "silent! nmap <unique> <Leader>" . i . "  <Plug>(quicklaunch-" . i . ")"
endfor

augroup plugin-quickrun
  autocmd!
  autocmd Filetype awk  call s:set_quickrun_command('awk')
  autocmd Filetype c  call s:set_quickrun_command('function __rungcc__() { gcc $1 && ./a.out } && __rungcc__')
  autocmd Filetype cpp call s:set_quickrun_command('function __rungpp__() { g++ $1 && ./a.out } && __rungpp__')
  autocmd Filetype objc  call s:set_quickrun_command('function __rungcc__() { gcc $1 && ./a.out } && __rungcc__')
  autocmd Filetype haskell  call s:set_quickrun_command('runghc')
  autocmd Filetype io  call s:set_quickrun_command('io')
  autocmd Filetype javascript  call s:set_quickrun_command('js')
  autocmd Filetype perl  call s:set_quickrun_command('perl')
  autocmd Filetype php  call s:set_quickrun_command('php')
  autocmd Filetype python  call s:set_quickrun_command('python')
  autocmd Filetype ruby  call s:set_quickrun_command('ruby')
  autocmd Filetype scala  call s:set_quickrun_command('scala')
  autocmd Filetype scheme  call s:set_quickrun_command('gosh')
  autocmd Filetype sed  call s:set_quickrun_command('sed')
  autocmd Filetype sh  call s:set_quickrun_command('sh')
augroup END




let g:loaded_quickrun = 1

" __END__
