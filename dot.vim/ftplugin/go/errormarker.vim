setlocal makeprg=go\ build
setlocal errorformat=%f:%l:%m

if exists("g:loaded_go_errormarker")
  finish
endif
let g:loaded_go_errormarker = 1

function! s:go_build()
  " NOTE: 依存関係を go build でpacakgeから解決させるため、package宣言がmain以外ならファイルを指定しない
  let pos = search('^\s*package\s\+main')
  if (pos != 0)
    silent make! %
  else
    silent make!
  endif
endfunction

autocmd BufWritePost *.go call s:go_build()
