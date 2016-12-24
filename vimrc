" Indent and tab settings
set smartindent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set smarttab
filetype plugin indent on

" Encoding settings
set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

" Other basic settings
set number
"set clipboard=unnamed
set incsearch
nnoremap <F4> :set hlsearch!<CR>
set whichwrap=<,>,[,]
set wildmenu
set wildmode=list:longest,full

" Visualize tab and white space of EOL
set list
set listchars=tab:>-,trail:-

" DiffOrig command
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

" Netrw setting
let g:netrw_keepdir = 0

" Plugins managed by vim-plug
call plug#begin('~/.vim/plugged')
"" vim-ros
Plug 'https://github.com/taketwo/vim-ros.git'
"" vim-operator-user
Plug 'https://github.com/kana/vim-operator-user.git'
"" vim-clang-format
Plug 'https://github.com/rhysd/vim-clang-format.git'
"" previm
Plug 'https://github.com/kannokanno/previm.git'
"" open-browser.vim
Plug 'https://github.com/tyru/open-browser.vim.git'
"" conque.vim
Plug 'https://github.com/pazeshun/conque.vim.git', { 'branch': 'pazeshun' }
"" fugitive.vim
Plug 'https://github.com/tpope/vim-fugitive.git'
"" lightline.vim
Plug 'https://github.com/itchyny/lightline.vim.git'
"" vimproc.vim
Plug 'https://github.com/Shougo/vimproc.vim.git', {'do' : 'make'}
"" vim_goshrepl
Plug 'https://github.com/aharisu/vim_goshrepl.git'
"" AnsiEsc.vim
Plug 'https://github.com/pazeshun/AnsiEsc.vim.git'
call plug#end()

" Color scheme
syntax on
colorscheme peachpuff

" diff settings
set diffopt+=vertical
"" Change highlight colors
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

" Popup menu settings
highlight PmenuSel ctermfg=255 ctermbg=2
highlight PmenuThumb ctermbg=2

" Settings for lightline.vim
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
let g:lightline ={
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component': {
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }

" Settings for vim-clang-format
let g:clang_format#command = "clang-format-3.6"
let g:clang_format#detect_style_file = 1
autocmd FileType c,cpp map <buffer> = <Plug>(operator-clang-format)

" Settings for vim_goshrepl
"" Common function
function! s:SendCtrlCToREPL()
  call ieie#execute("\<C-c>", bufnr("%"), 0)
endfunction
"" roseus
function! Open_roseus(...)
  if a:0 == 0
    let l:proc = 'roseus'
  else
    let l:proc = 'roseus ' . a:1
  endif
  call ieie#open_interactive({
        \ 'caption'  : 'roseus',
        \ 'filetype' : 'lisp',
        \ 'buffer-open' : ':rightbelow split',
        \ 'proc'     : l:proc,
        \ 'pty'      : 1,
        \})
  "" Unmap <C-p> and <C-n> in insert mode
  iunmap <buffer><silent> <C-p>
  iunmap <buffer><silent> <C-n>
  "" Map <Up> and <Down> to searching history in insert mode
  imap <buffer><silent> <Up> <Plug>(ieie_line_replace_history_prev)
  imap <buffer><silent> <Down> <Plug>(ieie_line_replace_history_next)
  "" Map <C-c> in insert and normal mode
  nnoremap <buffer><silent> <C-c> :call <SID>SendCtrlCToREPL()<CR>
  inoremap <buffer><silent> <C-c> <C-o>:call <SID>SendCtrlCToREPL()<CR>
  "" Display ANSI color
  AnsiEsc
endfunction
command! -nargs=? -complete=file Roseus :call Open_roseus(<f-args>)
command! -nargs=0 RoseusThis :call Open_roseus(expand("%:p"))
autocmd FileType lisp vmap <buffer> <F9> :call ieie#send_text_block(function('Open_roseus'), 'roseus')<CR>
"" python
function! Open_python(...)
  if a:0 == 0
    let l:proc = 'python'
  else
    let l:proc = 'python -i ' . a:1
  endif
  call ieie#open_interactive({
        \ 'caption'  : 'python',
        \ 'filetype' : 'python',
        \ 'buffer-open' : ':rightbelow split',
        \ 'proc'     : l:proc,
        \ 'pty'      : 1,
        \})
  "" Unmap <C-p> and <C-n> in insert mode
  iunmap <buffer><silent> <C-p>
  iunmap <buffer><silent> <C-n>
  "" Map <Up> and <Down> to searching history in insert mode
  imap <buffer><silent> <Up> <Plug>(ieie_line_replace_history_prev)
  imap <buffer><silent> <Down> <Plug>(ieie_line_replace_history_next)
  "" Map <C-c> in insert and normal mode
  nnoremap <buffer><silent> <C-c> :call <SID>SendCtrlCToREPL()<CR>
  inoremap <buffer><silent> <C-c> <C-o>:call <SID>SendCtrlCToREPL()<CR>
