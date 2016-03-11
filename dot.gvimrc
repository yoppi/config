if has('gui_macvim')
  set guifont=Ricty\ Discord\ Regular\ for\ Powerline:h18
  set guifontwide=Ricty\ Discord\ Regular\ for\ Powerline:h18
elseif has('win32') || has('win64')
  set guifont=Bitstream_Vera_Sans_Mono:h11
  set guifontwide=MS_Gothic:h11
  set transparency=220
elseif has('gui')
  set guifont=Ricty_Discord_12
  set guifontwide=Ricty_Discord_12
else
  " nop
endif
colorscheme hemisu
set linespace=1
