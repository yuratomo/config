if &compatible
  set nocompatible
endif

set runtimepath+=~/.nvim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.nvim/dein'))
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/vinarise')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('yuratomo/ltools.vim')
call dein#add('yuratomo/w3m.vim')
call dein#add('yuratomo/gmail.vim')
call dein#add('yuratomo/neosnippet-defines')
call dein#add('vimwiki/vimwiki')
call dein#add('itchyny/calendar.vim')
call dein#add('majutsushi/tagbar')
call dein#add('LeafCage/yankround.vim')
call dein#add('landaire/deoplete-swift')
call dein#add('kballard/vim-swift')
call dein#add('keith/swift.vim')
call dein#add('thinca/vim-quickrun')
call dein#add('altercation/vim-colors-solarized')
call dein#add('zebult/xcode.vim')
call dein#end()

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"---------------------------------------------------------------------------
" setting
"---------------------------------------------------------------------------
set visualbell
set number
set incsearch hlsearch
set list
set nowrap
set showcmd
set noet ts=4 sw=4
set noscrollbind
set listchars=tab:>\ ,extends:<,trail:_,eol:~
set smartindent
set wildmenu
set wildmode=list:longest
set formatoptions+=mM
set hidden
set autoread
set laststatus=2
set cmdheight=1
set nobackup
set noswapfile
set complete=.,w,b,u
set tags+=tags;
set concealcursor=n
set nocursorline
set completeopt=menuone
set helplang=ja,en
set shortmess& shortmess+=I
set textwidth=0
set statusline=%f%m%#S1#\ %<%{expand('%:p:h')}%=%#S2#\ 
let &statusline .= '%{exists("b:git_branch") ?  "[" . b:git_branch . "]" : ""}'
let &statusline .= "%6{(&fenc!=''?&fenc:&enc)}\ %#S3#%6{&ff}\ %#S4#%6{&ft}%#S5#%4l-%-3c"
set undodir=~/.vim/undo/
set pumheight=20
"set iminsert=2
set imsearch=-1
set backspace=indent,eol,start
set encoding=utf-8
set fencs=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,utf-16le,utf-16,default
set ambiwidth=double
set background=dark
color solarized
scriptencoding utf-8

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

"---------------------------------------------------------------------------
" autocommand
"---------------------------------------------------------------------------
augroup MyAutoCmd
au!
au BufEnter * CdCurrent

au FileType vim        set sw=2 ts=2 sts=2 et
au FileType c,cpp      set sw=4 ts=4 sts=4 noet 
au FileType java       set sw=4 ts=4 sts=4 noet
au FileType json       set sw=2 ts=2 sts=2 et
au FileType cs         set sw=4 ts=4 sts=4 et   fmr=#region,#endregion fdm=marker
au FileType javascript set sw=2 ts=2 sts=2 et
au FileType html       set sw=2 ts=2 sts=2 et
au FileType xaml       set sw=4 ts=4 sts=4 et
au FileType xml        set sw=2 ts=2 sts=2 et
au FileType php        setl omnifunc=phpapi#complete
au FileType php        inoremap <expr> <c-down> phpapi#nextRef()
au FileType php        inoremap <expr> <c-up>   phpapi#prevRef()
au FileType perl       setl omnifunc=perlapi#complete
au FileType perl       inoremap <expr> <c-down> perlapi#nextRef()
au FileType perl       inoremap <expr> <c-up>   perlapi#prevRef()

au BufNewFile,BufRead *.build   setf ant
au BufNewFile,BufRead *.targets setf xml
au BufNewFile,BufRead *.config  setf xml
au BufNewFile,BufRead *.*proj   setf xml
au BufNewFile,BufRead *.as      setf java
au BufNewFile,BufRead *.mxml    setf xml
au BufNewFile,BufRead *.xaml    setf xaml

" 最後に編集した位置に移動する
au BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

au BufRead,BufEnter * call MapForQuickFix()

"---------------------------------------------------------------------------
" keymaps
"---------------------------------------------------------------------------