endfunction
command! -nargs=? -complete=file Python :call Open_python(<f-args>)
command! -nargs=0 PythonThis :call Open_python(expand("%:p"))
autocmd FileType python vmap <buffer> <F9> :call ieie#send_text_block(function('Open_python'), 'python')<CR>

" Settings for conque.vim
let g:ConqueTerm_Color = 2
"let g:ConqueTerm_ReadUnfocused = 1
"" Completion in conque for Lisp
autocmd FileType conque_term setl iskeyword=38,42,43,45,47-58,60-62,64-90,97-122,_,+,-,*,/,%,<,=,>,:,$,?,!,@-@,94
autocmd FileType conque_term setl completeopt+=menuone
autocmd FileType conque_term inoremap <expr> <buffer> <C-p> pumvisible() ? "\<Up>" : "\<C-p><C-n>"
autocmd FileType conque_term inoremap <expr> <buffer> <C-n> pumvisible() ? "\<Down>" : "\<C-p><C-n>"
autocmd FileType conque_term inoremap <expr> <silent> <buffer> <C-y> pumvisible() ?
      \ "\<C-p><C-n><Esc>:<C-u>call <SID>SendCompletionToConque()<CR>" :
      \ ('<C-o>:py ' . b:ConqueTerm_Var . '.write_ord(25)<CR>')
autocmd FileType conque_term inoremap <expr> <silent> <buffer> <C-e> pumvisible() ?
      \ "\<C-e>" :
      \ ('<C-o>:py ' . b:ConqueTerm_Var . '.write_ord(5)<CR>')
function! s:SendCompletionToConque()
  " Get most recent/relevant terminal
  let term = conque_term#get_instance()
  " Go to terminal buffer
  call term.focus()
  " Send Completion text
  call term.write(@.)
endfunction

"" Prevent undo/redo
autocmd FileType conque_term nnoremap <silent> <buffer> u <Nop>
autocmd FileType conque_term nnoremap <silent> <buffer> <C-r> <Nop>

"" Command to redraw command line in conque
autocmd FileType conque_term imap <silent> <buffer> <F5> <Esc>l:<C-u>call <SID>RedrawCommandLineInConque()<CR>i
autocmd FileType conque_term nmap <silent> <buffer> <F5> :<C-u>call <SID>RedrawCommandLineInConque()<CR>
function! s:RedrawCommandLineInConque()
  let l:before_update_pos = getpos(".")
  " Enter <Up>
  sil exe ':py ' . b:ConqueTerm_Var . '.write(u("\x1b[A"))'
  " Enter <Down>
  sil exe ':py ' . b:ConqueTerm_Var . '.write(u("\x1b[B"))'
  let b:insert_pos = getpos(".")
  call <SID>MoveInsertCursor(l:before_update_pos)
endfunction

"" To insert(only in Linux)
autocmd FileType conque_term setl whichwrap+=h,l
function! s:CountPosDiff(from, to)
  " Get window width
  let npos = getpos(".")
  let virtualedit_bak = &l:virtualedit
  let &l:virtualedit = "all"
  normal! g$
  let win_width = virtcol(".")
  let &l:virtualedit = virtualedit_bak
  call setpos(".", npos)
  return (a:to[1] - a:from[1]) * win_width + a:to[2] - a:from[2]
endfunction
autocmd FileType conque_term inoremap <silent> <buffer> <Esc> <Esc>l:let b:insert_pos = getpos(".")<CR>h
function! s:MoveInsertCursor(pos)
  let move_c = <SID>CountPosDiff(b:insert_pos, a:pos)
  let i = 0
  if move_c >= 0
    while i < move_c
      " Enter <Right>
      sil exe ':py ' . b:ConqueTerm_Var . '.write(u("\x1b[C"))'
      let i += 1
    endwhile
  else
    let move_c = -move_c
    while i < move_c
      " Enter <Left>
      sil exe ':py ' . b:ConqueTerm_Var . '.write(u("\x1b[D"))'
      let i += 1
    endwhile
  endif
  let b:insert_pos = a:pos
endfunction
autocmd FileType conque_term nnoremap <silent> <buffer> i :<C-u>call <SID>MoveInsertCursor(getpos("."))<CR>i
autocmd FileType conque_term nnoremap <silent> <buffer> a l:<C-u>call <SID>MoveInsertCursor(getpos("."))<CR>i
autocmd FileType conque_term nnoremap <silent> <buffer> I ?$ <CR>ll:<C-u>call <SID>MoveInsertCursor(getpos("."))<CR>i
autocmd FileType conque_term nnoremap <silent> <buffer> A G$:<C-u>call <SID>MoveInsertCursor(getpos("."))<CR>i

