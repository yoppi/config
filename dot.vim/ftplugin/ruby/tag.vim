function! s:rbenv_root()
  return $HOME . "/.rbenv"
endfunction

function! s:ruby_version_path()
  return s:rbenv_root() . "/version"
endfunction

function! s:ruby_tags_path(version)
  return s:rbenv_root() . "/versions/" . a:version . "/**/tags"
endfunction

function! s:ruby_version()
  if filereadable(s:ruby_version_path())
    return readfile(s:ruby_version_path())[0]
  endif
endfunction

function! s:set_ruby_tags(ruby_tags)
  execute "setlocal tag=" . a:ruby_tags
endfunction

if exists("g:loaded_ruby_tags") || !isdirectory(s:rbenv_root())
  finish
endif

let g:loaded_ruby_tags = 1
let s:ruby_tags = &tag . "," . s:ruby_tags_path(s:ruby_version())
autocmd FileType ruby call s:set_ruby_tags(s:ruby_tags)


