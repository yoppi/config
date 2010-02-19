" Options "{{{1
if has('gui_macvim')
  if exists('+guifont')
    set guifont=Bitstream\ Vera\ Sans\ Mono:h14
  endif
  if exists('+guifontwide')
    set guifontwide=HiraMaruPro-W4:h14
  endif
elseif has('win32') || has('win64')
  " not yet
else
  " not yet
endif

" Color "{{{1
if has('gui_macvim')
  colorscheme desert
  hi Pmenu       gui=underline guibg=black
  hi PmenuSel    guibg=blue
  hi Normal guibg=grey5
endif
