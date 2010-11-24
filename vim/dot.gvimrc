" Options "{{{1
if has('gui_macvim')
  if exists('+guifont')
    set guifont=Bitstream\ Vera\ Sans\ Mono:h14
  endif
  if exists('+guifontwide')
    set guifontwide=HiraMaruPro-W4:h14
  endif
elseif has('win32') || has('win64')
  set guifont=Bitstream\ Vera\ Sans\ Mono:h11
  set guifontwide=MS_Gothic:h11
else
  " not yet
endif

" Color "{{{1
if has('gui_running')
  set transparency=220
  colorscheme koehler
  hi Pmenu       gui=underline guibg=black
  hi PmenuSel    guibg=blue
  hi Normal guibg=grey5
endif

if has('win32') || has('win64')
  set vb t_vb=
  set noimdisable
endif
