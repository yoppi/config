" misc. "{{{1
set nocompatible

augroup MyAutoCmd
  autocmd!
augroup END

" auto encoding discrimination "{{{2
set encoding=utf-8
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'

  " Does iconv support JIS X 0213 ?
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  " Make fileencodings
  let &fileencodings = 'ucs-bom'
  if &encoding !=# 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'ucs-2le'
    let &fileencodings = &fileencodings . ',' . 'ucs-2'
  endif

  if &fileencodings ==# 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'cp932'
  elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    let &encoding = s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'cp932'
  else
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
    let &fileencodings = &fileencodings . ',' . s:enc_jis
  endif
  let &fileencodings = &fileencodings . ',' . &encoding

  unlet s:enc_euc
  unlet s:enc_jis
endif

let mapleader = ","

map <Space> [Space]
noremap [Space] <nop>

" Load Vim plugins from pathogen "{{{2
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Filetype "{{{2
filetype plugin indent on
autocmd Filetype c,cpp     set softtabstop=4 shiftwidth=4 tabstop=8
autocmd Filetype ruby      set softtabstop=2 shiftwidth=2
autocmd Filetype python    set softtabstop=2 shiftwidth=2
autocmd Filetype perl      set softtabstop=2 shiftwidth=2
autocmd FileType scheme    set softtabstop=2 shiftwidth=2 tabstop=2
autocmd Filetype changelog set softtabstop=4 shiftwidth=4 tabstop=4
autocmd Filetype tex       set softtabstop=2 shiftwidth=2

" vim-users.jp; Hack#96 - to enable omni complete on any language
autocmd Filetype *
\   if &omnifunc == ""
\ |   setlocal omnifunc=syntaxcomplete#Complete
\ | endif

" Options {{{2
"set number
set ambiwidth=double
set autoindent
set backspace=indent,eol,start
set backupcopy=yes
set backupdir=~/tmp,/tmp
"set cursorline
set directory=~/tmp,/tmp
set expandtab
set fileformat=unix
set foldmethod=marker
set formatoptions=tcroqMm
if exists('+fuoptions')
  set fuoptions=maxvert,maxhorz
endif
if exists('+guicursor')
  set guicursor=a:blinkwait5000-blinkon2500-blinkwait1250
endif
if exists('+guifont')
  if has('gui_macvim')
    set guifont=Bitstream\ Vera\ Sans\ Mono:h14
  elseif (has('win32') || has('win64')) && has('gui_running')
    set guifont=Bitstream\ Vera\ Sans\ Mono:h11
  elseif has('unix') && has('gui_running')
    set guifont=DejaVu\ Sans\ Mono\ 11
  endif
endif
if exists('+guifontwide')
  if has('gui_macvim')
    set guifontwide=HiraMaruPro-W4:h14
  elseif has('win32') || has('win64')
    set guifontwide=MS_Gothic:h11
  endif
endif
if exists('+guioptions')
  if has('gui_macvim') || has('win32') || has('win64')
  "set guioptions=cMg
    set guioptions=cg
  elseif has('unix')
    set guioptions=cgi
  endif
endif
set hlsearch
set ignorecase
set imdisable
if has('gui_macvim')
  set iminsert=0
end
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
if exists('+transparency')
  set transparency=10
endif
set t_Co=256
set vb t_vb=
set virtualedit+=block
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
  let branch_name = s:git_branch_name(getcwd())
  let s .= '[' . (branch_name != '' ? branch_name : '') . ']'
  return s
endfunction

function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

let &tabline = '%!' . s:SID() . 'set_tabline()'




" Keymaping "{{{1
" My working Debian cannot recognize <C-h> as BackSpace in insert mode on
" screen.
let ostype = system("echo $OSTYPE")
if ostype =~ "linux"
  imap <C-h> <BS>
endif
unlet ostype

inoremap <C-b> <LEFT>
inoremap <C-f> <RIGHT>
inoremap <expr> <Leader>df  strftime("%Y-%m-%d %H:%M:%S")
inoremap <expr> <Leader>dd  strftime("%Y-%m-%d")
inoremap <expr> <Leader>dt  strftime("%H:%M:%S")
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>
inoremap <C-l> <ESC>

cnoremap <C-b> <LEFT>
cnoremap <C-f> <RIGHT>
cnoremap <C-l> <C-c>

nnoremap [Space]w :<C-u>write<Return>
nnoremap [Space]q :<C-u>quit<Return>
nnoremap [Space]ss :<C-u>source $MYVIMRC<Return>
nnoremap [Space]cd :<C-u>TabpageCD<Return>
" display lines down /up ward
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" close/open a fold
nnoremap [Space]h zc
nnoremap [Space]l zo
" stop the highliting
nnoremap [Space]/ :<C-u>nohlsearch<Return>


noremap <silent> <C-z>  :<C-u>SuspendWithAutomaticCD<Return>
noremap <C-h> :<C-u>help<Space>
noremap : ;
noremap ; :
noremap ' `
noremap ` '

" visual-search
vnoremap * y/<C-R>"<Return>
vnoremap <C-l> <ESC>


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
nnoremap <silent><C-t>p :<C-u>TabPreWork<Return>
nnoremap <silent><C-t>K :<C-u>tabfirst<Return>
nnoremap <silent><C-t>J :<C-u>tablast<Return>
nnoremap <silent><C-t>l
\ :<C-u>execute 'tabmove' min([tabpagenr()+v:count1-1, tabpagenr('$')])<Return>
nnoremap <silent><C-t>h
\ :<C-u>execute 'tabmove' max([tabpagenr()-v:count1-1, 0])<Return>
nnoremap <silent><C-t>L :<C-u>tabmove<Return>
nnoremap <silent><C-t>H :<C-u>tabmove 0<Return>
nnoremap <silent> <C-w><C-t> :<C-u>MoveWinTab<Return>

for i in range(10)
  execute 'nnoremap <silent>' ('<C-t>'.(i))  ((i+1).'gt')
endfor
unlet i

" quickfix, by kana "{{{2
nnoremap q <Nop>
nnoremap Q q

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


" select last modified text "{{{2
nnoremap gc  `[v`]
vnoremap gc  :<C-u>normal gc<Enter>
onoremap gc  :<C-u>normal gc<Enter>

" Color Syntax "{{{1
syntax on
set background=dark
autocmd MyAutoCmd ColorScheme *
\   hi Comment     ctermfg=blue
\ | hi Pmenu       cterm=underline ctermbg=black guibg=black
\ | hi PmenuSel    ctermbg=blue  guibg=blue
\ | hi Visual      ctermfg=lightgray
\ | hi TabLineSel  ctermbg=gray ctermfg=black
\ | hi TabLineFill cterm=underline ctermbg=black ctermfg=white
\ | hi Normal      guibg=grey5
doautocmd MyAutoCmd ColorScheme * _
if has('gui')
  colorscheme koehler
endif

" Vim Plugin Settings "{{{1
" unite.vim "{{{2
let g:unite_update_time = 100
let g:unite_source_file_mru_limit = 200
let g:unite_source_file_mru_filename_format = ''
let g:unite_source_file_rec_ignore_pattern = '.svn/*'
nnoremap <silent> [Space]ff :<C-u>UniteWithCurrentDir -buffer-name=files file buffer file_mru bookmark<Return>
nnoremap <silent> [Space]fb :<C-u>UniteWithBufferDir -buffer-name=files -prompt=%\  buffer file_mru bookmark file<Return>
nnoremap <silent> [Space]fr :<C-u>Unite file_rec<Return>
nnoremap <silent> [Space]fm :<C-u>Unite file_mru<Return>
nnoremap <silent> [Space]fk :<C-u>Unite bookmark<Return>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings() "{{{3
  nmap <buffer> <C-c> <Plug>(unite_exit)
endfunction


" neocomplcache.vim "{{{2
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
imap <expr><C-o> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>"
smap <expr><C-o> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>"

" rsense.vim "{{{2
let g:rsenseHome = $HOME . "/apps/rsense/rsense-0.3"
" 特にWindowsのgVim環境で使用すると遅すぎて使い物にならないのでUnix環境のみ有
" 効にしている
if has('unix') && !has('win32unix')
  let g:rsenseUseOmniFunc = 1
else
  let g:loaded_rsense = 1
endif

" quickrun.vim: definition of quicklaunch commands "{{{2
let g:quicklaunch_commands = [
  \ 'rake',
  \ 'ls -a',
  \ 'ls -l',
  \ 'wc -l ~/.vimrc'
  \]

" changelog.vim timeformat "{{{2
let g:changelog_timeformat="%Y-%m-%d"


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


" move to previous working tabpage "{{{2
command! -bar -nargs=0 TabPreWork call s:tabprework()
function! s:tabprework()
  " Wrapper for my own built-in command :tabprework.
  if exists(':tabprework') == 2
    execute 'tabprework'
  else
    execute 'tabnext ' . g:pre_tabnr
  endif
endfunction

" memorize previous tabpage number
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

" to keep current directory for each tab page, by kana - " http://github.com/kana/config/tree/master/vim/dot.vimrc {{{2
command! -nargs=? -complete=file TabpageCD
\   execute 'cd ' . fnameescape(<q-args>)
\ | let t:cwd = getcwd()

autocmd MyAutoCmd TabEnter *
\   if !exists('t:cwd')
\ |   let t:cwd = getcwd()
\ | endif
\ | execute 'cd ' . fnameescape(t:cwd)

" suspend automatic cd with screen, by kana "{{{2
command! -bar -nargs=0 SuspendWithAutomaticCD
\ call s:PseudoSuspendWithAutomaticCD()

if !exists('s:gnu_screen_available_p')
  if has('gui_running')
    let s:gnu_screen_available_p = executable('screen')
    "let s:gnu_screen_available_p = s:check_process('screen')
  else
    let s:gnu_screen_available_p = len($WINDOW) != 0
  endif
endif

function! s:PseudoSuspendWithAutomaticCD()
  if s:gnu_screen_available_p
    call s:activate_terminal()

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

function! s:activate_terminal()
  if !has('gui_running')
    return
  endif

  if has('macunix')
    silent !open -a Terminal
  else
    " Not supported
  endif
endfunction

function! s:check_process(name)
  " TODO: to implement plooving result of `ps ax`
  "       I tried to using 'redir => {var}...'. But this aproach is failed.
  "       {var} had '!ps ax | grep a:name'...
  "redir => result
  "  !ps ax | grep a:name
  "redir END
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

" Rename current file, by ujihisa
command! -nargs=1 -complete=file Rename
\   file <args>
\ | call delete(expand('#'))

" remove the spaces end of lines "{{{2
command! -bang -bar -complete=file -nargs=0 DeleteSpaceEachLine
\ execute ':%s/\s\+$//'

" check highlighing {{{2
command! -nargs=0 GetHighlightingGroup
\ echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<' . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'

" auto buffer update {{{2
function! s:AutoUpdate()
  if expand('%') =~ s:savebuf_regex && !&readonly && &buftype == ''
    silent update
  endif
endfunction

autocmd MyAutoCmd CursorHold * call s:AutoUpdate()
set updatetime=500
if !exists('s:savebuf')
  let s:savebuf_regex = '.\+'
endif

" move the current window into specified tab. Thanks kana. {{{2
command! -bar -nargs=0 MoveWinTab call
\ s:move_window_into_tabpage(s:ask_tabpage_number())
function! s:move_window_into_tabpage(target_tabpagenr)
  " Move the current window into a:target_tabpagenr.
  " If a:target_tabpagenr is 0, move into new tabpage.
  if a:target_tabpagenr < 0  " ignore invalid number.
    return
  endif
  let original_tabnr = tabpagenr()
  let target_bufnr = bufnr('')
  let window_view = winsaveview()

  if a:target_tabpagenr == 0
    tabnew
    tabmove  " Move new tabpage at the last.
    execute target_bufnr 'buffer'
    let target_tabpagenr = tabpagenr()
  else
    execute a:target_tabpagenr 'tabnext'
    let target_tabpagenr = a:target_tabpagenr
      " FIXME: be customizable?
    execute 'topleft' target_bufnr 'sbuffer'
  endif
  call winrestview(window_view)

  execute original_tabnr 'tabnext'
  if 1 < winnr('$')
    close
  else
    enew
  endif

  execute target_tabpagenr 'tabnext'
endfunction

function! s:ask_tabpage_number()
  echon 'Which tabpage to move this window into?  '

  let c = nr2char(getchar())
  if c =~# '[0-9]'
    " Convert 0-origin number (typed by user) into 1-origin number (used by
    " Vim's internal functions).  See also 'tabline'.
    return 1 + char2nr(c) - char2nr('0')
  elseif c =~# "[\<C-c>\<Esc>]"
    return -1
  else
    return 0
  endif
endfunction

" Git branch name "{{{2
let s:_git_branch_name_cache = {} " dir_path = [branch_name, key_file_mtime]

function! s:git_branch_name(dir)
  let cache_entry = get(s:_git_branch_name_cache, a:dir, 0)
  if cache_entry is 0
  \ || cache_entry[1] < getftime(s:_git_branch_name_keyfile(a:dir))
    unlet cache_entry
    let cache_entry = s:_git_branch_name(a:dir)
    let s:_git_branch_name_cache[a:dir] = cache_entry
  endif

  return cache_entry[0]
endfunction

function! s:_git_branch_name_keyfile(dir)
  return a:dir . '/.git/HEAD'
endfunction

function! s:_git_branch_name(dir)
  let head_file = s:_git_branch_name_keyfile(a:dir)
  let branch_name = ''

  if filereadable(head_file)
    let ref_info = s:first_line(head_file)
    if ref_info =~ '^\x\{40}$'
      let remote_refs_dir = a:dir . '/.git/refs/remotes/'
      let remote_branches = split(glob(remote_refs_dir . '**'), "\n")
      call filter(remote_branches, 's:first_line(v:val) ==# ref_info')
      if 1 <= len(remote_branches)
        let branch_name = 'remote: ' . remote_branches[0][len(remote_refs_dir):]
      endif
    else
      let branch_name = matchlist(ref_info, '^ref: refs/heads/\(\S\+\)$')[1]
      if branch_name == ''
        let branch_name = ref_info
      endif
    endif
  endif

  return [branch_name, getftime(head_file)]
endfunction

function! s:first_line(file)
  let lines = readfile(a:file, '', 1)
  return 1 <= len(lines) ? lines[0] : ''
endfunction
" Epilogue {{{1
set secure

" __END__ "{{{1
" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker
