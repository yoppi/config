if has('gui_macvim')
  set guifont=Ricty_Discord_for_Powerline:h16
  set guifontwide=Ricty_Discord_for_Powerline:h16
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

if has('unix') || has('win32') || has('win64')
  set vb t_vb=
  set noimdisable
endif

"hi Pmenu gui=underline guibg=black
colorscheme hemisu
hi Normal guibg=grey5
