function! s:set_xml_folding()
  let g:xml_syntax_folding = 1
  execute "setlocal foldmethod=syntax"
endfunction

if exists("g:loaded_xml_folding")
  finish
endif

let g:loaded_xml_folding = 1

autocmd Filetype xml call s:set_xml_folding()