" like a emacs
inoremap <c-f> <RIGHT>
inoremap <c-b> <LEFT>
inoremap <c-d> <DELETE>
inoremap <c-a> <HOME>
inoremap <c-e> <END>
cnoremap <c-p> <UP>
cnoremap <c-n> <DOWN>
cnoremap <c-f> <RIGHT>
cnoremap <c-b> <LEFT>
cnoremap <c-a> <HOME>
cnoremap <c-e> <END>
cnoremap <c-d> <DELETE>
cnoremap <C-K> <C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>
cnoremap <c-v> <c-r>*
cnoremap <c-q> <c-f>

" turn off IME when leave insert mode
inoremap <ESC> <ESC>
inoremap <C-[> <ESC>

" quick nohlsearch
noremap <Esc><Esc> :nohlsearch<CR><Esc>

" like a browser
nnoremap <space>   <C-D>M
nnoremap <s-space> <C-U>M

" like a visual studio
inoremap <expr> <c-y>   pumvisible()?"\<c-y>":"\<c-x>\<c-o>\<c-p>"
inoremap <expr> <CR>    pumvisible()?"\<c-y>":"\<c-g>u\<CR>"
inoremap <expr> <TAB>   pumvisible()?"\<c-n>":"\<TAB>"
inoremap <expr> <s-TAB> pumvisible()?"\<c-p>":"\<s-TAB>"
inoremap <c-space> <c-x><c-o><c-p>

if has('gui')
  " resize window
  nnoremap <A-n> :execute 'set lines=' . (&lines + 10)<CR>
  nnoremap <A-p> :execute 'set lines=' . (&lines - 10)<CR>
  nnoremap <A-f> :execute 'set columns=' . (&columns + 20)<CR>
  nnoremap <A-b> :execute 'set columns=' . (&columns - 20)<CR>

  " move window
  nnoremap <expr><A-j> MoveWindow(0,40)
  nnoremap <expr><A-k> MoveWindow(0,-40)
  nnoremap <expr><A-h> MoveWindow(-40,0)
  nnoremap <expr><A-l> MoveWindow(40,0)
  function! MoveWindow(w,h)
    silent redir => pos
      winpos
    redir end
    let parts = split(pos, "[: ,]")
    let w = parts[-4]
    let h = parts[-1]
    silent exec ':winpos ' . (w+a:w) . ' ' . (h+a:h)
  endfunction
endif

" like a windows clipboard (<c-c> and <c-v>)
vnoremap <c-c> "*y
if has("virtualedit")
  nnoremap <silent> <SID>Paste :call <SID>Paste()<CR>
  func! <SID>Paste()
    let ove = &ve
    set ve=all
    normal `^"+gPi
    let &ve = ove
  endfunc
  inoremap <script> <C-V> x<BS><Esc><SID>Pastegi
else
  inoremap <script> <C-V> x<Esc><SID>Paste"_s
endif

" find word under the cursor
nnoremap + <right>?<c-r><c-w><cr><c-o><left>

" quick open xxx
nnoremap \vv :<c-u>QuickOpen vimrc<RETURN>
nnoremap \tt :<c-u>TagbarToggle<RETURN>
nnoremap \gg :<c-u>Grep 
nnoremap \gc :<c-u>GrepCancel<RETURN>
nnoremap \mm :<c-u>Lmru<RETURN>
nnoremap \oo :<c-u>Loutline<RETURN>
nnoremap \bb :<c-u>Lbookmark<RETURN>
nnoremap \ba :<c-u>LRegistBookmark<RETURN>
nnoremap \qq :<c-u>Lquick<RETURN>
nnoremap \cc :<c-u>sp<RETURN>:<c-u>terminal<RETURN>

command! -nargs=1 QuickOpen    :call QuickOpen(<f-args>)
let s:show_quick_mode = {
  \ 'shell' : { 'bufname':'dbg-1',      'cmd':':DbgShell'                 },
  \ 'filer' : { 'bufname':'Lfiler-1',   'cmd':':Lfiler'                   },
  \ 'vimrc' : { 'bufname':'_vimrc',     'cmd':'edit ' . expand('<sfile>') },
  \ }

" select last edit
nnoremap gc  `[v`]

"---------------------------------------------------------------------------
" Plugin settings
"---------------------------------------------------------------------------

" w3m
let g:w3m#homepage = 'http://www.google.co.jp/'

" gmail.vim
let g:gmail_user_name = 'yura.tomo@gmail.com'
let g:gmail_mailbox_trash = "[Gmail]/ゴミ箱"
"let g:gmail_show_log_window = 1

" ltools
let g:Lmru_max_count = 10000

" Laltfile
let g:Laltfile_mapping = []
call add(g:Laltfile_mapping, {'SL.xaml$'        : '.xaml.cs'  } )
call add(g:Laltfile_mapping, {'\.xaml.cs$'      : 'WPF.xaml'  } )
call add(g:Laltfile_mapping, {'WPF.xaml$'       : 'SL.xaml'   } )
call add(g:Laltfile_mapping, {'.mxml$'          : 'Cntl.as'   } )
call add(g:Laltfile_mapping, {'Cntl.as$'        : '.mxml'     } )

" Lfiler
let g:loaded_netrwPlugin = "v140"

" yankround.vim
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 50

" neosnipet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
let g:neosnippet#snippets_directory = '~/.vim/plugged/neosnippet-defines/snippets/'

" quickrun
" normalモードで \r で実行
let g:quickrun_config = {}
let g:quickrun_config['swift'] = {
\ 'command': 'xcrun',
\ 'cmdopt': 'swift',
\ 'exec': '%c %o %s',
\}

" deopleteの自動補完on
let g:deoplete#enable_at_startup = 1
" swiftの自動補完on
let g:deoplete#sources#swift#daemon_autostart = 1

" brew 
" brew install sourcekitten

"---------------------------------------------------------------------------
" Convenient scripts
"---------------------------------------------------------------------------

" バッファ変更時にカレントディレクトリに移動する
command! -nargs=0 CdCurrent :call CdCurrent()
function! CdCurrent()
  try
    cd %:p:h
  catch /.*/
  endtry
endfunc

" 2つの範囲のdiffをとる
command! -nargs=0 -range DiffClip <line1>, <line2>:call DiffClip('0')
function! DiffClip(reg) range
  exe "let @a=@" . a:reg
  exe a:firstline  . "," . a:lastline . "y b"
  new
  set buftype=nofile bufhidden=wipe
  put a
  diffthis
  vnew
  set buftype=nofile bufhidden=wipe
  put b
  diffthis 
endfunction

" 変更前と変更中のバッファのdiffをとる
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" タグファイル更新
command! -nargs=* -complete=dir UpdateTags  :call UpdateTags(<f-args>)
function! UpdateTags(...)
  let pwd  = expand('%:p:h')
  if a:0 == 0
    let path = GetRoot()
  else
    let path = a:1
  endif
  exe 'cd ' . path
  let ext = expand('%:p:e')
  if ext ==? 'php'
    silent exe ':!start /MIN ctags -ex -f %:p:h/tags --langmap="php:+.inc" -h ".php.inc" -R --totals=yes --tag-relative=yes --PHP-kinds=+cf-v %:p:h<CR>' . path
  elseif ext ==? 'as'
    silent exe ":!start /MIN ctags -R --languages=actionscript " . path
  else
    silent exe ":!start /MIN ctags -R --cs-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q " . path
  endif
  exe 'cd ' . pwd
endfunction

" <c-r>rでルートディレクトリ補完
cnoremap <c-r>r <C-R>=GetRoot()<CR>

" 現在時刻表示
command! -nargs=0 Now  : echo strftime("%Y/%b/%d %X")

" コマンドモードで現在バッファファイル名を補完
cnoremap <C-X> <C-R>=<SID>GetBufferFileName()<CR>
function! s:GetBufferFileName()
  let path = expand('%:p')
  return path
endfunction

" ビジュアルモード選択した部分を*で検索
vnoremap * "zy:let @/ = @z<CR>n

" クリップボードにカレントファイル名をコピー
command! -nargs=0 Gp let @* = expand('%:p')
cabbrev gp Gp

" クリップボードにカレントフォルダをコピー
command! -nargs=0 Gd let @* = expand('%:p:h')
cabbrev gd Gd

" クリップボードのファイルを開く
command! -nargs=0 Sd exec 'edit '. @*
cabbrev sd Sd

" クイック表示
function! QuickOpen(mode)
  if bufexists(s:show_quick_mode[a:mode].bufname)
    if bufname('%') == s:show_quick_mode[a:mode].bufname
      b #
    else
      exe 'b ' . s:show_quick_mode[a:mode].bufname
    endif
  else
    exec s:show_quick_mode[a:mode].cmd
  endif
endfunction

" 矩形選択のI,A
vnoremap <expr> I  <SID>force_blockwise_visual('I')
vnoremap <expr> A  <SID>force_blockwise_visual('A')
function! s:force_blockwise_visual(next_key)
  if mode() ==# 'v'
    return "\<C-v>" . a:next_key
  elseif mode() ==# 'V'
    return "\<C-v>0o$" . a:next_key
  else  " mode() ==# "\<C-v>"
    return a:next_key
  endif
endfunction

"カーソル行をBOLD、入力モードでBOLD解除、他のウィンドウでカーソル解除
if 0 && has('syntax')
  augroup InsertHook
    autocmd! InsertHook
    autocmd InsertEnter      * hi CursorLine guibg=NONE gui=NONE
    autocmd InsertLeave      * hi CursorLine guibg=NONE gui=BOLD
    autocmd InsertEnter      * hi CursorLineNr guifg=BLUE  guibg=WHITE gui=BOLD
    autocmd InsertLeave      * hi CursorLineNr guifg=WHITE guibg=BLUE  gui=NONE
    autocmd WinLeave         * setl nocursorline
    autocmd WinEnter,BufRead * setl cursorline
  augroup END
endif

" 今開いているウィンドウを新しいタブで開きなおす
command! OpenNewTab  :call OpenNewTab()
function! OpenNewTab()
  let l:f = expand("%:p")
  if winnr('$') != 1 || tabpagenr('$') != 1
    execute ":q"
    execute ":tabnew ".l:f
  endif
endfunction

" 非同期Grep
" sln/makefile/bupld.xmlなどがあるルートディレクトリ取得
let s:base_files = [
\ 'Makefile',
\ 'makefile',
\ 'build.xml',
\ '*.sln',
\ '*.mak',
\ 'package.json',
\ 'tags',
\ ]
command! -nargs=* Grep  :call GrepRootNvim(<f-args>)

function! GrepRootNvimTest(...)
  "let cmd = ['terminal', 'rg', '--vimgrep', '--no-heading']
  let cmd = ['!', 'rg', '--vimgrep', '--no-heading']
  call extend(cmd, a:000)
  sp
  exec join(cmd, ' ') . '| tee ~/.vimquickfix'
endfunc

function! GrepRootNvim(...)
  sp +wincmd\ p
  term rg --vimgrep --no-heading vim -tvim | tee ~/.vimquick && nvr -c "cfile ~/.vimquick" -c "copen" -c 'call feedkeys("\<ESC>")'
  wincmd p
  call feedkeys("\<ESC>")
endfunction
function! GrepRootNvim2(...)
  let root = GetRoot()
  let s:callbacks = {
  \ 'on_stdout': function('s:GrepHandler'),
  \ 'on_stderr': function('s:GrepHandler'),
  \ 'on_exit': function('s:GrepHandler')
  \ }
  let cmd = ['rg', '--vimgrep', '--no-heading']
  call extend(cmd, a:000)
  let s:grep_async_job = jobstart(cmd, extend({'shell': 'shell 1'}, s:callbacks))

  let s:grep_async_count = 0
  call s:grep_async_update_status('[grep:start]')
  let s:grep_async_timer_id = timer_start(2000, function("s:grep_async_timer"), { "repeat" : -1 })
endfunction
function! s:GrepHandler(job_id, data, event) dict
  if a:event == 'stdout'
    call s:grep_async_handler(a:job_id, join(a:data))
  elseif a:event == 'stderr'
    call s:grep_async_err_handler(a:job_id, join(a:data))
  else
    call s:grep_async_exit_handler(a:job_id, 'finish')
  endif
endfunction

function! GrepRoot(...)
  let root = GetRoot()
  let param = [a:1]
  if root == ''
    call extend(param, map(a:000[1:], '"**/" . v:val'))
  else
    call extend(param, map(a:000[1:], 'root . "/**/" . v:val'))
  endif
  call GrepAsync(param)
endfunction

function! GetRoot()
  let param = ''
  let find = 0
  let cnt = 10
  while cnt > 0
    let pwd  = expand('%:p:h' . param)
    if strlen(pwd) == 1 || ( strlen(pwd) == 3 && pwd[1] == ':') 
      break
    endif
    for f in s:base_files
      let file = expand(pwd . '/' . f)
      if filereadable(file)
        let find = 1
        break
      endif
    endfor
    if find == 1
     break
    endif
    let param .= ':h'
    let cnt -= 1
  endwhile
  if find == 1
    return expand("%:p:h" . param)
  endif
  return ''
endfunction

function! GrepAsync(arg)
  call GrepCancel()
  call setqflist([])
  if has('win32')
    let cmd = ['jvgrep', '--exclude', "\\.git\\.i\\.cs|\\.g\\.cs|\\.svs|\\.git|\\.hg|\\.obj"]
  else
    let cmd = ['grep', '-nr']
  endif
  call extend(cmd, a:arg)
  let s:grep_async_count = 0
  "let s:grep_async_job = job_start( cmd, {'out_cb': function('s:grep_async_handler'), 'exit_cb':function('s:grep_async_exit_handler')})
          "\ 'grep -nr vim * --include "*.vim"',
  let s:grep_async_job = job_start(
          \ '/bin/sh --help',
          \ {
          \'out_io': 'null',
          \'out_name': '/tmp/aaaa',
          \'out_cb': function('s:grep_async_handler'),
          \'err_cb': function('s:grep_async_err_handler'),
          \'exit_cb': function('s:grep_async_exit_handler')
          \})
  call s:grep_async_update_status('[grep:start]')

  let s:grep_async_timer_id = timer_start(2000, function("s:grep_async_timer"), { "repeat" : -1 })
endfunction
function! s:grep_async_err_handler(ch, msg) abort
  "echoerr a:msg
endfunction
function! s:grep_async_handler(ch, msg) abort
  if s:grep_async_count == 0
    copen
    call cursor('$', 0)
    let s:grep_async_buf = bufnr('%')
  endif

  caddexpr a:msg
  let s:grep_async_count += 1
  call s:grep_async_update_status('[grep:' . s:grep_async_count . ']')

  if s:grep_async_buf == bufnr('%')
    if line('.') + 1 >= line('$')
      call cursor('$', 0)
    endif
  endif
endfunction

command! -nargs=0 GrepCancel  :call GrepCancel()
function! GrepCancel()
  if exists('s:grep_async_job')
    call job_stop(s:grep_async_job)
    call s:grep_async_update_status('[grep:canceled]')
    if exists('s:grep_async_timer_id')
      call timer_stop(s:grep_async_timer_id)
    endif
    redrawstatus
  endif
endfunction

function! g:GrepAsyncStatus()
  return s:grep_async_status
endfunction

function! s:grep_async_timer(timer)
  redrawstatus!
endfunction

function! s:grep_async_exit_handler(job, status)
  if s:grep_async_job == a:job
    call s:grep_async_update_status('[grep:fin]')
    if exists('s:grep_async_timer_id')
      call timer_stop(s:grep_async_timer_id)
    endif
    caddexpr '-- finish --'
    if s:grep_async_count == 0
      copen
    endif
    redrawstatus
  endif
endfunction

let s:grep_async_status = ''
function! s:grep_async_update_status(msg)
  let s:grep_async_status = a:msg
endfunction

function! s:disp(timer)
    echo "callback"
endfunction

" QuickFixウィンドウだけのマップ
function! MapForQuickFix()
  if &buftype=="quickfix"
    nnoremap <buffer> <s-j>  j<CR>:<c-U>LflagClear<CR>:<c-U>Lflag<CR>:<c-u>wincmd p<CR>
    nnoremap <buffer> <s-k>  k<CR>:<c-U>LflagClear<CR>:<c-U>Lflag<CR>:<c-u>wincmd p<CR>
    nnoremap <buffer> <s-CR> <CR>:<c-U>LflagClear<CR>:<c-U>Lflag<CR>:<c-u>wincmd p<CR>
  endif
endfunction

" 別ウィンドウで開く
command! -nargs=0 OpenNewWindow :silent !start gvim %

" フォントズーム
nmap + :ZoomFont 1<CR>
nmap - :ZoomFont -1<CR>
command! -narg=1 ZoomFont    :call s:ZoomFont(<f-args>)
function! s:ZoomFont(w)
  if !has('gui_running')
    return
  endif
  let go = &guioptions
  let fsize = substitute(&guifont, '^.*:h\([^:]*\).*$', '\1', '') + a:w
  let guifont = substitute(&guifont, ':h\([^:]*\)', ':h' . fsize, '')
  let &guifont = guifont
  if stridx(go, 'C') != -1
    if has('win32') | simalt ~x | endif
  else
    exe 'set lines=' . (&lines * (fsize-a:w)) / fsize
    exe 'set columns=' . (&columns * (fsize-a:w)) / fsize
  endif
endfunction

" git branch => vim statusline
command! -nargs=0 GitBranch :call GitBranch()
function! GitBranch()
  let dir = expand('%:p:h')
  let branch = ""
  if isdirectory(dir)
    try
      let r = system('cd ' . dir . ' && git symbolic-ref HEAD 2> /dev/null')
      if r != "" && v:shell_error == 0
        let branch = split(r,"/")[-1][:-2]
        echo join(systemlist('git branch'), ' ')
      endif
    catch /.*/
    endtry
  endif
  let b:git_branch = branch
endfunction

" git checkout
command! -nargs=1 -complete=customlist,GitBranchList GitCheckout :call GitCheckout(<f-args>)
function! GitCheckout(branch)
  let res = system('git checkout ' . substitute(a:branch, '\*', '', ''))
  if v:shell_error == 0
    let b:git_branch = substitute(a:branch, '\*', '', '')
  else
	echo res
  endif
endfunction
function! GitBranchList(A, L, P)
  let items = []
  let branchees = systemlist('git branch')
  if v:shell_error != 0
    echo join(branchees, ' ')
    return []
  endif
  for item in branchees
    if item[2:] =~ '^'.a:A
      call add(items, substitute(item, ' ',  '', 'g'))
    endif
  endfor
  return items
endfunction

" git log/diff/blame
command! -nargs=* GitLog :call GitCommand('git log --graph --stat --date=short --decorate=full ', 'vb', 1, <f-args>)
command! -nargs=* GitLogOneLine :call GitCommand('git log --graph --date=short --pretty=format:"%h %ad %an %s %d" ', 'vb', 1, <f-args>)
command! -nargs=* GitDiff :call GitCommand('git diff ', 'diff', 0, <f-args>)
command! -nargs=* GitBlame :call GitCommand('git blame ', '', 0, <f-args>)
function! GitCommand(cmd, filetype, iconv, ...)
  let ft = &filetype
  if &buftype == 'nofile'
    let path = expand('%:p:h')
  else
    let path = expand('%:p')
  endif
  let lines = systemlist(a:cmd . join(a:000, ' ') . ' ' . path)
  if v:shell_error == 0
    if len(lines) > 0
      new +setl\ buftype=nofile\ bufhidden=delete\ noswf\ nowrap\ hidden\ nolist
      if a:iconv == 1
        call setline(1,map(lines, 'iconv(v:val, "utf-8", &enc)'))
      else
        call setline(1,lines)
      endif
      setl nomodifiable
      if a:filetype == ''
        exec 'setl filetype=' . ft
      else
        exec 'setl filetype=' . a:filetype
      endif
    else
      echo 'no outputs'
    endif
  else
    echo join(lines, ' ')
  endif
endfunction

finish

brew install neovim/neovim/neovim
brew install python3
brew install neovim
brew install peco
brew install ctags
brew install w3m
brew install ripgrep
pip3 install neovim-remote