"" To delete chars from normal and visual mode in conque(only in Linux)
function! s:EraceCharsInConque(head, tail)
  call setpos(".", a:head)
  normal! ma
  call setpos(".", a:tail)
  normal! l
  let tail_r = getpos(".")
  normal! y`a
  call <SID>MoveInsertCursor(tail_r)
  let i = 0
  let char_num = <SID>CountPosDiff(a:head, tail_r)
  while i < char_num
    " Enter <BS>
    sil exe ':py ' . b:ConqueTerm_Var . '.write(u("\x08"))'
    let i += 1
  endwhile
  let b:insert_pos = a:head
  call <SID>RedrawCommandLineInConque()
endfunction
""" x in normal mode
autocmd FileType conque_term nmap <silent> <buffer> x :<C-u>call <SID>EraceCharOnCursorInConque()<CR>
function! s:EraceCharOnCursorInConque()
  call <SID>RedrawCommandLineInConque()
  let head = getpos(".")
  let tail = head
  call <SID>EraceCharsInConque(head, tail)
endfunction
""" X in normal mode
autocmd FileType conque_term nmap <silent> <buffer> X :<C-u>call <SID>EraceCharLeftCursorInConque()<CR>
function! s:EraceCharLeftCursorInConque()
  call <SID>RedrawCommandLineInConque()
  normal! h
  let head = getpos(".")
  let tail = head
  call <SID>EraceCharsInConque(head, tail)
endfunction
""" dw and de in normal mode
autocmd FileType conque_term nmap <silent> <buffer> dw :<C-u>call <SID>EraceOneWordInConque(1)<CR>
autocmd FileType conque_term nmap <silent> <buffer> de :<C-u>call <SID>EraceOneWordInConque(0)<CR>
function! s:EraceOneWordInConque(with_space)
  call <SID>RedrawCommandLineInConque()
  let head = getpos(".")
  if a:with_space
    normal! wh
    let tail = getpos(".")
  else
    normal! e
    let tail = getpos(".")
  endif
  call <SID>EraceCharsInConque(head, tail)
endfunction
""" d$ in normal mode
autocmd FileType conque_term nmap <silent> <buffer> d$ :<C-u>call <SID>EraceToEndInConque()<CR>
function! s:EraceToEndInConque()
  call <SID>RedrawCommandLineInConque()
  let head = getpos(".")
  normal! G$
  if getline(".")[col(".") - 1] == " "
    normal! h
    let tail = getpos(".")
  else
    let tail = getpos(".")
  endif
  call <SID>EraceCharsInConque(head, tail)
endfunction
""" dd in normal mode
autocmd FileType conque_term nmap <silent> <buffer> dd :<C-u>call <SID>EraceOneLineInConque()<CR>
function! s:EraceOneLineInConque()
  call <SID>RedrawCommandLineInConque()
  sil exe "normal! ?$ \<cr>ll"
  let head = getpos(".")
  normal! G$
  if getline(".")[col(".") - 1] == " "
    normal! h
    let tail = getpos(".")
  else
    let tail = getpos(".")
  endif
  call <SID>EraceCharsInConque(head, tail)
endfunction
""" d in visual mode
autocmd FileType conque_term vmap <silent> <buffer> d :<C-u>call <SID>EraceSelectedCharsInConque()<CR>
function! s:EraceSelectedCharsInConque()
  call <SID>RedrawCommandLineInConque()
  normal! `<
  let head = getpos(".")
  normal! `>
  let tail = getpos(".")
  call <SID>EraceCharsInConque(head, tail)
endfunction

"" To paste chars from normal mode in conque(only in Linux)
autocmd FileType conque_term nnoremap <expr> <silent> <buffer> P ':<C-u>call <SID>MoveInsertCursor(getpos("."))<CR>:py '
      \ . b:ConqueTerm_Var . '.write_expr("@@")<CR>:let b:insert_pos = getpos(".")<CR>'
      \ . ':<C-u>call <SID>RedrawCommandLineInConque()<CR>'
autocmd FileType conque_term nnoremap <expr> <silent> <buffer> p 'l:<C-u>call <SID>MoveInsertCursor(getpos("."))<CR>:py '
      \ . b:ConqueTerm_Var . '.write_expr("@@")<CR>:let b:insert_pos = getpos(".")<CR>'
      \ . ':<C-u>call <SID>RedrawCommandLineInConque()<CR>'

"" Show matching brace in conque for Lisp
autocmd FileType conque_term setl showmatch

" Settings for C/C++
autocmd FileType c,cpp setl cindent
autocmd FileType cpp setl cinoptions=i-s,N-s,g0

" Settings for Python
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
"autocmd FileType python setl nocindent

" Settings for Lisp
let g:lisp_rainbow = 1
autocmd FileType lisp setl nocindent
autocmd FileType lisp setl lisp
autocmd FileType lisp setl showmatch
autocmd FileType lisp setl tabstop=8 expandtab shiftwidth=2 softtabstop=2

" Settings for Makefile
autocmd FileType make setl noexpandtab
