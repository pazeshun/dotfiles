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
nnoremap <F5> :set hlsearch!<CR>
set whichwrap=<,>,[,]

" Visualize tab and white space of EOL
set list
set listchars=tab:>-,trail:-

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
Plug 'https://github.com/pazeshun/conque.vim.git'
"" fugitive.vim
Plug 'https://github.com/tpope/vim-fugitive.git'
"" lightline.vim
Plug 'https://github.com/itchyny/lightline.vim.git'
call plug#end()

" Color scheme
syntax on
colorscheme peachpuff

" Settings for lightline.vim
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
let g:lightline ={
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
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

" Settings for conque.vim
"" Completion in conque for Lisp
autocmd FileType conque_term setl iskeyword=38,42,43,45,47-58,60-62,64-90,97-122,_,+,-,*,/,%,<,=,>,:,$,?,!,@-@,94
autocmd FileType conque_term inoremap <buffer> <S-tab> <C-p>
autocmd FileType conque_term imap <silent> <buffer> <F8> <Esc>:<C-u>call <SID>SendCompletionToConque()<CR>
function! s:SendCompletionToConque()
  " Get most recent/relevant terminal
  let term = conque_term#get_instance()
  " Go to terminal buffer
  call term.focus()
  " Send Completion text
  call term.write(@.)
endfunction

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
