function! s:ruby_iskeyword()
  " Ruby method could use ? and !, like `nil?`, `save!`
  return &iskeyword . ",?,!"
endfunction

function! s:set_ruby_iskeyword(ruby_iskeyword)
  execute "setlocal iskeyword=" . a:ruby_iskeyword
endfunction

if exists("g:loaded_iskeyword")
  finish
endif

let g:loaded_iskeyword = 1
autocmd FileType ruby call s:set_ruby_iskeyword(s:ruby_iskeyword())
