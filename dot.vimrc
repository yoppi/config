" Prologue "{{{1
set nocompatible

" set $PATH
let $PATH = $HOME.'/local/bin:'. $HOME.'/dev/bin:' . $HOME.'/.rbenv/shims:' . $PATH

" Story teller and casts "{{{1
call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/linediff.vim'
Plug 'LeafCage/yankround.vim'
Plug 'Shougo/neocomplete'
Plug 'Shougo/vimproc'
Plug 'Shougo/vimshell'
Plug 'cakebaker/scss-syntax.vim'
Plug 'fatih/vim-go'
Plug 'fatih/vim-hclfmt'
Plug 'fuenor/qfixhowm'
Plug 'gregsexton/gitv'
Plug 'h1mesuke/vim-alignta'
Plug 'hukl/Smyck-Color-Scheme'
Plug 'itchyny/lightline.vim'
Plug 'kana/vim-fakeclip'
Plug 'kana/vim-smartchr'
Plug 'kana/vim-smartinput'
Plug 'kana/vim-smartword'
Plug 'kchmck/vim-coffee-script'
Plug 'kien/ctrlp.vim'
Plug 'lepture/vim-velocity'
Plug 'mattn/webapi-vim'
Plug 'mhinz/vim-startify'
Plug 'motemen/hatena-vim'
Plug 'noahfrederick/vim-hemisu'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'rking/ag.vim'
Plug 'rosstimson/scala-vim-support'
Plug 'scrooloose/nerdtree'
Plug 'slim-template/vim-slim'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-ref'
Plug 'tomasr/molokai'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/CSApprox'
Plug 'vim-scripts/Source-Explorer-srcexpl.vim'
Plug 'vim-scripts/VimClojure'
Plug 'vim-scripts/nginx.vim'
Plug 'vim-scripts/pdc.vim'
Plug 'yoppi/errormarker.vim'
Plug 'yoppi/perl5lib'
Plug 'yoppi/vim-tabpagecd'

call plug#end()

" start! my .vimrc
augroup MyAutoCmd
  autocmd!
augroup END

" Auto encoding discrimination "{{{1
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

" Options {{{2
"set number
set ambiwidth=double
set autoindent
set backspace=indent,eol,start
set backupcopy=yes
set backupdir=~/tmp,/tmp
"set cursorline
set directory=~/tmp,/tmp
"set expandtab
set fileformat=unix
set fileformats=unix,dos
set foldmethod=manual
set formatoptions=tcroqMm
if exists('+fuoptions')
  set fuoptions=maxvert,maxhorz
endif
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif
if exists('+guicursor')
  set guicursor=a:blinkwait5000-blinkon2500-blinkwait1250
endif
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
set imsearch=0
set incsearch
set laststatus=2
set list
set listchars=tab:>.
set modeline
set modelines=5
set mouse=
set ruler
set showcmd
set showtabline=2
set shellslash
set smartindent
set splitbelow
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L
set ttimeoutlen=50
if exists('+transparency')
  "set transparency=10
endif
set t_Co=256
set undodir=~/tmp,/tmp
set vb t_vb=
set virtualedit+=block
set wildmenu
set wrap
if has('unix') || has('win32') || has('win64')
  set noimdisable
endif


" Filetype "{{{1
filetype plugin indent on
autocmd FileType c,cpp setlocal expandtab softtabstop=4 shiftwidth=4 tabstop=8
autocmd FileType changelog setlocal expandtab softtabstop=4 shiftwidth=4 tabstop=4
autocmd FileType coffee setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType cs setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType cucumber setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType eruby setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType html,markdown,pdc setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType jade setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType java setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType javascript setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType json setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType objc setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType perl setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType php setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType python setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType ruby setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType scheme setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2
autocmd FileType sh setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2
autocmd FileType sql setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType tex setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType vim setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType xml setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType yaml setlocal expandtab softtabstop=2 shiftwidth=2


" Keymaping "{{{1
" <Leader>
let mapleader = ","

map <Space> [Space]
noremap [Space] <nop>

nnoremap <Leader>ss :<C-u>source $MYVIMRC<Return>

" My working Debian cannot recognize <C-h> as BackSpace in insert mode on
" screen.
let ostype = system("echo $OSTYPE")
if ostype =~ "linux"
  imap <C-h> <BS>
endif
unlet ostype

inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <expr> <Leader>df  strftime("%Y-%m-%d %H:%M:%S")
inoremap <expr> <Leader>dd  strftime("%Y-%m-%d")
inoremap <expr> <Leader>dt  strftime("%H:%M:%S")
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>
inoremap <C-l> <ESC>

cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
cnoremap <C-l> <C-c>
cnoremap <C-x> <C-r>=<SID>GetBufferDirectory()<Return>/
function! s:GetBufferDirectory()
  let path = expand('%:p:h')
  let cwd = getcwd()
  if match(path, cwd) != 0
    return path
  elseif strlen(path) > strlen(cwd)
    return strpart(path, strlen(cwd) + 1)
  else
    return '.'
  endif
endfunction

nnoremap [Space]w :<C-u>write<Return>
nnoremap [Space]q :<C-u>quit<Return>
nnoremap [Space]cd :<C-u>CD<Return>

" rails.vim
nnoremap [rails] <Nop>
nmap [Space]r [rails]
nnoremap [rails]v :<C-u>RVview<Return>
nnoremap [rails]c :<C-u>Rcontroller<Space>
nnoremap [rails]m :<C-u>Rmodel<Space>
nnoremap [rails]h :<C-u>Rhelper<Space>
nnoremap [rails]i :<C-u>Rinitializer<Space>
nnoremap [rails]l :<C-u>Rlocale<Space>
nnoremap [rails]e :<C-u>Renvironment<Space>
nnoremap [rails]s :<C-u>Rschema<Return>

" fugitive.vim
nnoremap [git] <Nop>
nmap [Space]g [git]
nnoremap [git]c :<C-u>Gcommit<Return>
nnoremap [git]d :<C-u>Gdiff<Return>
nnoremap [git]s :<C-u>Gvsplit :<Return>
nnoremap [git]e :<C-u>Gedit :<Return>
nnoremap [git]b :<C-u>Gblame<Return>

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
nnoremap <Tab> <C-w>p


noremap <silent> <C-z>  :<C-u>SuspendWithAutomaticCD<Return>
noremap <C-h> :<C-u>help<Space>
noremap : ;
noremap ; :
noremap ' `
noremap ` '

" visual-search
vnoremap * y/<C-R>"<Return>
vnoremap <C-l> <ESC>
vnoremap <C-S-c> "+y

nnoremap K <Nop>
nnoremap K :silent! grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


" tag jump "{{{2
nnoremap [tag] <Nop>
nmap t [tag]
nnoremap [tag]t <C-]>
vnoremap [tag]t <C-]>
nnoremap <silent>[tag]j :<C-u>tag<Return>
nnoremap <silent>[tag]k :<C-u>pop<Return>
nnoremap <silent>[tag]l :<C-u>tags<Return>
nnoremap <silent>[tag]n :<C-u>tnext<Return>
nnoremap <silent>[tag]p :<C-u>tprevious<Return>
nnoremap <silent>[tag]P :<C-u>tfirst<Return>
nnoremap <silent>[tag]N :<C-u>tlast<Return>

" tabpage motion, by kana "{{{2
nnoremap <silent> <C-t>n :<C-u>tabnew<Return>
nnoremap <silent> <C-t>c :<C-u>tabclose<Return>
nnoremap <silent> <C-t>o :<C-u>tabonly<Return>
nnoremap <silent> <C-t>j :<C-u>tabnext<Return>
nnoremap <silent> <C-Tab> :<C-u>tabnext<Return>
nnoremap <silent><C-t>k :<C-u>tabprevious<Return>
nnoremap <silent><C-S-Tab> :<C-u>tabprevious<Return>
nnoremap <silent><C-t>p :<C-u>TabPreWork<Return>
nnoremap <silent><C-t>K :<C-u>tabfirst<Return>
nnoremap <silent><C-t>J :<C-u>tablast<Return>
nnoremap <silent><C-t>l :<C-u>execute 'tabmove' min([tabpagenr()+v:count1-1+1, tabpagenr('$')])<Return>
nnoremap <silent><C-t>h :<C-u>execute 'tabmove' max([tabpagenr()-v:count1-1, 0])<Return>
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
nnoremap qg :<C-u>vimgrep<Space>

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
syntax enable

set background=dark
colorscheme hemisu

autocmd MyAutoCmd ColorScheme *
\   hi Comment term=bold ctermfg=blue guifg=#707070
\ | hi Pmenu ctermbg=8 guibg=#606060
\ | hi PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
\ | hi PmenuSbar ctermbg=0 guibg=#d6d6d6
\ | hi Visual ctermfg=lightgray
\ | hi TabLine ctermbg=gray ctermfg=black guibg=gray guifg=black
\ | hi TabLineSel ctermbg=black ctermfg=white
\ | hi TabLineFill ctermbg=black ctermfg=white
\ | hi Normal guibg=grey5
doautocmd MyAutoCmd ColorScheme * _


" Vim Plugin Settings "{{{1

" neocomplete.vim "{{{2
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction

inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" vim-go "{{{2
let g:go_fmt_command = 'goimports'
let g:go_list_type = 'quickfix'
let g:go_def_mode = 'guru'
let g:go_info_mode = 'gocode'
let g:go_updatetime = 800
let g:go_jump_to_error = 1
let g:go_gocode_autobuild = 0

" NERDTree "{{{2
nnoremap <silent> [Space]o :<C-u>:NERDTreeToggle <C-r>=getcwd()<Return><Return>


" vimshell "{{{2
nnoremap [Space]s :<C-u>VimShellPop <C-r>=getcwd()<Return><Return>

let g:vimshell_user_prompt ='fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt = "$ "
let g:vimshell_enable_smart_case = 1

autocmd FileType vimshell call s:vimshell_settings()
function! s:vimshell_settings()
  " Aliases
  call vimshell#altercmd#define('la', 'ls -a')
  call vimshell#altercmd#define('ll', 'ls -l')
  call vimshell#altercmd#define('ltr', 'ls -altr')
  call vimshell#altercmd#define('g', 'git')
  call vimshell#altercmd#define('a', 'git add')
  call vimshell#altercmd#define('b', 'git branch')
  call vimshell#altercmd#define('d', 'git diff')
  call vimshell#altercmd#define('l', 'git log')
  call vimshell#altercmd#define('lg', 'git log --graph')
  call vimshell#altercmd#define('s', 'git status -sb')
  call vimshell#altercmd#define('v', 'vim')
  call vimshell#altercmd#define('h', 'hg')
  call vimshell#altercmd#define('hs', 'hg status')
  call vimshell#altercmd#define('hd', 'hg diff')
  call vimshell#altercmd#define('r', 'rails')
endfunction


" quickrun.vim "{{{2
let g:quicklaunch_commands = [
  \ 'rake',
  \ 'ls -a',
  \ 'ls -l',
  \ 'wc -l ~/.vimrc'
  \]


" changelog.vim "{{{2
let g:changelog_timeformat="%Y-%m-%d"


" vimclojure "{{{2
let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = "ng"


" qfixhowm "{{{2
let QFixHowm_Key = 'g'
let QFixHowm_FileType = 'markdown'
let QFixMRU_Filename = '~/Dropbox/howm/.qfixmru'
let howm_dir = '~/Dropbox/howm'
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.md'
let howm_fileencoding = 'utf-8'
let howm_fileformat = 'unix'


" lightline "{{{2
let g:lightline = {
        \ 'enable': { 'tabline': 0 },
        \ }


" yankround.vim "{{{2
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
" 履歴取得数
let g:yankround_max_history = 50
" 履歴一覧(kien/ctrlp.vim)
nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>


" ctrlp.vim "{{{2
let g:ctrlp_show_hidden = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:15'
let g:ctrlp_custom_ignore = { 'dir': '\v[\/]\.(git|hg|svn)$' }
let g:ctrlp_mruf_max = 1000
let g:ctrlp_prompt_mappings = {
  \ 'PrtBS()': ['<c-h>', '<bs>'],
  \ 'PrtCurLeft()': ['<left>', '<c-^>'],
  \ }

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

nnoremap [ctrlp] <Nop>
nmap f [ctrlp]
nnoremap <silent> [ctrlp]b :<C-u>CtrlPBookmarkDir<Return>
nnoremap <silent> [ctrlp]f :<C-u>CtrlP<Return>
nnoremap <silent> [ctrlp]m :<C-u>CtrlPMRUFiles<Return>


" Others "{{{1
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

" remove the last spaces of lines "{{{2
command! -bar DeleteLastSpacesEachLine %s/\s\+$//e
function! s:DeleteLastSpacesEachLine()
  let save_cursor = getpos('.')
  DeleteLastSpacesEachLine
  call setpos('.', save_cursor)
endfunction

" check highlighing {{{2
command! -nargs=0 GetHighlightingGroup
\ echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<' . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'

" auto buffer update {{{2
function! s:AutoUpdate()
  if expand('%') =~ s:savebuf_regex && !&readonly && &buftype == ''
    silent update
  endif
endfunction

autocmd MyAutoCmd CursorHold * nested call s:AutoUpdate()
autocmd MyAutoCmd BufWritePre * call s:DeleteLastSpacesEachLine()
set updatetime=500
if !exists('s:savebuf_regex')
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


" change current directory {{{2
command! -nargs=? -complete=dir -bang CD call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute ' lcd ' . a:directory
  endif
  if a:bang == ''
    pwd
  endif
endfunction


" git-brwose-remote {{{2
command! -nargs=* -range GitBrowseRemote !git browse-remote --rev -L<line1>,<line2> <f-args> -- %


" Epilogue {{{1
set secure

" __END__ "{{{1
" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker
