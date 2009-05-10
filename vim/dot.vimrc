" misc. "{{{1
set nocompatible

augroup MyAutoCmd
  autocmd!
augroup END

set encoding=utf-8

let mapleader = ","

map <Space> [Space]
noremap [Space] <nop>

" Filetype "{{{2
filetype plugin indent on
autocmd Filetype c,cpp     set softtabstop=4 shiftwidth=4 tabstop=8
autocmd Filetype ruby      set softtabstop=2 shiftwidth=2 
autocmd Filetype python    set softtabstop=2 shiftwidth=2
autocmd Filetype perl      set softtabstop=2 shiftwidth=2
autocmd FileType scheme    set softtabstop=2 shiftwidth=2 tabstop=2
autocmd Filetype changelog set softtabstop=4 shiftwidth=4 tabstop=4
autocmd Filetype tex       set softtabstop=2 shiftwidth=2


" Changelog timeformat "{{{2
let g:changelog_timeformat="%Y-%m-%d"

" Options {{{2
"set number
set ambiwidth=double
set autoindent
set backspace=indent,eol,start
set backupdir=~/tmp,/tmp
set cursorline
set directory=~/tmp,/tmp
set expandtab
set foldmethod=marker
set formatoptions=tcroqMm
set hlsearch
set ignorecase
set imdisable
set incsearch
set laststatus=2
set modeline
set modelines=5
set ruler
set showcmd
set showtabline=2
set smartindent
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L
set ttimeoutlen=50
set vb t_vb=
set wildmenu

" Tabline, by kana {{{2
function! s:set_tabline()
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let curbufnr = bufnrs[tabpagewinnr(i)-1]
    let no = (i <=10 ? i-1 : '#') " tab number is started 0, like screen
    let mod = len(filter(bufnrs, 'getbufvar(v:val, "&mod")')) ? '+' : ' '
    let title = fnamemodify(bufname(curbufnr), ':t')
    let title = len(title) ? title : '[No name]'
    let cur = fnamemodify(bufname(curbufnr), ':p:h') == getcwd() ? '@' : '*'

    let s .= '%' . i . 'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= ' ' . no . mod . title . '[' . cur . ']' . ' '
    let s .= '%#TabLineFill#'
  endfor

  let s .= '%#TabLineFill#%T'
  let s .= '%=%#TabLine#%999X'
  "let branch_name = s:get_branch_name(getcwd())
  "let s .= '[' . (branch_name != '' ? branch_name : '') . ']'
  return s
endfunction

function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

let &tabline = '%!' . s:SID() . 'set_tabline()'




" Keymaping "{{{1
"inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
inoremap <C-b> <LEFT>
inoremap <C-f> <RIGHT>
inoremap <Leader>df  <C-r>=strftime('%Y-%m-%d %H:%M:%S')<Return>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>
cnoremap <C-b> <LEFT>
cnoremap <C-f> <RIGHT>
nnoremap [Space]w :<C-u>write<Return>
nnoremap [Space]q :<C-u>quit<Return>
nnoremap <silent> [Space]fb :<C-u>FuzzyFinderBuffer<Return>
nnoremap <silent> [Space]ff :<C-u>FuzzyFinderFile<Return>
nnoremap <silent> [Space]fd :<C-u>FuzzyFinderDir<Return>
nnoremap <silent> [Space]fr :<C-u>FuzzyFinderRenewCache<Return>
nnoremap [Space]ss :<C-u>source $MYVIMRC<Return>
nnoremap [Space]cd :<C-u>TabpageCD<Return>
nnoremap  j gj
nnoremap  k gk
noremap <silent> <C-z>  :<C-u>SuspendWithAutomaticCD<Return>
noremap <C-h> :<C-u>help<Space>
noremap : ;
noremap ; :
noremap ' `
noremap ` '

" auto complete parentheses "{{{2
""inoremap { {}<LEFT>
""inoremap [ []<LEFT>
""inoremap ( ()<LEFT>
""inoremap " ""<LEFT>
""inoremap ' ''<LEFT>
""vnoremap { "zdi^V{<C-R>z}<ESC>
""vnoremap [ "zdi^V[<C-R>z]<ESC>
""vnoremap ( "zdi^V(<C-R>z)<ESC>
""vnoremap " "zdi^V"<C-R>z^V"<ESC>
""vnoremap ' "zdi'<C-R>z'<ESC>
""inoremap <C-h> <BS>

" tag jump, by kana "{{{2
nnoremap tt <C-]>
vnoremap tt <C-]>
nnoremap <silent>tj :<C-u>tag<Return>
nnoremap <silent>tk :<C-u>pop<Return>
nnoremap <silent>tl :<C-u>tags<Return>
nnoremap <silent>tn :<C-u>tnext<Return>
nnoremap <silent>tp :<C-u>tprevious<Return>
nnoremap <silent>tP :<C-u>tfirst<Return>
nnoremap <silent>tN :<C-u>tlast<Return>

" tabpage motion, by kana "{{{2
nnoremap <silent> <C-t>n :<C-u>tabnew<Return>
nnoremap <silent> <C-t>c :<C-u>tabclose<Return>
nnoremap <silent> <C-t>o :<C-u>tabonly<Return>
nnoremap <silent> <C-t>j :<C-u>tabnext<Return>
nnoremap <silent><C-t>k :<C-u>tabprevious<Return>
nnoremap <silent><C-t>p
\ :<C-u>execute 'tabnext ' . g:pre_tabnr<Return>
nnoremap <silent><C-t>K :<C-u>tabfirst<Return>
nnoremap <silent><C-t>J :<C-u>tablast<Return>
nnoremap <silent><C-t>l
\ :<C-u>execute 'tabmove' min([tabpagenr()+v:count1-1, tabpagenr('$')])<Return>
nnoremap <silent><C-t>h
\ :<C-u>execute 'tabmove' max([tabpagenr()-v:count1-1, 0])<Return>
nnoremap <silent><C-t>L :<C-u>tabmove<Return>
nnoremap <silent><C-t>H :<C-u>tabmove 0<Return>

for i in range(10)
  execute 'nnoremap <silent>' ('<C-t>'.(i))  ((i+1).'gt')
endfor
unlet i

" quickfix, by kana "{{{2
nnoremap q <Nop>

nnoremap qj :<C-u>cnext<Return>
nnoremap qk :<C-u>cprevious<Return>
nnoremap qr :<C-u>crewind<Return>
nnoremap qJ :<C-u>clast<Return>
nnoremap qK :<C-u>cfirst<Return>
nnoremap qfj :<C-u>cnfile<Return>
nnoremap qfk :<C-u>cpfile<Return>
nnoremap ql :<C-u>clist<Return>
nnoremap qq :<C-u>cc<Return>
nnoremap qo :<C-u>copen<Return>
nnoremap qc :<C-u>cclose<Return>
nnoremap qp :<C-u>colder<Return>
nnoremap qn :<C-u>cnewer<Return>
nnoremap qg :<C-u>vimgrep 

" smartword setting "{{{2
map w <Plug>(smartword-w)
map b <Plug>(smartword-b)
map e <Plug>(smartword-e)
map ge <Plug>(smartword-ge)
noremap ,w w
noremap ,b b
noremap ,e e
noremap ,ge ge

" Color Syntax "{{{1
syntax on
set background=dark
hi Comment     ctermfg=blue
hi Pmenu       cterm=underline ctermbg=black
hi PmenuSel    ctermbg=blue
hi Visual      ctermfg=gray
hi TabLineSel  ctermbg=gray ctermfg=black
hi TabLineFill cterm=underline ctermbg=black ctermfg=white




" Others "{{{1
" set screen title "{{{2
"function! SetScreenTabName(name)
"  let arg = 'k' . a:name . '\\'
"  silent! exe '!echo -n "' . arg . "\""
"endfunction
"
"if &term =~ "screen"
"  autocmd VimLeave * call SetScreenTabName('** free **')
"  autocmd BufEnter * 
"  \   if bufname ("") !~ "^\[A-Za-z0-9\]*://" 
"  \ |   call SetScreenTabName("%") 
"  \ | endif
"endif

" memorize previous tabpage number "{{{2
" Enter the new tabpage, action is defined follow:
"     WinLeave
"     TabLeave
"     TabEnter
"     WinEnter
"     BufLeave
"     BufEnter
" when switching to another tab page, the action order is:
"     BufLeave
"     WinLeave
"     TabLeave
"     TabEnter
"     WinEnter
"     BufEnter
" If you want to get more infomation, see ':help tabpage'
if !exists('g:pre_tabnr')
  let g:pre_tabnr = tabpagenr()
endif
if !exists('g:cur_tabnr')
  let g:cur_tabnr = tabpagenr()
endif

autocmd MyAutoCmd TabLeave *
\ let g:pre_tabnr = g:cur_tabnr
autocmd MyAutoCmd TabEnter *
\ let g:cur_tabnr = tabpagenr()

" quickrun.vim: definition of quicklaunch commands "{{{2
let g:quicklaunch_commands = [
  \ 'rake',
  \ 'ls -a',
  \ 'ls -l',
  \ 'wc -l ~/.vimrc'
  \]


" to keep current directory for each tab page, by kana - " http://github.com/kana/config/tree/master/vim/dot.vimrc {{{2
command! -nargs=0 TabpageCD
\   let t:cwd = fnamemodify(expand('%'), ':p:h')
\ | execute 'cd ' . fnameescape(t:cwd)

autocmd MyAutoCmd TabEnter *
\   if !exists('t:cwd')
\ |   let t:cwd = fnamemodify(expand('%'), ':p:h')
\ | endif
\ | execute 'cd ' . fnameescape(t:cwd)

" suspend automatic cd with screen, by kana "{{{2
command! -bar -nargs=0 SuspendWithAutomaticCD
\ call s:PseudoSuspendWithAutomaticCD()

if !exists('s:gnu_screen_available_p')
  let s:gnu_screen_available_p = len($WINDOW) != 0
endif

function! s:PseudoSuspendWithAutomaticCD()
  if s:gnu_screen_available_p
    silent execute '!screen -X eval'
    \              '''select work'''
    \              '''stuff "  cd \"'.getcwd().'\"  \015"'''
    redraw!
    let s:gnu_screen_available_p = (v:shell_error == 0)
  endif

  if !s:gnu_screen_available_p
    suspend
  endif
endfunction

" edit encoding commadns, by kana "{{{2
command! -bang -bar -complete=file -nargs=? Utf8
\ edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Eucjp
\ edit<bang> ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Cp932
\ edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp
\ edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Jis  Iso2022jp<bang> <args>
command! -bang -bar -complete=file -nargs=? Sjis  Cp932<bang> <args>

" check highlighing {{{2
command! -nargs=0 GetHighlightingGroup
\ echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<' . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'

set secure

" __END__ "{{{1
" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker
