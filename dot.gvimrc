" Options "{{{1
if has('gui_macvim')
  set guifont=Ricty\ Discord\ for\ Powerline:h18
  set guifontwide=Ricty\ Discord\ for\ Powerline:h18
elseif has('win32') || has('win64')
  set guifont=Bitstream\ Vera\ Sans\ Mono:h11
  set guifontwide=MS_Gothic:h11
elseif has('gui')
  set guifont=Ricty\ Discord\ 12
  set guifontwide=Ricty\ Discord\ 12
else
  " nop
endif

" Color "{{{1
colorscheme molokai
hi Pmenu gui=underline guibg=black
hi Normal guibg=grey5
if has('gui_macvim')
  set transparency=0
elseif has('win32') || has('win64')
  set transparency=220
endif

if has('unix') || has('win32') || has('win64')
  set vb t_vb=
  set noimdisable
endif
